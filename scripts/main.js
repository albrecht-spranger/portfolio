/* =====================================
FILE: /assets/main.js  （挙動 & データ）
===================================== */
'use strict';

import { projects } from "./projects.js";

// ナビ開閉
const navToggle = document.getElementById('navToggle');
const globalNav = document.getElementById('globalNav');
if (navToggle && globalNav) {
  navToggle.addEventListener('click', () => {
    const open = globalNav.classList.toggle('open');
    navToggle.setAttribute('aria-expanded', String(open));
  });
}

// 年号
const yearEl = document.getElementById('year');
if (yearEl) yearEl.textContent = new Date().getFullYear();

// === 一覧生成
function renderCard(p) {
  const tags = Array.isArray(p.stack) ? p.stack.join(' / ') : 'TBA';
  return `
  <article class="card">
    <div class="card__thumb">
      <a href="work-detail.html?id=${p.id}">
        <img src="${p.thumb}" alt="${p.title}のサムネイル">
      </a>
    </div>
    <div class="card__body">
      <h3 class="card__title">${p.title}</h3>
      <dl>
        <dt>担当</dt>
        <dd>${p.role}</dd>
        <dt>開発期間</dt>
        <dd>${p.period}</dd>
        <dt>工数</dt>
        <dd>${p.effort}</dd>
        <dt>技術スタック</dt>
        <dd>${tags}</dd>
      </dl>
    </div>
    <div class="card__actions">
      <a class="anchor_text" href="work-detail.html?id=${p.id}">詳細</a>
      <a class="anchor_text" href="${p.demo}" target="_blank" rel="noopener">実サイト</a>
      <a class="anchor_text" href="${p.repo}" target="_blank" rel="noopener">GitHub</a>
    </div>
  </article>`;
}

const featuredWorks = document.getElementById('featuredWorks');
if (featuredWorks) {
  featuredWorks.innerHTML = projects.map(renderCard).join('');
}
