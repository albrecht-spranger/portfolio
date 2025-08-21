'use strict';

export const projects = [
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
