// Sparks are DOM nodes animated by CSS; reduced motion drops them (see preview.css)
// and this handler simply does nothing visible.
const stage = document.querySelector('.stage');
const SPARKS = 10;
const DISTANCE = 26;

function burst(x, y) {
  if (reduced()) return;
  for (let i = 0; i < SPARKS; i++) {
    const spark = document.createElement('span');
    spark.className = 'spark';
    const angle = (i / SPARKS) * 360;
    spark.style.left = x + 'px';
    spark.style.top = y + 'px';
    spark.style.setProperty('--dist', DISTANCE + 'px');
    spark.style.setProperty('--angle', angle + 'deg');
    spark.addEventListener('animationend', () => spark.remove());
    stage.appendChild(spark);
  }
}

stage.addEventListener('pointerdown', event => {
  const rect = stage.getBoundingClientRect();
  burst(event.clientX - rect.left, event.clientY - rect.top);
});

$('spark').addEventListener('keydown', event => {
  if (event.key !== 'Enter' && event.key !== ' ') return;
  const rect = stage.getBoundingClientRect();
  const target = $('spark').getBoundingClientRect();
  burst(target.left - rect.left + target.width / 2, target.top - rect.top + target.height / 2);
  $('spark-status').textContent = 'Sparked.';
});
