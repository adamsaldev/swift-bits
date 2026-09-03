document.querySelectorAll('.chip-demo button').forEach(button => button.addEventListener('click', () => {
 const selected = button.getAttribute('aria-pressed') !== 'true'; button.setAttribute('aria-pressed', selected);
 button.textContent = (selected ? '✓ ' : '') + button.textContent.replace('✓ ', '');
}));
