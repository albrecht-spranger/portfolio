/* =====================================
FILE: /assets/main.js  （挙動 & データ）
===================================== */
'use strict';

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

// === 制作実績データ（ここを書き換えてください） ===
const projects = [
    {
        id: 'pottery',
        title: '陶芸作品紹介サイト',
        role: '設計 / 環境構築 / コーディング',
        stack: ['HTML', 'CSS', 'JavaScript', 'PHP', 'Dockerコンテナ', 'NoSQL DB', 'Google Cloud'],
        period: '2025年5月～11月',
        thumb: 'images/sisiwaka-touen_thumb.jpg',
        images: ['assets/pottery_1.jpg', 'assets/pottery_2.jpg'],
        summary: '自作の陶芸作品をカテゴリ別に閲覧できるギャラリーサイト。レスポンシブ対応、CSS Gridでレイアウト。',
        highlights: [
            'カテゴリフィルタ（vanilla JS）',
            'Lazy-load で表示パフォーマンス最適化',
            'アクセシブルなモーダル実装'
        ],
        demo: 'https://sisiwaka-touen-web-826007989896.asia-northeast1.run.app/',
        repo: 'https://github.com/yourname/pottery-site'
    },
    {
        id: 'renovation-a',
        title: '架空リノベ会社サイト',
        role: 'コーディング',
        stack: ['HTML', 'CSS', 'JavaScript'],
        period: '2025-06',
        thumb: 'images/reno_a_thumb.jpg',
        images: ['assets/reno_a_1.jpg', 'assets/reno_a_2.jpg'],
        summary: '施工事例スライダーやFAQトグルをバニラJSで実装。軽量構成。',
        highlights: [
            'IntersectionObserverでフェードイン演出',
            'アクセシブルなFAQ（details/summary）'
        ],
        demo: 'https://example.com/renovation-a',
        repo: 'https://github.com/yourname/renovation-a'
    },
    {
        id: 'calc',
        title: '電卓アプリ',
        role: '設計 / コーディング',
        stack: ['HTML', 'CSS', 'JavaScript'],
        period: '2025-04',
        thumb: 'images/calc_thumb.jpg',
        images: ['assets/calc_1.jpg'],
        summary: '四則演算・AC・履歴表示を備えた電卓。キーボード入力にも対応。',
        highlights: [
            'ユニットテスト（テスト用関数分離）',
            'ARIA属性でスクリーンリーダー対応'
        ],
        demo: 'https://example.com/calculator',
        repo: 'https://github.com/yourname/calculator'
    },
    {
        id: 'travel',
        title: '架空の台湾観光案内サイト',
        role: 'PL / TOPページ作成 / 共通部品作成',
        stack: ['HTML', 'CSS', 'JavaScript'],
        period: '2025年7月～8月、60時間×4人',
        thumb: 'images/travel_thumb.jpg',
        images: ['assets/travel_1.jpg', 'assets/travel_2.jpg'],
        summary: '職業訓練学校のグループ演習で作成',
        highlights: [
            '検索フィルタ（エリア/予算）',
            'フォームバリデーション（クライアント/サーバ）'
        ],
        demo: 'https://example.com/travel',
        repo: 'https://github.com/yourname/travel-guide'
    }
];

// === 一覧生成
function renderCard(p) {
    const tags = p.stack.map(s => `<span class="tech_stack">${s}</span>`).join('');
    return `
  <article class="card">
    <div class="card__thumb">
      <a href="work-detail.html?id=${p.id}">
        <img src="${p.thumb}" alt="${p.title}のサムネイル">
      </a>
    </div>
    <div class="card__body">
      <h3 class="card__title">${p.title}</h3>
      <p class="card__meta">担当：${p.role}</p>
      <p class="card__period">期間、工数：${p.period}</p>
      <p class="card__tags">技術スタック：${tags}</p>
    </div>
    <div class="card__actions">
      <a class="anchor_text" href="work-detail.html?id=${p.id}" target="_blank" rel="noopener">詳細</a>
      <a class="anchor_text" href="${p.demo}" target="_blank" rel="noopener">実サイト</a>
      <a class="anchor_text" href="${p.repo}" target="_blank" rel="noopener">GitHub</a>
    </div>
  </article>`;
}

const featuredWorks = document.getElementById('featuredWorks');
if (featuredWorks) {
    featuredWorks.innerHTML = projects.map(renderCard).join('');
}

// === 詳細ページ描画
function qs(name) {
    const params = new URLSearchParams(location.search);
    return params.get(name);
}

const workDetail = document.getElementById('workDetail');
if (workDetail) {
    const id = qs('id');
    const p = projects.find(x => x.id === id) || projects[0];
    const tags = p.stack.map(s => `<span class="tag">${s}</span>`).join('');
    const gallery = p.images.map(src => `<img src="${src}" alt="${p.title}のスクリーンショット">`).join('');
    workDetail.innerHTML = `
    <section class="detail-hero">
      <h1>${p.title}</h1>
      <div class="detail-meta">${p.role}／${p.period}</div>
      <div class="card__tags">${tags}</div>
      <p class="muted">${p.summary}</p>
      <div class="card__actions">
        <a class="btn primary" href="${p.demo}" target="_blank" rel="noopener">デモを見る</a>
        <a class="btn" href="${p.repo}" target="_blank" rel="noopener">GitHub</a>
        <a class="btn ghost" href="/works.html">一覧に戻る</a>
      </div>
    </section>
    <section class="detail-body">
      <h2>工夫した点 / 学び</h2>
      <ul>${p.highlights.map(h => `<li>${h}</li>`).join('')}</ul>
      <h2>スクリーンショット</h2>
      <div class="gallery">${gallery}</div>
      <div class="note">
        <strong>メモ:</strong> 実案件ではアクセシビリティ（キーボード操作・コントラストなど）とパフォーマンス（画像最適化・遅延読み込み）を重視しています。
      </div>
    </section>
  `;
}