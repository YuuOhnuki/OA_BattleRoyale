# 手編集したマップ・ホログラムの保存（1.9.217 / プラグイン0.35.0）

OP、または `oa.plugin.admin` 権限を持つ管理者が使えます。試合・生成・ロビー更新が終わった状態で操作してください。

## 最初の保存

1. `/oaplugin map info lobby` で保存範囲を確認します。対象は `lobby`（ロビー）、`br`（地上）、`nether`、`cave`、`tdm` です。
2. ブロックや展示を手編集します。保存範囲の外まで建築する場合は、下の `bounds` で範囲を広げます。
3. `/oaplugin map save lobby` で保存し、完了のメッセージを待ちます。途中の進み具合は `/oaplugin map status` です。

保存が完了すると、次の通常生成／再生成から保存版を優先します。地上等の `/function oa:map/create`・`/function oa:map/rebuild`、管理メニューのマップ生成／再生成、ロビー更新 `oa.admin 14` にも適用します。TDMは会場準備の際に保存版を読みます。

`/oaplugin map load lobby` は、今あるブロック・展示を**保存時の内容へ戻す**操作です。復元先は保存元のディメンション・座標で、実行者の現在地には移しません。保存後に追加したブロックや展示も、保存範囲内では元の状態に戻ります。保存前の手編集は自動で保存されないので、消したくない変更がある場合は先に `save` してください。

## 保存範囲と履歴

| コマンド | 用途 |
|---|---|
| `/oaplugin map info br` | 次回保存の範囲、保存版のID、自動使用の設定を表示 |
| `/oaplugin map bounds br -180 0 -180 180 180 180` | 両端を含む2点で保存範囲を指定 |
| `/oaplugin map bounds br default` | 標準の保存範囲へ戻す |
| `/oaplugin map history br` | 完了した保存版の履歴を表示 |
| `/oaplugin map load br <保存版ID>` | 履歴の指定版を復元（次回の自動使用版は切り替えない） |
| `/oaplugin map use br generated` | 次の通常生成は元の標準マップを使用。保存履歴は残す |
| `/oaplugin map use br saved` | 次の通常生成は最後に保存完了した版を使用 |
| `/oaplugin map resume` | 未完了の復元を最初から再試行 |
| `/oaplugin map cancel` | 処理を中断。保存の中断は前版を維持。復元の中断では配置済みの区画は戻らない |

標準範囲：ロビーは登録原点からX/Z ±42、Y −5〜+50（ワールドの高さに合わせて制限）。BR3会場はX/Z −152〜152、Y 0〜160。TDMはX/Z −64〜63、Y 0〜160。拡張する場合は各辺1024ブロック以内、全体4000万ブロック以内で指定できます。

保存中は普通のブロック破壊・設置を止めます。WorldEdit等の外部ツールやコンソールの `/fill` を同時に実行しないでください。区画ごとの保存なので、完了まで編集を止めてください。保存・復元中は試合開始と通常のマップ生成を止めます。

## ホログラムを作る・編集する

置きたい位置に立つか飛んで、次のように実行します。IDは半角小文字・数字・`_`・`-`で48文字までです。

```text
/oaplugin holo create welcome <aqua>ようこそ！\n<white>ここから出撃できます
/oaplugin holo set welcome scale 1.4
/oaplugin holo set welcome background #66112233
/oaplugin holo move welcome
```

| コマンド | 用途 |
|---|---|
| `/oaplugin holo adopt entrance` | 目の位置から6m以内にある最寄りの既存文字表示を登録 |
| `/oaplugin holo text entrance <gold>新しい案内` | 本文を変更 |
| `/oaplugin holo move entrance` | 自分の位置へ移動 |
| `/oaplugin holo move entrance 10.5 80 20.5` | 同じディメンション内の絶対座標へ移動 |
| `/oaplugin holo set entrance scale 2` | 大きさを変更（0.05〜16） |
| `/oaplugin holo set entrance billboard fixed` | 向きを固定。`center`、`vertical`、`horizontal`も使用可能 |
| `/oaplugin holo set entrance yaw 90` | 横向きの角度を変更（固定表示向け） |
| `/oaplugin holo set entrance width 320` | 折り返し幅（ピクセル、20〜2000） |
| `/oaplugin holo set entrance align left` | `left` / `center` / `right` |
| `/oaplugin holo set entrance range 48` | 表示距離（1〜256ブロック、クライアント側の設定にも依存） |
| `/oaplugin holo set entrance shadow true` | 文字の影。`false`で解除 |
| `/oaplugin holo set entrance background none` | 背景を透明にする。`#RRGGBB` / `#AARRGGBB`も指定可能 |
| `/oaplugin holo set entrance opacity 220` | 文字の不透明度（0〜255） |
| `/oaplugin holo list` / `info entrance` | 登録ID・配置・設定を確認 |
| `/oaplugin holo delete entrance` | 表示を削除 |
| `/oaplugin holo dynamic entrance` | 手編集による固定を外す。既存の状態板なら通常の自動更新へ戻す |
| `/oaplugin holo forget entrance` | ID登録を解除（表示そのものは消さない） |

本文はMiniMessage形式（`<aqua>`、`<gold>`、`<#65fff0>`、`<bold>`など）で、`\n`で改行します。本文は4096文字までです。既存の状態板を登録・編集した場合、その表示はロビーの動的な更新で上書きしません。

ホログラムの設定変更はワールドに保存されます。**マップの再生成にも残すには、編集後に必ず `/oaplugin map save <対象>` を実行してください。** 保存範囲外の表示は、そのマップの保存には含みません。

## 保存対象とバックアップ

- ブロック（空気を含む）、チェスト等の内容・ブロックエンティティのデータ。
- 文字／ブロック／アイテムの表示、展示マネキン、防具立て、額縁、絵画、操作用Interaction、登録用Markerとそのスコア。ホログラムの文字・位置・向き・変形・背景・PDCのIDも含む。
- ロビーの登録原点、BR会場の中心・開始地点・選択設定。

プレイヤーの装備・戦績、一般の動物／敵、ドロップ品、戦闘中の一時エンティティ、エンティティ同士の乗車関係、バイオーム、ワールドのゲームルールは保存対象外です。展示同士が乗っている場合も、各展示を保存時の位置に独立して復元します。マップ画像のリソースパックは自動では描き直しません。

保存先はサーバーの `plugins/OABattleRoyale/templates/`、ホログラムのID一覧は `plugins/OABattleRoyale/holograms.json` です。プラグインやデータパックの更新では上書きしません。バックアップ時はワールドとこのフォルダ／ファイルを一緒に保存してください。過去の保存版は新しい保存の際にも残ります。

保存は全区画の書き出しが完了してから使用版を切り替えます。保存途中で停止した場合は前の完了版を使います。復元はハッシュ・NBTを検証してから開始し、ブロックを全区画に置いた後に展示を戻します。復元途中でサーバーを止めた場合、次の起動時に同じ保存版を最初から復元し直します。失敗時は処理を止め、`resume`か`cancel`で管理者が操作するまで試合を始めません。
