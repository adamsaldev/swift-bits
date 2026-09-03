'use strict';
const $ = id => document.getElementById(id);
const reduced = () => matchMedia('(prefers-reduced-motion: reduce)').matches;
let hasProject = false;
$('empty-demo').addEventListener('click', () => {
 hasProject = !hasProject;
 document.querySelector('.empty-demo strong').textContent = hasProject ? 'Your first project.' : 'A fresh start.';
 document.querySelector('.empty-demo p').textContent = hasProject ? 'Ready for a little possibility.' : 'Your next great idea belongs here.';
 $('empty-demo').textContent = hasProject ? 'Start again' : 'Create your first project';
});
