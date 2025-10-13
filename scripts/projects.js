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
        repo: 'https://github.com/albrecht-spranger/sisiwaka-touen',
        note: `　職業訓練学校での学びの集大成として、陶芸作品を紹介するWebサイトを制作しました。
        　写真や動画はGoogle Cloud Storageに保存し、作品情報はCloud Firestoreで管理、WebサーバはDockerコンテナ化してCloud Run上で運用しています。
        　さらに、レスポンシブ対応を施し、Swiperによるギャラリー表示やLightboxによる拡大表示など、作品をより魅力的に見せる工夫を取り入れました。`
    },
    {
        id: 'renovation-a',
        title: '架空リノベ会社サイト',
        role: 'コーディング',
        stack: ['HTML', 'CSS', 'Bootstrap', 'JavaScript'],
        period: '2025年6月',
        effort: '30時間',
        thumb: 'images/reno_a_thumb.jpg',
        images: ['images/reno_a_thumb.jpg', 'images/reno_a_image.jpg'],
        summary: '架空のリノベーション会社のサイトを作成',
        demo: 'http://ss953871.stars.ne.jp/renovation/index_b2.html',
        repo: 'https://github.com/albrecht-spranger/renovation',
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
        repo: 'https://github.com/albrecht-spranger/compet_cs-10a',
        note: `　職業訓練学校の自由課題として、世界初のオールトランジスタ電卓『COMPET CS-10A』を模したWeb電卓を制作しました。
        　入力方式は実機同様、電卓上の10桁キーを押すスタイルをWeb上で再現しています。
        　演算結果は最大20桁に対応しており、JavaScriptの浮動小数点精度の限界を補うために、入力値を整数部と小数点位置に分解し、longintで計算する仕組みを実装しました。`
    },
    {
        id: 'travel',
        title: '架空観光案内サイト',
        role: 'PL / TOPページ作成 / 共通部品作成',
        stack: ['HTML', 'CSS', 'JavaScript'],
        period: '2025年7月～8月',
        effort: '60時間×4人',
        thumb: 'images/travel_thumb.jpg',
        images: ['images/travel_thumb.jpg', 'images/travel_image.jpg'],
        summary: '職業訓練学校のグループ演習で作成',
        demo: 'http://ss953871.stars.ne.jp/taiwan_traveler/',
        repo: 'https://github.com/albrecht-spranger/taiwan_traveler',
        note: `　職業訓練学校のグループ演習として製作。吉川はチームリーダーと、TOPページ、共通部品(ヘッダ、フッタ、h2タグなど)の作成を担当しました。`
    }
];
