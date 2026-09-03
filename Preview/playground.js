'use strict';
const $ = id => document.getElementById(id);
// Search and category filters share one source of truth.
let category = 'all';
const componentCards = [...document.querySelectorAll('article[data-category]')];
function filterComponents() {
    const query = $('component-search').value.trim().toLowerCase();
    let count = 0;
    componentCards.forEach(card => {
        const matches = (category === 'all' || card.dataset.category === category)
            && card.querySelector('.meta').textContent.toLowerCase().includes(query);
        card.hidden = !matches;
        if (matches) count++;
    });
    $('result-count').textContent = `${count} component${count === 1 ? '' : 's'}`;
    $('no-results').hidden = count > 0;
}

$('category-filter').addEventListener('change', () => { category = $('category-filter').value; filterComponents(); });
$('price-filter').addEventListener('change', filterComponents);
$('component-search').addEventListener('input', filterComponents);
$('clear-filters').addEventListener('click', () => {
    category = 'all'; $('category-filter').value = 'all'; $('price-filter').value = 'all';
    $('component-search').value = ''; filterComponents(); $('component-search').focus();
});
document.querySelectorAll('[data-sort]').forEach(button => button.addEventListener('click', () => {
    document.querySelectorAll('[data-sort]').forEach(item => item.setAttribute('aria-pressed', item === button));
    const ordered = button.dataset.sort === 'latest' ? [...componentCards].reverse() : componentCards;
    ordered.forEach(card => document.querySelector('.grid').append(card));
}));
const snippets = Object.fromEntries(window.SWIFTBITS_CATALOG.components.map(component => [component.name, component.snippet]));
let toastTimer;
document.querySelectorAll('.copy-button').forEach(button => button.addEventListener('click', async () => {
 const snippet = snippets[button.dataset.component];
 try {
  if (navigator.clipboard && window.isSecureContext) await navigator.clipboard.writeText(snippet);
  else { const field = document.createElement('textarea'); field.value = snippet; document.body.append(field); field.select(); const copied = document.execCommand('copy'); field.remove(); if (!copied) throw new Error('Copy unavailable'); }
  $('copy-status').textContent = button.dataset.component + ' copied';
 } catch { $('copy-status').textContent = 'Copy unavailable in this browser. Open the Swift source below.'; }
 $('copy-status').hidden = false; clearTimeout(toastTimer); toastTimer = setTimeout(() => { $('copy-status').hidden = true; }, 3000);
}));

filterComponents();
