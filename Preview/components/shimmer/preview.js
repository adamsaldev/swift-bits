'use strict';
const $ = id => document.getElementById(id);
const reduced = () => matchMedia('(prefers-reduced-motion: reduce)').matches;
// Animation respects prefers-reduced-motion in shared CSS.
