'use strict';

export const projects = [
    {
        id: 'pottery',
        title: '陶芸作品紹介サイト',
        role: '設計 / 環境構築 / コーディング',
        stack: ['HTML', 'CSS', 'JavaScript', 'PHP', 'Dockerコンテナ', 'NoSQL DB', 'Google Cloud'],
        period: '2025年5月～11月',
        effort: '不明',
        thumb: 'images/sisiwaka-touen_thumb.jpg',
        images: ['images/sisiwaka-touen_thumb.jpg', 'images/sisiwaka-touen_image.jpg'],
        summary: '自作の陶芸作品を紹介するギャラリーサイト',
        demo: 'https://sisiwaka-touen-web-826007989896.asia-northeast1.run.app/',
        repo: 'https://github.com/yourname/pottery-site',
        note: `　職業訓練学校での学びの集大成として制作。Google Cloud Storage上に写真と動画を保存し、個々の作品の情報はNoSQL DB (Google Cloud Firestore)で管理しています。さらに、WebサーバはDockerコンテナ化し、Google Cloud Run上で動かしました。
        【その他】レスポンシブ対応、Swiperを使ったギャラリー、Lightboxを使った画像の拡大表示、など`
    },
    {
        id: 'renovation-a',
        title: '架空リノベ会社サイト',
        role: 'コーディング',
        stack: ['HTML', 'CSS', 'Bootstrap', 'JavaScript'],
        period: '2025年6月',
        effort: '30時間',
        thumb: 'images/reno_a_thumb.jpg',
        images: ['images/reno_a_thumb.jpg', 'assets/reno_a_2.jpg'],
        summary: '架空のリノベーション会社のサイトを作成',
        demo: 'http://ss953871.stars.ne.jp/renovation/index_b2.html',
        repo: 'https://github.com/yourname/renovation-a',
        note: `　職業訓練学校の課題の1つとして作成。デザインカンプに従い、コーディングしました。一部のデザインをBootstrapを使い実装しています。レスポンシブ対応`
    },
    {
        id: 'calc',
        title: '電卓アプリ',
        summary: '世界初のオールトランジスタ電卓「COMPET CS-10A」を模した電卓',
        role: '設計 / コーディング',
        stack: ['HTML', 'CSS', 'JavaScript'],
        period: '2025年7月',
        thumb: 'images/calc_thumb.jpg',
        images: ['images/calc_thumb.jpg', 'images/calc_image.jpg'],
        demo: 'http://ss953871.stars.ne.jp/compet_cs-10a/',
        repo: 'https://github.com/yourname/calculator',
        note: `　職業訓練学校の自由課題の1つとして、世界初のオールトランジスタ電卓「COMPET CS-10A」を模した電卓を作成。
        　入力は、電卓上の10桁の数字を、直接、押す方式だったので、Web画面上でもこれをシミュレートしました。
        　演算結果は20桁。JavaScriptの浮動小数では精度が足りないため、内部で数字(longint)と、小数点位置に分解、longintで計算することで20桁の精度を出しています。`
    },
    {
        id: 'travel',
        title: '架空の台湾観光案内サイト',
        role: 'PL / TOPページ作成 / 共通部品作成',
        stack: ['HTML', 'CSS', 'JavaScript'],
        period: '2025年7月～8月',
        effort: '60時間×4人',
        thumb: 'images/travel_thumb.jpg',
        images: ['images/travel_thumb.jpg', 'images/travel_image.jpg'],
        summary: '職業訓練学校のグループ演習で作成',
        demo: 'http://ss953871.stars.ne.jp/taiwan_traveler/',
        repo: 'https://github.com/yourname/travel-guide',
        note: `職業訓練学校のグループ演習として製作。吉川はチームリーダーと、TOPページ、共通部品(ヘッダ、フッタ、h2タグなど)の作成を担当。
        【その他】レスポンシブ対応`
    }
];
