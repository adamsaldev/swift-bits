#!/usr/bin/env python3
"""Build gallery, live HTML embeds, source, snippets, and catalog with no dependencies."""
import csv
import hashlib
import html
import io
import json
from pathlib import Path
import re
import shutil

ROOT = Path(__file__).resolve().parents[1]
PREVIEW = ROOT / 'Preview'
OUTPUT = PREVIEW / 'public'
CATEGORIES = {'text', 'controls', 'cards', 'layout', 'feedback'}


def load_components():
    components = []
    for folder in sorted((PREVIEW / 'components').iterdir()):
        if not folder.is_dir():
            continue
        metadata = json.loads((folder / 'component.json').read_text())
        slug = metadata['slug']
        if not re.fullmatch(r'[a-z0-9]+(?:-[a-z0-9]+)*', slug) or slug != folder.name:
            raise ValueError(f'Invalid component slug: {folder}')
        if metadata['category'] not in CATEGORIES or metadata['previewKind'] != 'live-html':
            raise ValueError(f'Invalid preview metadata: {slug}')
        if metadata['aspectRatio'] != '4 / 3' or not isinstance(metadata['order'], int):
            raise ValueError(f'Invalid frame or sort order: {slug}')
        for key in ('name', 'description'):
            if not isinstance(metadata[key], str) or not metadata[key].strip():
                raise ValueError(f'Missing {key}: {slug}')
        source = (ROOT / metadata['source']).resolve()
        if not source.is_relative_to(ROOT / 'Sources/SwiftBits') or not source.is_file():
            raise ValueError(f'Missing Swift source: {slug}')
        files = {name: (folder / name).read_text() for name in
                 ('preview.html', 'preview.css', 'preview.js', 'snippet.swift')}
        if not files['preview.html'].strip() or not files['snippet.swift'].strip():
            raise ValueError(f'Empty preview or snippet: {slug}')
        if re.search(r'</?(?:html|head|body)\b', files['preview.html'], re.I):
            raise ValueError(f'preview.html must be a fragment: {slug}')
        components.append((metadata, files, source.read_text()))
    if not components:
        raise ValueError('No components found')
    for key in ('slug', 'name', 'order'):
        values = [metadata[key] for metadata, _, _ in components]
        if len(set(values)) != len(values):
            raise ValueError(f'Duplicate {key}')
    return sorted(components, key=lambda component: component[0]['order'])


APPROX_NOTE = 'Web approximation — the SwiftUI source is authoritative'


def build():
    components = load_components()  # Validate before touching previous build.
    frame_css = (PREVIEW / 'shared/frame.css').read_text()
    harness_js = (PREVIEW / 'shared/harness.js').read_text()
    template = (PREVIEW / 'gallery.html').read_text()
    if template.count('<!-- COMPONENT_CARDS -->') != 1:
        raise ValueError('Gallery must contain exactly one component placeholder')
    catalog = {'schemaVersion': 1, 'components': []}
    pages = {}
    cards = []
    for metadata, files, source in components:
        slug = metadata['slug']
        name = html.escape(metadata['name'], quote=True)
        # Each preview.js runs in its own function scope after the shared harness, so
        # components share `$`/`reduced`/`raf` without re-declaring them and cannot leak
        # globals into one another.
        script = f"{harness_js}\n(() => {{\n{files['preview.js']}\n}})();"
        preview = f'''<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{name} — SwiftBits live preview</title>
<style>{frame_css}\n{files['preview.css']}</style></head>
<body><div class="preview" id="{slug}">{files['preview.html']}</div>
<p class="approx-note" role="note">{APPROX_NOTE}</p>
<script>{script}</script></body></html>
'''
        pages[f'previews/{slug}/index.html'] = preview
        pages[f'snippets/{slug}.swift'] = files['snippet.swift']
        pages[f'sources/{slug}.swift'] = source
        record = {**metadata, 'previewPath': f'previews/{slug}/',
                  'snippetPath': f'snippets/{slug}.swift', 'sourcePath': f'sources/{slug}.swift',
                  'snippet': files['snippet.swift'],
                  'revision': hashlib.sha256(preview.encode()).hexdigest()[:16]}
        catalog['components'].append(record)
        cards.append(f'''<article id="{slug}" data-category="{metadata['category']}" aria-labelledby="title-{slug}">
  <iframe class="preview-frame" src="{record['previewPath']}index.html" title="{name} interactive preview — web approximation of the SwiftUI component" loading="lazy" sandbox="allow-scripts"></iframe>
  <div class="meta"><div><h3 id="title-{slug}">{name}</h3><p>SwiftBits · Free</p></div><button class="copy-button" data-component="{name}" aria-label="Copy {name} SwiftUI snippet">Copy</button></div>
</article>''')
    serialized = json.dumps(catalog, indent=2, ensure_ascii=False)
    pages['catalog.json'] = serialized + '\n'
    pages['catalog.js'] = 'window.SWIFTBITS_CATALOG = ' + serialized + ';\n'
    pages['index.html'] = template.replace('<!-- COMPONENT_CARDS -->', '\n'.join(cards))
    pages['styles.css'] = (PREVIEW / 'styles.css').read_text()
    pages['playground.js'] = (PREVIEW / 'playground.js').read_text()
    pages['.nojekyll'] = ''
    # Relative paths work under GitHub project subpaths and on any static host.
    csv_buffer = io.StringIO()
    fields = ['slug', 'name', 'category', 'description', 'previewPath', 'snippet', 'sourcePath', 'aspectRatio']
    writer = csv.DictWriter(csv_buffer, fieldnames=fields, extrasaction='ignore')
    writer.writeheader()
    writer.writerows(catalog['components'])
    pages['catalog.csv'] = csv_buffer.getvalue()
    # This directory is generated only; remove obsolete component routes on rebuild.
    if OUTPUT.exists():
        shutil.rmtree(OUTPUT)
    for path, content in pages.items():
        destination = OUTPUT / path
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(content)
    print(f'Built {len(components)} live previews in {OUTPUT}')


if __name__ == '__main__':
    build()
