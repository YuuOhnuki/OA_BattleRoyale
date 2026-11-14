# 引き継ぎメモ（1.9.153 時点）

## 現状
- 1.9.131：述語JSONは 26.3 では "condition" でなく "type" が必須。酸性雨・寒波の屋外判定は述語を使わず k1/check・k2/check（world_surface）で行う。
- 1.9.130：ハズレガチャ3種（critical/stiff/exposed）の冒頭で tayayuyu/self_glow を呼ぶ。発光の管理は oa.gglow。
- 1.9.129：開始地点の足元判定は #oa:spawn_unsafe_floor（不可）と #oa:spawn_clear（通れるブロックは不可）。br/spawn_points/check と br/spawn_check の2か所。
- 1.9.153：補給物資の矢印を、プレイヤーの向きから見た相対方向に変更（br/supply/guide_calc の末尾、guide_face のマクロでマーカーを物資へ向けて回転差を8方向に分ける）。
- 1.9.152：地震の判定を緩和（最初の2秒は無傷、移動は合計60cm/秒以上かジャンプ。k5/shake）。
- 1.9.151：災害を、合図（kN/warn、雷・タイトル・チャット）の5秒後に発生（disaster/warn → kN/start）に分けた。#dis_warn が待ち秒数。
- 1.9.150：1.9.148 の観戦者の救済（br/second）が at @s なしでディメンションを判定し、全観戦者を毎秒中心へ戻していた不具合を修正。
- 1.9.149：たやゆゆのガチャ復活の武器を、tick 7200 前は石の剣、以降は石の槍に分けた（tayayuyu/revive）。
- 1.9.148：ガチャ復活・途中参加後のソロ戦で oa_brsolo へ再加入（ネームタグ表示の修正）。観戦者がロビーに残る不具合を、internal/death と br/second（spec/return_center）で中心へ戻して修正。
- 1.9.147：脱落時の観戦の自動追従を廃止（br/spec/begin から spec/next の呼び出しを削除）。
- 1.9.146：たやゆゆのガチャ使用音を全参加者に聞こえるように（tayayuyu/use、各自の位置で再生）。
- 1.9.145：封印の宝珠の数を最大8→6（disaster/init の limit）。
- 1.9.144：封印の宝珠（disaster/relic/make）の発光（Glowing）を廃止。解錠中の光の柱（pulse）は残してある。
- 1.9.143：練習場でも参加登録（br.lobby）を保持。practice/enter で br.lobby を外さず、practice/leave は登録済みの人だけ br/join、br/start は練習場の参加者を practice/leave で復元してから開始。
- 1.9.142：空中補給の中身を回ごとに段階化（br/supply/preview で便を時刻から決定、spawn で中身）。ゆったりの押し出しを2倍（knockback/tick の kboost=2、4ステップ/tick）。
- 1.9.141：開始TP直後の地中埋まりを br/tp_fix_all で補正（真上の立てる場所へ）。開始地点の操作メッセージにマップ名を表示し、管理ブックの旧ページから開始地点ボタンを削除（地上／ネザーのページのみ）。
- 1.9.140：ゆーの地面の名前表示・演出は、perf/world_maintenance（5tickごと）と vclock 0（10tickごと）が重ならず動かないことがあったため、overwork/ground_init（タグ付与時に名前）＋world_tick の vclock 0 で演出に変更。
- 1.9.139：隕石（k3/impact）は屋根の下（world_surface 判定、k1/check と同じ）の生存者に当たらない。
- 1.9.138：「最大値を探す」処理は `execute as … if score @s X > #m run … operation #m = @s X` をやめ、`execute as … run … operation #m > @s X`（順序に依存しない書き方）に統一（戦績ボード・ハイライト・観戦の前後）。
- 1.9.137：チームの表示は名前の色だけ（br/team/setup の suffix は空）。
- 1.9.136：ロビーの「前回の試合結果」は生存時間→キルの順で並べ、番号を付ける（lobby/board/last_key、スコア br.lkey）。戦績・実績数は元から降順。
- 1.9.135：地震は統計（br.qwalk/qspr/qsneak/qjump）で「動いたらダメージ」。ゆーの地面アイテムは overwork/ground_init で拾得待ち解除＋ground の演出。
- 1.9.134：補給物資の block_display の block_state は、プロパティ付きは文字列でなく {Name,Properties} の形式（文字列だと Serialization errors）。
- 1.9.133：ギミック（間欠泉等）を廃止し、建物内の封印の宝珠（disaster/relic/）に置換。災害ダメージ増、警告のアクションバーは3秒交互（#dis_phase、br.dis_msg、br/ui/actionbar で通常バーを抑止）。無効化は #relic_off。
- 1.9.128：災害は data/oa/function/disaster/（second→begin→pool→kN/start、active→kN/second→end）。抽選プールはマップ定義の disasters。無効化は #dis_off（br.tmp）。印は tag br.dis のマーカー（br/finish と init で削除）。
- 1.9.127：観戦パッド（灰色の羊毛）は lobby/build.mcfunction の gray_wool の行（x=-13..-11, z=32..34）。判定は lobby/tick の足元ブロック。
- 1.9.126：ロビーの明かりは lobby/build.mcfunction の「1.9.125 明るさ」ブロック（シーランタンの帯と light ブロック）。ロビー更新で再構築される。
- 1.9.125：実績のタブは oa:ach/root の1つ。カテゴリは cat_br/cat_map/cat_weapon（枝の頭）。隠し実績は関連する枝の中。scripts/gen_ach_1_9_123.py の CATS と a(...) の親を編集して再実行する。
- 1.9.124：ロビーのチーム羊毛は lobby/build.mcfunction の「TEAM n」の行（地図手前 z=23/29）。選択判定は br/team/select の足元ブロック。旧位置の羊毛は消えないので、反映はロビー更新（oa.admin 14）で再構築する。
- 1.9.123：実績は scripts/gen_ach_1_9_123.py の表から advancement/ach・ach/list・count_ach・revoke_all を生成。新実績は表に足して再実行し、付与箇所（ach/give呼び出し）を実装する。練習場は ach/give 先頭のガードで無効。
- 1.9.122（**誤り。1.9.134 で訂正済み**）：プロパティ付きの block_state を文字列で書くとエラー（Serialization errors）になる。正しくは {Name:"minecraft:barrel",Properties:{facing:"up",open:"false"}} の形式。プロパティなしなら文字列でよい。
- 1.9.121：湧き許可は data/oa/tags/block/ground_spawn_surface.json と spawn_clear.json、loot/random_ground→ground_try（4回試行）。天候は defs の weather と br/weather/gate（#wx）。nbt の文字列表示は interpret:true。ロビーボードの更新時計 #bclock は board/tick が #perf=0 の1秒1回しか呼ばれないので閾値は5。練習場の本は practice/book、dispatch の oa.lobby 201〜207。
- 1.9.120：ネザー宝物庫は上位4つのみ、thin(chests,58)/thin(riches,10)。地上の起伏は R 60以内なし（damp）。再適用は git checkout 7704f35 -- data/oa/function/map/internal/tiles のあと build_map_1_9_117_relief.py。
- 1.9.119：補給3回（loot/tick）、補給案内30秒（supply/second の br.sup=..30）、ネザーのチェスト79（build_map_nether.py の thin()）、起伏は build_map_1_9_117_relief.py（replay版を git checkout 7704f35 -- tiles で戻してから適用）と nether relief() をなだらか＋建物ノールに、終盤演出を控えめに、ロビーボードは board_at で原点ずれを検知（board/check,move,clear）。
- 1.9.118：場所名の nbt 表示に interpret:true（引用符除去）。ネザー宝物庫の四隅の塔に屋根（build_map_nether.py）。
- 1.9.117：高低差（地上は scripts/build_map_1_9_117_relief.py が現行タイルをreplayして追記、1回だけ適用。ネザーは build_map_nether.py の relief()）。終盤演出は defs の finale → oa:finale/tick/step/exec、地上=finale/br、ネザー=finale/nether、既定=finale/default。昭心進行度は itori/progress_save・progress_restore（oa.ib_*）で練習場の出入りに退避・復元。lobby/center・warp の向きは南向き(0)。
- 1.9.116：ロビー中央の柱に埋まらないよう lobby/center の移動先を z+5.5 に。ロビーからのマップ選択（lobby/mapsel/*、stone_button 2個＋マーカー oa.button_mapsel、map_panel_update、sentinel oa.map_panel1116）。パネルは選択中のマップで item_model を切り替え（要リソースパック1.9.36）。
- 1.9.115：食料テーブル(br/food)の雪玉・卵・矢にスタック上限64を付与（チェストと同じ）。ネザーの鉱石を石炭(ore 1)・レッドストーン(ore 3)に変更。ore 5/6（クォーツ・金）の処理は互換のため残置。
- 1.9.114：空中補給の予告・降下の文言を変更（supply/preview, launch）。
- 1.9.113：ネザーのチェストを75→105（砦に上位1＋通常1、見張り塔に通常1）。補給物資のアクションバーは #sup_phase（br.tmp）で3秒ごとに通常バーと交互（supply/second と ui/actionbar）。
- 1.9.112：ネザーの大要塞（build_map_nether.py の FX,FZ,FH ブロック、チェスト75）、マップ別コマンド（map/do ＋ map/op/*、admin コード 60..71＝地上／80..91＝ネザー）、管理ブックは scripts/gen_admin_book.py で生成。
- 1.9.111：ネザーに建築物・障害物を追加（scripts/build_map_nether.py の rng2 ブロック）、版数のTAB表示と /trigger oa.ver、load_done メッセージ。version.mcfunction は先頭に oa.vtab 作成、末尾に storage と表示形式（版数を含む行）。
- 1.9.110：map/internal の root 直指定 data modify（select_load、load_saved、args_from_def）をキー単位のコピーに修正。
- 1.9.109：複数マップ基盤（map/internal/defs、select、create_nether）、ネザー会場（scripts/build_map_nether.py が maps/nether を生成）、固定参照の展開（scripts/multimap_expand.py）。検証・変更履歴は docs/changelog.md。
- 【最新】データパック 1.9.153 ＋ リソースパック 1.9.36（ネザー用ロビー地図パネル）
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
