
'use strict';
const $=id=>document.getElementById(id), reduced=()=>matchMedia('(prefers-reduced-motion: reduce)').matches;
// Text: replay cancels any previous scramble.
let phraseIndex=0,scrambleFrame;const phrases=['Hello, SwiftBits','Make it move.'];
function scramble(){cancelAnimationFrame(scrambleFrame);const text=phrases[phraseIndex],start=performance.now();$('scramble').setAttribute('aria-label',text);function frame(now){const progress=reduced()?1:Math.min(1,(now-start)/800);$('scramble').textContent=[...text].map((c,i)=>i<text.length*progress||c===' '?c:'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'[Math.floor(Math.random()*36)]).join('');if(progress<1)scrambleFrame=requestAnimationFrame(frame)}scrambleFrame=requestAnimationFrame(frame)}
$('replay').onclick=scramble;$('phrase').onclick=()=>{phraseIndex=1-phraseIndex;scramble()};
// A reel for each numeric place; punctuation stays stationary.
let number=1234.5;
function roll(){const percent=$('format').value==='percent',value=percent?number/10000:number;const text=new Intl.NumberFormat(undefined,{style:percent?'percent':'decimal',minimumFractionDigits:1,maximumFractionDigits:1}).format(value),root=$('rolling');root.setAttribute('aria-label',text);const old=[...root.children];[...text].forEach((c,i)=>{let cell=old[i];if(!cell){cell=document.createElement('span');root.append(cell)}if(/\d/.test(c)){if(!cell.classList.contains('digit')){cell.className='digit';cell.innerHTML='<span class="strip">'+Array.from({length:10},(_,n)=>'<span>'+n+'</span>').join('')+'</span>'}const strip=cell.firstChild;requestAnimationFrame(()=>{strip.style.transform='translateY(-'+Number(c)*1.2+'em)'})}else{cell.className='';cell.textContent=c}cell.setAttribute('aria-hidden','true')});old.slice(text.length).forEach(n=>n.remove())}
$('minus').onclick=()=>{number-=123.4;roll()};$('plus').onclick=()=>{number+=123.4;roll()};$('format').onchange=roll;roll();
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
// Caller-selected result states.
let morphTimer;
function morph(state){const b=$('morph');b.dataset.state=state;b.disabled=state==='loading'||state==='success';b.innerHTML=({idle:'Save changes',loading:'<span class="spinner" aria-hidden="true"></span>Saving…',success:'✓ Saved',failure:'! Try again'})[state];$('morph-status').textContent=({idle:'Ready when you are.',loading:'Saving your changes…',success:'Your changes are saved.',failure:'Something went wrong. You can retry.'})[state]}
$('morph').onclick=()=>{morph('loading');const outcome=$('outcome').value;morphTimer=setTimeout(()=>morph(outcome),1400)};$('morph-reset').onclick=()=>{clearTimeout(morphTimer);morph('idle')};
const spot=$('spotlight');spot.onpointermove=e=>{const r=spot.getBoundingClientRect();spot.style.setProperty('--x',e.clientX-r.left+'px');spot.style.setProperty('--y',e.clientY-r.top+'px');spot.classList.add('active')};spot.onpointerleave=()=>spot.classList.remove('active');spot.onpointerup=e=>{if(e.pointerType!=='mouse')spot.classList.remove('active')};spot.onpointercancel=()=>spot.classList.remove('active');
$('expand-toggle').onclick=()=>{const open=$('expand').classList.toggle('open');$('expand-toggle').setAttribute('aria-expanded',open);$('detail').inert=!open};
$('load-toggle').onclick=()=>{const loading=$('profile').classList.toggle('skeleton');$('profile').setAttribute('aria-label',loading?'Loading profile':'Taylor Morgan. Building something good.');$('load-toggle').setAttribute('aria-pressed',loading);$('load-toggle').textContent=loading?'Show loaded content':'Show skeleton'};
let tab='Feed',collapse=0,switching=false;const offsets={Feed:0,Saved:0};const scroller=$('scroller');
function header(){ $('scroll-head').style.height=90-collapse+'px';$('scroll-subtitle').style.display=collapse>25?'none':''}
function rows(){scroller.replaceChildren(...Array.from({length:18},(_,i)=>{const row=document.createElement('div');row.className='row';row.textContent=(tab==='Feed'?'Inspiration ':'Saved idea ')+String(i+1).padStart(2,'0');const sub=document.createElement('span');sub.textContent=tab==='Feed'?'Explore':'Bookmarked';row.append(sub);return row}))}
scroller.onscroll=()=>{if(switching)return;const y=Math.max(0,scroller.scrollTop);collapse=y===0?0:Math.max(0,Math.min(42,collapse+y-offsets[tab]));offsets[tab]=y;header()};
document.querySelectorAll('[data-tab]').forEach(b=>b.onclick=()=>{if(tab===b.dataset.tab)return;switching=true;offsets[tab]=scroller.scrollTop;tab=b.dataset.tab;rows();scroller.scrollTop=offsets[tab];scroller.setAttribute('aria-label','Scrollable library '+tab.toLowerCase());document.querySelectorAll('[data-tab]').forEach(x=>x.setAttribute('aria-pressed',x===b));if(offsets[tab]===0)collapse=0;header();requestAnimationFrame(()=>{switching=false})});rows();

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
document.querySelectorAll('.filters button').forEach(button => {
    button.addEventListener('click', () => {
        category = button.dataset.category;
        document.querySelectorAll('.filters button').forEach(item => item.setAttribute('aria-pressed', item === button));
        filterComponents();
    });
});
$('component-search').addEventListener('input', filterComponents);
$('clear-filters').addEventListener('click', () => {
    category = 'all';
    $('component-search').value = '';
    document.querySelectorAll('.filters button').forEach(item => item.setAttribute('aria-pressed', item.dataset.category === 'all'));
    filterComponents();
    $('component-search').focus();
});
