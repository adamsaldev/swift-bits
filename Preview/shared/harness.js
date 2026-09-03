/* Shared preview harness. Prepended to every component's preview.js by the builder.
   Each preview.js runs inside its own function scope, so it may use these helpers
   directly or shadow them. Keep this tiny and dependency-free. */
'use strict';
const $ = id => document.getElementById(id);
const reduced = () => matchMedia('(prefers-reduced-motion: reduce)').matches;
const onReducedMotionChange = fn => matchMedia('(prefers-reduced-motion: reduce)').addEventListener('change', fn);
const raf = globalThis.requestAnimationFrame.bind(globalThis);
const cancelRaf = globalThis.cancelAnimationFrame.bind(globalThis);
