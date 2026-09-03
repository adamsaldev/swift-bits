// The sweep is CSS; reduced motion falls back to a static tint via the media query.
const phrases = ['Now shipping', 'Made to shine'];
let index = 0;
$('phrase').onclick = () => {
  index = 1 - index;
  $('shiny').textContent = phrases[index];
  $('shiny').setAttribute('aria-label', phrases[index]);
};
