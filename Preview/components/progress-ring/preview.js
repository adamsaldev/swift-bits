let progress = 72;
$('ring-demo').addEventListener('click', () => { progress = (progress + 14) % 101; $('ring-value').innerHTML = progress + '<span>%</span>'; document.querySelector('.ring-fill').style.strokeDashoffset = 307.88 * (1 - progress / 100); $('ring-demo').setAttribute('aria-label', progress + '% complete. Advance progress'); });
