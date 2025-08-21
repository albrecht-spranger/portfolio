'use strict';

import { projects } from "./projects.js";

document.addEventListener('DOMContentLoaded', () => {
  const params = new URLSearchParams(window.location.search);
  const id = params.get('id');
  if (!id) {
    console.error('作品IDが指定されていません');
    return;
  }
  const p = projects.find(project => project.id === id);
  if (!p) {
    console.error('間違った作品IDを渡された');
    return;
  }
  const el_wd_title = document.getElementById('wd_title');
  if (el_wd_title) {
    el_wd_title.textContent = p.title;
  }
});
