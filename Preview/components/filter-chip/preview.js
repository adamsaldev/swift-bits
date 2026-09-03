'use strict';
const $ = id => document.getElementById(id);
const reduced = () => matchMedia('(prefers-reduced-motion: reduce)').matches;
document.querySelectorAll('.chip-demo button').forEach(button => button.addEventListener('click', () => {
 const selected = button.getAttribute('aria-pressed') !== 'true'; button.setAttribute('aria-pressed', selected);
 button.textContent = (selected ? '✓ ' : '') + button.textContent.replace('✓ ', '');
}));
