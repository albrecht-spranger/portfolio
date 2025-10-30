'use strict';

export const projects = [
	{
		id: 'pottery',
		title: '陶芸作品紹介サイト',
		role: '設計 / コーディング',
		stack: ['HTML', 'CSS', 'JavaScript', 'PHP', 'MySQL', 'Google Cloud Storage'],
		period: '2025年10月～11月',
		effort: '3週間',
		thumb: 'images/sisiwaka_touen_thumb.jpg',
		images: ['images/sisiwaka_touen_thumb.jpg', 'images/sisiwaka_touen_image.jpg'],
		summary: '自作の陶芸作品を紹介するギャラリーサイト',
		demo: 'https://ss953871.stars.ne.jp/sisiwaka_touen/',
		repo: 'https://github.com/albrecht-spranger/sisiwaka_touen.git',
		note: `　職業訓練校での学びの集大成として、自分の陶芸作品を紹介するWebサイトを制作しました。
        　写真や動画はGoogle Cloud Storageに保存し、作品情報はMySQLで管理しています。
        　さらに、レスポンシブ対応を施し、Isotopeによる一覧表示、Swiperによるギャラリー表示など、作品をより魅力的に見せる工夫を取り入れました。`
	},
	{
		id: 'pottery2',
		title: '陶芸作品紹介サイト(その2)',
		role: 'コーディングにChatGPT利用',
		stack: ['HTML', 'CSS', 'JavaScript', 'Node.js (Express)', 'Google Cloud Buildpacks', 'Google Cloud Firestore', 'Google Cloud Storage'],
		period: '2025年10月',
		effort: '4日',
		thumb: 'images/sisiwaka_touen_thumb.jpg',
		images: ['images/sisiwaka_touen_thumb.jpg', 'images/sisiwaka_touen_image.jpg'],
		summary: '陶芸作品紹介サイトをNode.js (Express)に置き換え',
		demo: 'https://sisiwaka-run-826007989896.asia-northeast1.run.app/',
		repo: 'https://github.com/albrecht-spranger/sisiwaka_run.git',
		note: `　自分の陶芸作品紹介サイトのバックエンドを、PHP＋MySQLから、Node.js (Express)＋Google Cloud Firestoreに置き換えてみました。さらに、環境をGoogle Could Buildpacksにしました。バックエンドを変えただけなので、見た目は何も変わっていません。
		　自分ではほぼコーディングはせず、ChatGPTに移植をお願いすることで4日程度で完成しました。`
	},
	{
		id: 'ccdonuts',
		title: 'ショッピングサイトの構築',
		role: 'コーディング',
		stack: ['HTML', 'CSS', 'JavaScript', 'PHP', 'MySQL'],
		period: '2025年9月～10月',
		effort: '1ヶ月',
		thumb: 'images/ccdonuts01.jpg',
		images: ['images/ccdonuts01.jpg', 'images/ccdonuts02.jpg'],
		summary: '架空のドーナツショップ「C.C.Donuts」のショッピングサイト',
		demo: 'https://ss953871.stars.ne.jp/ccdonuts/',
		repo: 'https://github.com/albrecht-spranger/ccdonuts',
		note: `　職業訓練校の課題の1つとして作成。デザインカンプに従い、サイトをコーディング。
        　さらに、PHPとMySQLを使い、ログイン／お気に入り／カート／購入など、ショッピングサイトに必要な機能を一通り作成しました（クレジットカードを使った決済は除く）。
        　売上数による「人気ドーナツランキング」の表示や、テキスト検索の機能も実装。レスポンシブ対応`
	},
	// {
	//     id: 'renovation-a',
	//     title: '架空リノベ会社サイト',
	//     role: 'コーディング',
	//     stack: ['HTML', 'CSS', 'Bootstrap', 'JavaScript'],
	//     period: '2025年6月',
	//     effort: '30時間',
	//     thumb: 'images/reno_a_thumb.jpg',
	//     images: ['images/reno_a_thumb.jpg', 'images/reno_a_image.jpg'],
	//     summary: '架空のリノベーション会社のサイトを作成',
	//     demo: 'http://ss953871.stars.ne.jp/renovation/index_b2.html',
	//     repo: 'https://github.com/albrecht-spranger/renovation',
	//     note: `　職業訓練校の課題の1つとして作成。デザインカンプに従い、コーディングしました。一部のデザインをBootstrapを使い実装しています。レスポンシブ対応`
	// },
	{
		id: 'calc',
		title: '電卓アプリ',
		summary: '世界初のオールトランジスタ電卓「COMPET CS-10A」を模した電卓',
		role: '設計 / コーディング',
		stack: ['HTML', 'CSS', 'JavaScript'],
		period: '2025年7月',
		effort: '2週間',
		thumb: 'images/calc_thumb.jpg',
		images: ['images/calc_thumb.jpg', 'images/calc_image.jpg'],
		demo: 'http://ss953871.stars.ne.jp/compet_cs-10a/',
		repo: 'https://github.com/albrecht-spranger/compet_cs-10a',
		note: `　職業訓練校の自由課題として、世界初のオールトランジスタ電卓『COMPET CS-10A』を模したWeb電卓を制作しました。
        　入力方式は実機同様、電卓上の10桁キーを押すスタイルをWeb上で再現しています。
        　演算結果は最大20桁に対応しており、JavaScriptの浮動小数点精度の限界を補うために、入力値を整数部と小数点位置に分解し、longintで計算する仕組みを実装しました。`
	},
	{
		id: 'travel',
		title: '観光案内サイト',
		role: 'PL / TOPページ作成 / 共通部品作成',
		stack: ['HTML', 'CSS', 'JavaScript'],
		period: '2025年7月～8月',
		effort: '60時間×4人',
		thumb: 'images/travel_thumb.jpg',
		images: ['images/travel_thumb.jpg', 'images/travel_image.jpg'],
		summary: '職業訓練校のグループ演習で作成。架空の観光案内サイト',
		demo: 'http://ss953871.stars.ne.jp/taiwan_traveler/',
		repo: 'https://github.com/albrecht-spranger/taiwan_traveler',
		note: `　職業訓練校のグループ演習として製作。チームリーダとして開発進行を取りまとめるとともに、TOPページ、共通部品(ヘッダ、フッタ、h2タグなど)の作成を担当しました。`
	}
];
