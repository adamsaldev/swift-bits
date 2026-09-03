'use strict';
const $ = id => document.getElementById(id);
const reduced = () => matchMedia('(prefers-reduced-motion: reduce)').matches;
$('load-toggle').onclick=()=>{const loading=$('profile').classList.toggle('skeleton');$('profile').setAttribute('aria-label',loading?'Loading profile':'Taylor Morgan. Building something good.');$('load-toggle').setAttribute('aria-pressed',loading);$('load-toggle').textContent=loading?'Show loaded content':'Show skeleton'};
