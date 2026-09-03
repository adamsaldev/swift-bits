// Text: replay cancels any previous scramble.
let phraseIndex=0,scrambleFrame;const phrases=['Hello, SwiftBits','Make it move.'];
function scramble(){cancelAnimationFrame(scrambleFrame);const text=phrases[phraseIndex],start=performance.now();$('scramble').setAttribute('aria-label',text);function frame(now){const progress=reduced()?1:Math.min(1,(now-start)/800);$('scramble').textContent=[...text].map((c,i)=>i<text.length*progress||c===' '?c:'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'[Math.floor(Math.random()*36)]).join('');if(progress<1)scrambleFrame=requestAnimationFrame(frame)}scrambleFrame=requestAnimationFrame(frame)}
$('replay').onclick=scramble;$('phrase').onclick=()=>{phraseIndex=1-phraseIndex;scramble()};

scramble();
