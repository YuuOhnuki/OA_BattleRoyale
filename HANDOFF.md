# 引き継ぎメモ（1.9.116 時点）

## 現状
- 1.9.116：ロビー中央の柱に埋まらないよう lobby/center の移動先を z+5.5 に。ロビーからのマップ選択（lobby/mapsel/*、stone_button 2個＋マーカー oa.button_mapsel、map_panel_update、sentinel oa.map_panel1116）。パネルは選択中のマップで item_model を切り替え（要リソースパック1.9.36）。
- 1.9.115：食料テーブル(br/food)の雪玉・卵・矢にスタック上限64を付与（チェストと同じ）。ネザーの鉱石を石炭(ore 1)・レッドストーン(ore 3)に変更。ore 5/6（クォーツ・金）の処理は互換のため残置。
- 1.9.114：空中補給の予告・降下の文言を変更（supply/preview, launch）。
- 1.9.113：ネザーのチェストを75→105（砦に上位1＋通常1、見張り塔に通常1）。補給物資のアクションバーは #sup_phase（br.tmp）で3秒ごとに通常バーと交互（supply/second と ui/actionbar）。
- 1.9.112：ネザーの大要塞（build_map_nether.py の FX,FZ,FH ブロック、チェスト75）、マップ別コマンド（map/do ＋ map/op/*、admin コード 60..71＝地上／80..91＝ネザー）、管理ブックは scripts/gen_admin_book.py で生成。
- 1.9.111：ネザーに建築物・障害物を追加（scripts/build_map_nether.py の rng2 ブロック）、版数のTAB表示と /trigger oa.ver、load_done メッセージ。version.mcfunction は先頭に oa.vtab 作成、末尾に storage と表示形式（版数を含む行）。
- 1.9.110：map/internal の root 直指定 data modify（select_load、load_saved、args_from_def）をキー単位のコピーに修正。
- 1.9.109：複数マップ基盤（map/internal/defs、select、create_nether）、ネザー会場（scripts/build_map_nether.py が maps/nether を生成）、固定参照の展開（scripts/multimap_expand.py）。検証・変更履歴は docs/changelog.md。
- 【最新】データパック 1.9.116 ＋ リソースパック 1.9.36（ネザー用ロビー地図パネル）
- データパック 1.9.108（`OA_BattleRoyale_v1.9.108.zip`）＋リソースパック 1.9.35（ロビー地図を再描画）。
- 1.9.99：遺跡の塔4基（scripts/build_map_1_9_99_towers.py）、実績20種を永続化、前回結果・実績一覧の trigger。`UPDATE_1_9_99_JA.md` 参照。
- 1.9.102：ロビー装飾（scripts/gen_lobby_decor_1_9_102.py）、洞窟入口・帆船（scripts/build_map_1_9_102_decor.py）、花火・補給・練習場モブ。リソースパックの地図画像は resourcepack/source/build_lobby_map_1_9_34.py で再生成。
- 1.9.100：チュートリアル／お題／初心者サポート／補給3種／戦績ボード／練習場の模擬戦・計測・射程レーン／雪原洞窟2・海中遺跡2（scripts/build_map_1_9_100_sites.py）。`UPDATE_1_9_100_JA.md` 参照。実機未検証点はそちらに記載。
- 1.9.98：リザルト、終盤の点滅と花火、空中補給、実績（キリング・ぴちぴち）。`UPDATE_1_9_98_JA.md` と `docs/roadmap.md` 参照。未実装は探索の報酬（E）と遊びやすさ（F）、他武器の実績。
- 1.9.97：中央広場のドーム骨組み、雪原の岩場化、草花・海草・ケルプの追加。詳細は `UPDATE_1_9_97_JA.md`。
- 検証は静的のみ（`VALIDATION_1_9_97.json` は全項目PASS）。**Java 26.3 の実サーバーでは未確認**。

## 未確認・要注意
- 26.3 のレジストリでのブロック名・状態の照合は未実施（waxed copper と short_grass は既存パックで使用済み、他は標準名）。
- ゲーム内スコアボードのバージョン表示は未観察（version.mcfunction の11行を静的に更新）。
- ドーム直下（広場の約29%）は雨が当たらない。
- 草花マスは地面アイテムのドロップ地点から外れる（地表の数%）。
- ジャンプ台の射線が支柱に当たる場合がある。
- `docs/spec.md` と `docs/discord-game-guide.md` は今回初めて作った。内容は実装から拾った要約なので、実装との照合を推奨。

## マップ生成の仕組み
- 100個のタイル関数：`tiles/place/N`（ブロック）、`tiles/water/N`（水）、`tiles/apply/N`（チェスト・鉱石登録）、`delete/apply/N`（削除）。`oa:map/rebuild` は place を再実行する。
- 本パックはこれらの関数に差分行を挿入する方式。ドームの高さ（Y+29まで）のため、フレームのあるタイル 34,43,44,45,54,55 の place と delete に `fill ... ~30 ... air` を追加済み。fill上限32768以内（最大30720）。

## スクリプト（scripts/）
- `build_map_1_9_97.py`：v1.9.96 のタイル関数をボクセルに再生し、ドーム・雪・植生・海を適用して差分行を出力。目標モデル `map_1_9_97_target.npz` を書く。
- `validate_map_1_9_97.py`：新パックを再生して目標と比較。保護セル、隣接、構文、fill体積、到達距離を検査。
- `finalize_1_9_97.py`：バージョン更新（pack.mcmeta、version.mcfunction、README）、MAP_MANIFEST、MAP_OVERVIEW.png。
- 実行順：クリーンな旧版を複製→build→validate→finalize。スクリプトは展開済みパック内の `source/` から動かす前提で、**パスは作業環境に合わせて直す必要がある**。
- `tools/` はボクセル再生と上面描画、`work/` はドームの試作と3Dプレビュー。

## 設計の数値
- ドーム：支柱8本(2x2、18°+45°×j)、リング r=25/17/9、K 22..39、頂点Y+29。
- 縦移動の到達：ぴちぴち6.13、パイモン併用8.43、ふろボール10.087、ヴァレサ約4。枠の最低足場は床+12（差11）。
- ジャンプ台27、チェスト59、鉱石108。縮小は tick 2400/4800/7200/10800/12000。

## 次にやること（候補）
1. 26.3 の検証用サーバーで読み込み、`/function oa:map/rebuild`、チェスト登録、`oa:br/spawn_points/verify` を実測。
2. ドーム周りの見た目と戦闘への影響を実プレイで確認。
3. 仕様書・Discordガイドを実装と照合して補正。
