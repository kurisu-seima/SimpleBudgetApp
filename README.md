# しんぷる予算

＜概要＞

毎月の収支を入力することで一日あたりに使える金額を表示してくれる予算アプリです。

お金の管理が苦手な方でも簡単に収支と予算の把握ができます。

アピールポイント：　難しいグラフなどを使用せず、直感的で分かりやすさを意識したUI、アニメーション実装

＜使用技術＞

・Swift 5.3.2

・Realm 4.4.1

・UserDefaults

＜アーキテクチャ＞

・MVCモデル

＜使用ライブラリ＞

・SideMenuSwift

・DSFloatingButton

・RealmSwift

＜機能一覧＞

・一日あたりの予算を表示する機能

・今日使える金額を表示する機能

・臨時の収支を入力できる機能

・月別の収支が確認できる機能

＜意識したところ＞

高階関数を使いできるだけ冗長なコードにならないように意識して取り組みました

＜難しかったところ＞

どのように責務を分担してクラスを作るか

＜学んだこと＞

・ジェネリック関数

・CAGradientLayer

・map、reduce、forEachメソッド

・テーブルビューのヘッダー・フッター

・フェードインアニメーション

・DispatchQueue

＜アプリ全画面＞
![SimpleBudgetAppScreenShot](https://user-images.githubusercontent.com/74137008/115136299-e3d73f00-a059-11eb-8d86-ebfbc2b9b813.png)

