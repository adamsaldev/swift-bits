"""Check the publishing contract, especially isolated embeds and portable paths."""
from html.parser import HTMLParser
import json
from pathlib import Path
import re
import subprocess
import unittest

ROOT = Path(__file__).resolve().parents[2]
PUBLIC = ROOT / 'Preview/public'


class Document(HTMLParser):
    def __init__(self, text):
        super().__init__()
        self.ids = []
        self.frames = []
        self.feed(text)

    def handle_starttag(self, tag, attrs):
        attrs = dict(attrs)
        if 'id' in attrs:
            self.ids.append(attrs['id'])
        if tag == 'iframe':
            self.frames.append(attrs)


class PreviewBuildTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        subprocess.run(['python3', str(ROOT / 'scripts/build_previews.py')], check=True)
        cls.catalog = json.loads((PUBLIC / 'catalog.json').read_text())

    def test_every_component_has_a_portable_live_embed_and_swift_assets(self):
        components = self.catalog['components']
        self.assertEqual(len(components), len(list((ROOT / 'Preview/components').glob('*/component.json'))))
        self.assertEqual(self.catalog['schemaVersion'], 1)
        for component in components:
            with self.subTest(component=component['slug']):
                self.assertEqual(component['previewKind'], 'live-html')
                for key in ('previewPath', 'snippetPath', 'sourcePath'):
                    self.assertFalse(component[key].startswith('/'))
                path = PUBLIC / component['previewPath'] / 'index.html'
                preview = path.read_text()
                document = Document(preview)
                self.assertEqual(len(document.ids), len(set(document.ids)))
                refs = re.findall(r"\$\('([^']+)'\)", preview)
                self.assertFalse(set(refs) - set(document.ids), 'Preview depends on another card DOM')
                self.assertNotIn('src="', preview, 'Embed must run without external JavaScript')
                self.assertIn('prefers-reduced-motion', preview)
                self.assertEqual((PUBLIC / component['snippetPath']).read_text(), component['snippet'])
                self.assertEqual((PUBLIC / component['sourcePath']).read_text(), (ROOT / component['source']).read_text())
                script = re.search(r'<script>(.*?)</script>', preview, re.S)[1]
                subprocess.run(['node', '--check'], input=script, text=True, check=True, capture_output=True)

    def test_gallery_uses_same_isolated_previews(self):
        frames = Document((PUBLIC / 'index.html').read_text()).frames
        self.assertEqual(len(frames), len(self.catalog['components']))
        for frame, component in zip(frames, self.catalog['components']):
            self.assertEqual(frame['src'], component['previewPath'] + 'index.html')
            self.assertEqual(frame['sandbox'], 'allow-scripts')
            self.assertTrue(frame['title'])
        subprocess.run(['node', '--check', str(PUBLIC / 'playground.js')], check=True)
        subprocess.run(['node', '--check', str(PUBLIC / 'catalog.js')], check=True)

    def test_rebuild_removes_stale_routes_and_is_deterministic(self):
        before = (PUBLIC / 'catalog.json').read_bytes()
        stale = PUBLIC / 'previews/deleted-component/index.html'
        stale.parent.mkdir(parents=True)
        stale.write_text('obsolete')
        subprocess.run(['python3', str(ROOT / 'scripts/build_previews.py')], check=True)
        self.assertFalse(stale.exists())
        self.assertEqual(before, (PUBLIC / 'catalog.json').read_bytes())


if __name__ == '__main__':
    unittest.main()
