// One confirmation per continuous hold, with an accessible two-activation alternative.
let holdFrame,holding=false,holdDone=false,armed=false,armedTimer,resetTimer;
function resetHold(){clearTimeout(resetTimer);cancelAnimationFrame(holdFrame);holding=false;holdDone=false;$('hold').style.setProperty('--progress',0);$('hold').classList.remove('done');$('hold').textContent='Hold to confirm'}
function completeHold(){holding=false;holdDone=true;armed=false;clearTimeout(armedTimer);$('hold').style.setProperty('--progress',1);$('hold').classList.add('done');$('hold').textContent='✓ Confirmed';$('hold-status').textContent='Action completed.';resetTimer=setTimeout(()=>{resetHold();$('hold-status').textContent='Keep holding for 1.2 seconds.'},1800)}
function cancelHold(){if(holding){resetHold();$('hold-status').textContent='Cancelled. Try holding again.'}}
$('hold').onpointerdown=e=>{if(e.button!==0||holdDone)return;e.preventDefault();armed=false;clearTimeout(armedTimer);holding=true;$('hold').setPointerCapture(e.pointerId);const start=performance.now();$('hold-status').textContent='Keep holding…';function tick(now){if(!holding)return;const p=Math.min(1,(now-start)/1200);$('hold').style.setProperty('--progress',p);if(p===1)completeHold();else holdFrame=requestAnimationFrame(tick)}holdFrame=requestAnimationFrame(tick)};
$('hold').onpointermove=e=>{if(!holding)return;const r=$('hold').getBoundingClientRect();if(e.clientX<r.left||e.clientX>r.right||e.clientY<r.top||e.clientY>r.bottom)cancelHold()};
$('hold').onpointerup=cancelHold;$('hold').onpointercancel=cancelHold;$('hold').onlostpointercapture=cancelHold;
$('hold').onclick=e=>{if(e.detail!==0||holdDone||holding)return;if(armed){completeHold()}else{armed=true;$('hold').textContent='Activate again to confirm';armedTimer=setTimeout(()=>{armed=false;resetHold()},5000)}};
window.addEventListener('blur',()=>{cancelHold();armed=false;clearTimeout(armedTimer);if(!holdDone)resetHold()});
