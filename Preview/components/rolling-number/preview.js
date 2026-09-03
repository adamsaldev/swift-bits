'use strict';
const $ = id => document.getElementById(id);
const reduced = () => matchMedia('(prefers-reduced-motion: reduce)').matches;
// A reel for each numeric place; punctuation stays stationary.
let number=1234.5;
function roll(){const percent=$('format').value==='percent',value=percent?number/10000:number;const text=new Intl.NumberFormat(undefined,{style:percent?'percent':'decimal',minimumFractionDigits:1,maximumFractionDigits:1}).format(value),root=$('rolling');root.setAttribute('aria-label',text);const old=[...root.children];[...text].forEach((c,i)=>{let cell=old[i];if(!cell){cell=document.createElement('span');root.append(cell)}if(/\d/.test(c)){if(!cell.classList.contains('digit')){cell.className='digit';cell.innerHTML='<span class="strip">'+Array.from({length:10},(_,n)=>'<span>'+n+'</span>').join('')+'</span>'}const strip=cell.firstChild;requestAnimationFrame(()=>{strip.style.transform='translateY(-'+Number(c)*1.2+'em)'})}else{cell.className='';cell.textContent=c}cell.setAttribute('aria-hidden','true')});old.slice(text.length).forEach(n=>n.remove())}
$('minus').onclick=()=>{number-=123.4;roll()};$('plus').onclick=()=>{number+=123.4;roll()};$('format').onchange=roll;roll();
