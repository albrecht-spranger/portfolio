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

  // タイトル
  const el_wd_title = document.getElementById('wd_title');
  if (el_wd_title) {
    el_wd_title.textContent = p.title ?? 'TBA';
  }

  // 担当
  const el_wd_role = document.getElementById('wd_role');
  if (el_wd_role) {
    el_wd_role.textContent = p.role ?? 'TBA';
  }

  // 製作期間
  const el_wd_period = document.getElementById('wd_period');
  if (el_wd_period) {
    el_wd_period.textContent = p.period ?? 'TBA';
  }

  // 工数
  const el_wd_effort = document.getElementById('wd_effort');
  if (el_wd_effort) {
    el_wd_effort.textContent = p.effort ?? 'TBA';
  }

  // 技術スタック
  const el_wd_tech_stack = document.getElementById('wd_tech_stack');
  if (el_wd_tech_stack) {
    const stack_list = Array.isArray(p.stack) ? p.stack.join(' / ') : 'TBA';
    el_wd_tech_stack.textContent = stack_list;
  }

  // 概要
  const el_wd_summary = document.getElementById('wd_summary');
  if (el_wd_summary) {
    el_wd_summary.textContent = p.summary ?? 'TBA';
  }

  // スクリーンショット
  const el_wd_img_wrapper = document.getElementById('wd_img_wrapper');
  if (el_wd_img_wrapper) {
    const img1 = document.createElement("img");
    img1.src = p.images[0];
    img1.alt = "サンプル画像1";
    el_wd_img_wrapper.appendChild(img1);
    const img2 = document.createElement("img");
    img2.src = p.images[1];
    img2.alt = "サンプル画像2";
    el_wd_img_wrapper.appendChild(img2);
  }

  // 補足
  const el_wd_note = document.getElementById('wd_note');
  if (el_wd_note) {
    el_wd_note.textContent = p.note ?? 'TBA';
  }

    // 実サイトへ
  const el_2_site = document.getElementById('wd_2_site');
  if (el_2_site) {
    el_2_site.href = p.demo ?? '#';
  }

    // 補足
  const el_2_github = document.getElementById('wd_2_github');
  if (el_2_github) {
    el_2_github.href = p.repo ?? '#';
  }
});
