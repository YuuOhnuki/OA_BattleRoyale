# 引き継ぎメモ（1.9.235 時点）

## 1.9.235

- **「天空都市」を「天空島」に改名**（表示名だけ。キー `sky`・ID 3・ディメンション `oa:br_sky`・管理コードは同じ）。
- **天守を吹き抜けに**：2・3階の床は外周の幅3の回廊（手すり付き）だけにし、中央は1階から屋根まで吹き抜け。吹き抜けにシャンデリア（鎖・金・ランタン）と赤い垂れ幕。チェストは回廊へ移した。
- **まわりの島に大きな高低差**：丘・山（雪は最大+15、和風+13、天空神殿+11 など）。建物はそれぞれ均した段（`pad`：高い所は削り、低い所は埋める）の上に建てるので、地面に埋もれない（天空神殿の中が苔で埋まっていたのを修正）。
- **建物を作り込んだ**：木組みの家は2階が張り出し（持ち送り）、花台付きの窓、深い軒、煙突、はしごで2階へ。ピラミッドは角の帯・柱の宝の部屋・オベリスク、雪は山の頂の氷の柱、メサは縞の台地と崖の廃坑の入口・自然のアーチ、和風は四重の塔・鳥居と石灯籠の参道・縁側の茶屋、神殿は3段の基壇と周柱・破風、気球は2層の楼閣、リゾートは段のテラスのプールと滑り台など。
- **まわりの島をガラスの半球で囲った**：半径29（地面 y=80 から高さ29まで）。透明なガラスに白いガラスの骨組み、土台は石英。入口は中央への橋の向きに1つ（幅5・高さ5、石英の枠）。島の縁からドームまでは床で埋めてあり、どの島も入口から歩いて入れる。建物はドームの内側に収めた（はみ出すブロックは消す）。
- 飛行船の島の橋がつながらなかったのを修正（船の横の手すりをなくし、ドームの床でもつながる）。
- ドームは候補地ごとのテンプレート `data/oa/structure/sky/dome_s<候補地>.nbt`（回さずに置く。入口はその候補地から中央への向き）。島のテンプレートは高さを `DOME_R`（29）の内側に切る。管理ブックの生成元 `scripts/gen_admin_terminal_book.py` に天空島・異界の名前を足した（1.9.230 は出力だけ手で足していて、再生成で消えるところだった）。

## 1.9.234

- **ゆったりの通常攻撃**：10%で相手を強く吹き飛ばす（水平 2.4・上 0.55 の速さ。通常のノックバックのあとに上書き。風の音と粒）。
- **ネロノワールの通常攻撃**：10%で相手の真後ろ（1.3ブロック、相手と同じ向き＝背中を見る）へテレポート（煙・ポータルの粒、エンダーマンの音）。行き先の足元と頭上を確かめ、だめなら少し近く・上下1を探し、なければしない。境界の外へは行かない。
- どちらもプラグイン 0.48.0（`combat/MeleeProcs`）。近接の命中（キャンセルされない攻撃）だけ。相手は参加者か練習用ダミー。武器の説明（アイテム・ギャラリー・WEAPONS_JA）を更新。
- 整備：`gen_weapon_text.py` がガチャ全結果の「炎」から♥×1を落としていたのを直した（1.9.229 の手直しが再生成で消えないように）。

## 1.9.233

- **天空都市を作り直した**（ユーザーの指示）：中央の島を大きく（半径64）。四角い城壁（厚さ3・高さ9、上は通路と胸壁、内側に赤い垂れ幕）、角の大きな丸い塔4本（円錐の屋根）、門楼（門の両側の小塔）4つ、柱の回廊、赤い絨毯の十字の道と金の飾り、噴水4つ、23×23・3階建ての天守（屋上の四隅に尖塔、時計塔と旗）。城の外の丘に木・桜・家・チェスト。
- **まわりの島は「島の見本」10種類から、会場を作るたびに3〜6個を抽選**し、10か所の候補地のどこかへ向き（0/90/180/270度）も抽選して置く：砂漠（段々のピラミッド・砂岩の家・井戸）・雪（丸太小屋・かまくら・氷の柱・針葉樹）・メサ（縞の台地2つと木の階段・アーチ・廃坑の入口）・オアシス（池・ヤシ・隊商のテント）・西洋の町（木組みの家6軒・尖塔の教会・噴水の広場・街灯）・和風（五重の塔・鳥居と参道・石灯籠・茶屋・桜と竹）・飛行船（桟橋の小島に停泊した帆船型の飛行船、船室2階、マスト3本と帆、上に気嚢の飾り）・気球（丸い甲板の楼閣と桜、吊りかご、大きな気球の飾り）・天空神殿（白い島から苔が垂れる、石英の列柱の神殿）・リゾート（白い砂浜とプール、休憩小屋、展望塔、ヤシ）。各島チェスト6〜7個（特別を含む）・鉱石・開始地点4〜5か所。
- 島は構造物テンプレート（`data/oa/structure/sky/<種類>.nbt`、`scripts/build_map_sky.py` が生成）を `place template` で置く。中央への橋は候補地ごとに用意し、選ばれた所だけ架ける。どの島も中央へ橋でつながる。島の縁は平らなので、どの向きでも橋が平らな所につながる。
- 置く順番：区画（中央）→ 中央の開始地点・地点名 → 島を1つずつ（周りを読み込み → 橋 → テンプレート → チェスト・鉱石・開始地点・地点名の登録）。島を置き終わるまで「生成中」（試合は始められない）。
- 1.9.230〜1.9.231 の仕掛けのうち、転移装置と、外周の島の上の救済用の足場はなくした（島の場所が毎回変わるため）。救済用の足場と上昇気流は中央の島の外の下に4か所。ロビーの地図パネル（リソースパック 1.9.46）は中央と候補地の「？」。
- 天空都市の生成は `scripts/build_map_sky.py`（`build_map_float.py` は異界だけ。sky を渡すと止まる）。確認用 `--png`・`--iso`・`--panel`・`--isles <フォルダ>`（島ごとの斜め上の図）。島を足すときは `@isle(key, 名前, 半径)` の関数を足し、10種類の前提（抽選 0..9、`ISLES` の数）を直す。
- **構造物テンプレートの落とし穴（テスト用サーバーで踏んだ）**：(1) NBT の `DataVersion` に今の版（5023）を書くと、`place template` が「Loaded template」と返しても何も置かれなかった。1.21 の 3953 にすると置かれる（`entities` の空の一覧も要素の型を END にした）。(2) 回して置くとき、`place template` が「読み込み済みか」を確かめる範囲が実際に置く範囲とずれ、読み込んであるのに「That position is not loaded」になる。中心±90 を読み込んでいる。(3) 向きの対応は、中心のセル (30,30) が clockwise_90 で (-30,30)、180 で (-30,-30)、counterclockwise_90 で (30,-30)（＝ゲームの式 (-z,x) のとおり）。(4) `#mode oa.map2` は区画のあと水の段で 2 になる。区画のあとの処理で「作成・再生成か」は `unless #mode matches 1` で見る。

## 1.9.232

- **異界を作り直した**（ユーザーの指示）：島どうしの間隔を狭めた（外周の島 中心から約98→80、角の小島 126→104）。**外周の島の中身は固定**（会場を作るたびの抽選をやめた。並び：異界の塔街・コーラスの林・崩れたエンドシティ・異界の塔街・結晶の洞窟・コーラスの林・異界の塔街・黒曜石の森）。島の間に小さな浮島を足した。
- 中央は「竜の祭壇」：岩盤の構造物（帰還ポータルのような窪み・中央の柱・松明）にチェスト4個（特別1）、**頂点にドラゴンの卵**。白い神殿・ガラスのドーム・円盤・空中の足場・地下の遺跡はなくした。
- **黒曜石の柱**（エンドの柱のような円柱）：中央の島に8本（高さ18〜34、2本は鉄格子の籠）、塔街・コーラスの林・黒曜石の森の島に1本ずつ（計12本）。頂上に岩盤とエンドクリスタル（`Invulnerable:1b`、タグ `oa.mdeco`。壊れず爆発しない）。柱の頂上は storage `oa:maps spikes.end`。
- 新しい島の種類「**異界の塔街**」：高さ26〜32の大きな塔1本と、まわりに高さ14〜22の塔4本が密集（真紅とプルプァと石英の帯、光る窓、各階の反りの軒、尖った屋根）。下の2階だけ入れる（はしご）。渡り廊下・桜の木・チェスト。
- **新しい災害「塔の砲撃」**（k12、異界のみ、45秒、危険度4、重み8）：黒曜石の柱の頂上から、生存者ごとに約1.5〜2.5秒おきに光弾。紫の線と足元の輪で1.2秒予告し、狙った地点（撃つ前の位置）に着弾、半径2の生存者に ♥×2（魔法、同時発生の上限つき）。途中にブロックがあればそこで止まる（物陰で防げる）。動きはプラグイン 0.47.0（`disaster/TowerBarrage`）。既存の設定（`oa:disaster cfg`）にない災害の重みは読み込み時に初期値を入れる。
- 異界の固定の並びは `build_map_float.py` の `END_FIXED`。災害を足したら `gen_disasters.py` を実行し、プラグインの `DisasterCommands.KINDS` にも足す。26.3 の `Particle.DRAGON_BREATH` は大きさ（Float）が必要（無いと例外）。

## 1.9.231

- **天空都市・異界の地形と見た目を作り直した**（ユーザーの指示「全部の島が平らで面白くない」）。島の上面に起伏（丘・段丘、最大+9〜+12）、建物の立つ所（中央の城・各島の広場・橋の付け根・転移装置）だけ平らに。島の底は下へ尖り、岩が垂れ下がる。斜面の建物は床下を埋める。
- 天空都市：色の寄棟屋根の家、新しい島の種類「市場」「屋敷」「飛行船の発着場」（停まった飛行船の甲板）、天守の上の時計塔・旗・中庭の屋台、木と草花。空に熱気球8つ・飛行船3隻（`block_display`、タグ `oa.mdeco`、当たり判定なし）。
- 異界：白い未来都市（白いコンクリートと石英の神殿・屋上のガラスのドーム・光る塔・光る床の模様）、枝分かれするコーラスの木、黒曜石の斑、新しい島の種類「白い尖塔」「ガラスのドーム」。空に光る結晶8つ・円盤4つ。
- 転移装置を橋の付け根から離した（中央への向きから55度ずらした縁の近く）。角の小島の地点名の方角が南北逆だったのを修正（+z が南）。
- **ロビーのマップ選択を、マップごとの5つのボタンに**（左から 地上・ネザー・洞窟・天空都市・異界。上に「選択中」「押して選ぶ」「未生成」）。1.9.230 までの「前へ／次へ」は置き換え（既存のロビーも、ロビーの処理が自動で作り直す）。TDM中は切り替えない。
- ロビーの地図パネルに天空都市・異界の絵（リソースパック 1.9.44、`scripts/build_map_float.py --panel` で生成。外周の島は「？」）。
- 床のタグ（補給・開始地点・地面の武器）に石英・白いコンクリート・黒曜石・磨かれた安山岩を足した。
- 生成スクリプトの確認用：`py -3 scripts/build_map_float.py . sky --png 真上.png --iso 斜め上.png --panel パネル.png`（`--iso` は土台＋各スロットの種類0）。起伏の高さは `island(..., amp=…, flats=…)`、建物は地面の高さ `gy(x,z)`・空き `free()` で置く。飾りは `bd()`（block_display）で、apply の区画ごとに `oa.mdeco` を消して出し直す。

## 1.9.230

- **新しいマップ2種類**：天空都市（key `sky`、id 3、`oa:br_sky`）と異界（key `end`、id 4、`oa:br_end`）。どちらも 300×300 の浮遊島（中央の天空城／異界神殿、外周の8つの島、角の4つの小島、橋）。外周の島の中身は会場を作るたびに3種類から抽選（`scripts/build_map_float.py`、タイル関数は洞窟と同じ形）。
- 仕掛け：既存のジャンプ台、転移装置／異界ポータル（双方向2組）、救済用の足場と上昇気流（天空都市）、重力異常エリア・空間の歪みの演出（異界）。動きはプラグイン 0.46.0（`map/MapGimmickService`）。
- マップごとの分岐（約250行）に天空都市・異界を足した（`scripts/add_map_branches.py`、洞窟の行を手本に）。地面の武器・補給の場所は上から床を探す（under 120）。災害は天候・竜巻以外。ロビーのマップ選択（前へ／次へ）・管理コード 120〜131／140〜151・管理メニューに追加。
- 地面の判定のタグにエンドストーン・石レンガなどを足した（補給・開始地点の床）。
- （プラグイン 0.46.0）試合後の自動の作り直し（`map/MapRerollService`）、試合中の地図の絵を会場の地形から作る・地点名は今の組み合わせ、5マップ対応（安全地帯・災害・地図・メニュー）。
- マップを足す手順（今回の例）：`defs` に1行、ディメンション（`dimension`・`dimension_type`・`world_clock`・`timeline`・`worldgen/biome`）、`map/<op>_<key>` の短い関数、`admin/dispatch` のコード、`scripts/add_map_branches.py`（洞窟の行を手本に足す。二度実行しても重ならない）、洞窟だけ `#map matches 2` で分けていた行（補給・地面の武器・場所名・開始地点の登録）を手で、`gen_disasters.py` の maps、ロビーの `lobby/mapsel/*`、プラグインの5か所の配列（`SafeZoneManager`・`DisasterService`・`MatchMapService`・`PlayerMenu`・`MapInteractions`・`NeroMarkService`・`AdminMenu`）。
- 浮遊島マップのスロット：中身の面は `cave_air` で土台を削る（0 は「置かない」）。スロットのチェスト数はそろえる（区画の照合は `#expectedc` に抽選の結果を足して比べる）。

## 1.9.229

- たやゆゆのガチャ「炎」：10秒間のダメージを毎秒1HP→毎秒♡×1（2HP）に。案内とギャラリーのガチャ全結果も更新。
- （プラグイン 0.45.0）竜巻を全体に75%（吸い寄せ 半径28→21、打ち上げ 5→3.75、渦 42段→32段、打ち上げの高さ約75%＝初速1.36→1.18、落下ダメージ無効の範囲 16→12）。上向きの力を弱めた（外側0.03〜中心0.10 → 0.01〜0.045/tick、壁 +0.12→+0.07）。

## 1.9.228

- キリングのマスク：攻撃を当ててから3秒間は、ダメージの無効化が 25%→15% に（張り付いて殴り合う間は倒しやすく）。当てた記録はプラグイン 0.44.0（`oa.katk`＝残りtick）、抽選はデータパックの `curse/prepare`。武器の説明も「すべてのダメージを25%で無効化（攻撃を当ててから3秒間は15%）」に更新（0.38.0 から全ダメージだったが説明が古かった）。

## 1.9.227

- たやゆゆの通常攻撃の打ち上げ：確率 10%→20%、高さを約75%に（浮遊の強さ 12→10、3tick で外すのは同じ。約5m→約4m）、**落下ダメージを受ける**ように（これまでは着地まで落下ダメージ無効）。武器の説明も更新。
- （プラグイン 0.43.0）竜巻の移動2倍・見た目1.5倍・上向きの引っ張り（壁に当たると壁を伝って上がる）。
- 打ち上げの浮遊の強さ（amplifier 9）は `tayayuyu/hit`・`tick`・`clear` の3か所でそろえる（tick・clear は同じ強さの浮遊だけを外す）。

## 1.9.226

- 竜巻：20秒→30秒。マップの中心（`oa:br center`）に現れ、そこからランダムに動く（目印はプラグイン 0.40.0 が出し、いるチャンクを読み込んだままにする）。
- （プラグイン 0.40.0）安置外ダメージをサボテンのような「ペチッ」とした手応えに：向きのない小さな跳ね上がり（地上のとき、横には押さない）と棘の音。安置の外にいる間は1秒ごとに警告音を鳴らし続ける（外に出た瞬間はこれまでどおり大きめの警告音）。
- 竜巻の目印はデータパックでは出さない（`k10/spawn`・`spawn_at` は互換のため残す）。`#tornado br.tmp`=1 を合図にプラグインが出す。

## 1.9.225

- 雪玉・卵の当たりをプラグインへ移した（プラグイン 0.39.0 の `combat/ThrowableService`）。試合中は、ゲーム本来の被弾を止めて、当たった相手にノックバック（速度で押す。卵は雪玉の1.5倍）と 0.1HP（投げた人が発生源）、雪玉なら鈍足II 3秒。対象・除外（投げた人・味方・保護期間・デコイ・倒れている人・キリングの無効化・デバッグ）はこれまでと同じ。データパックの毎tick の光線追跡（`throwable/observe`）とテレポートでの押し出し（`throwable/push`）は呼ばなくなった（関数は互換のため残す）。

## 1.9.224

- ゆー：オーバーワークの通常の出現（チェストのレア枠・地上湧き）を下げた：重み15→8（約9.4%→約5.2%）。空中補給のゆーは 1/3→1/4。
- ゆったり：奇襲の対象がいないときの表示を「奇襲対象がいません」だけに。
- 安置外ダメージ（`oa:zone`）でノックバックしないように（ダメージの種類のタグ `minecraft:no_knockback` に追加）。
- ネロノワール：印を置く音は本人だけに（デコイのデバフ・テレポートの音は今までどおりほかの人にも聞こえる）。
- いとり：シロネンの1.5倍を、5秒間の**すべての攻撃**に（弓矢・トライデント・雪玉などの飛び道具も。プラグイン 0.38.0）。フリンズを 10秒→5秒、雷の追撃の鈍足IIを 2秒→1秒に。武器の説明も更新。
- （プラグイン 0.38.0）キリングの25%無効化を、すべてのダメージ（落下・環境・安置外・災害・モブなど。/kill と奈落は除く）に。ニワトリの卵が当たると♡×0.5。安置の外に出た瞬間に警告音。ネロの印が壁に斜めに当たったら壁を伝って進む（ほぼ垂直なら止まる）。

## 1.9.223

- 今回のお題を入れ替え（12種類）。ふつう：チェスト10個・1キル・6分生存・ジャンプ200回・合計500m移動・鉱石10個・相手に合計♡×10のダメージ。［難］：素手で1キル・封印の宝珠を4つ解錠・チェスト20個・合計1000m移動・相手に合計♡×30のダメージ。
- ［難］のごほうびを「応急キット1つ＋ゆー：オーバーワーク1つ」に（これまで応急キット2つ）。
- チェストを25個開けた・鉱石を50個掘ったとき、それぞれ1試合1回「ゆー：オーバーワーク」を1つ（足元に出る）。チャットに「★ ○○ がチェストを25個開けたので、報酬として ゆー：オーバーワーク をもらいました！」（鉱石も同様）。
- お題の番号は 1.9.221 から入れ替わった（素手のキルは 4→8）。数値を変えるときは `br/mission/name`（文言）と `check`・`check_move`（判定）をそろえる。

## 1.9.222

- 「ゆー：オーバーワーク」の入手方法を2つ追加：空中補給（各便 1/3 で1個。固有武器の1個とは別枠）、2キルのごほうび（その試合で2キル目を取ったとき 1/4 で足元に1個。1試合1回の抽選、生存中のみ）。
- 2キルの抽選済みは `br.yukill`（`br/result/reset` で0）。抽選は `br/kill_overwork`（`ach/new_kill` から）。

## 1.9.221

- 今回のお題を5種類→12種類に。新しいお題：鉱石を5個掘る・相手に合計♡×20のダメージを与える・合計1000m移動する、難しいお題［難］：2キルする・9分以上生き残る・封印の宝珠を解錠する・チェストを15個開ける。［難］のごほうびは応急キット2つ（ほかは1つ）。
- お題の達成の知らせ「★ ○○ が今回のお題を達成！」の「今回のお題」にマウスを乗せると、お題の内容が出るように。お題の文言は `br/mission/name` の1か所にまとめ、ストレージ `oa:br mission`（name・hard）から出す。
- キリングの25%無効化の演出を派手に：閃光・衝撃波（sonic_boom）・花火・トーテム・火花・紫の輪の粒、音は盾＋金床＋鐘＋トーテム＋アメジスト＋花火を重ねる。
- （プラグイン 0.37.5）安置の壁の粒の色を赤・薄い赤・白の3色に。
- お題を足すときは `br/mission/name`（文言・hard）・`pick`（乱数の上限）・`check`（判定）・spec の表をそろえる。

## 1.9.220

- 安置外のアクションバーから、ダメージ（「毎秒♡×1」）と安置までの距離の表示を外し、「⚠ 安全地帯の外です！」だけにした（武器名・CT・味方の表示は残す）。ダメージの量は変えない。
- 安置の壁はプラグイン 0.37.3 で粒（2色の縞・密度約2倍）に戻した（ユーザーの指示）。幕は `wall-style: curtain` で残す。

## 1.9.219

- 安置外ダメージ（既定）を ♡×0.5・1・1.5・2・3（毎秒。第1〜第5収縮から）に（これまで 1・1・2・3・4 HP）。時間割・半径は変えない（プラグイン 0.37.2 の既定）。
- 安置外のアクションバーのダメージを「毎秒2HP」から「毎秒♡×1」の形に（プラグインがストレージ `oa:safezone now.heart` に書く文字を出す）。
- ダメージの文字はプラグインが書くので、表示を変えるときはプラグインの `SafeZoneGeometry.hearts` を直す。

## 1.9.217

実装上の注意：DPの遅延loadはプラグイン起動後にも走るため、oa.templateの初期化はset 0でなくadd 0で復元ロックを保持する。PaperのcreateSnapshotは額縁の中身・取り付け情報を省くため、静的展示は/data getと同じNbtPredicateの完全NBTで保存しUUID・乗客を除く。FULLチャンクでも展示が未読み込みの場合があり、プラグインチケットを保持してisEntitiesLoadedを待つ。手編集ホログラムはJavaの状態板更新だけでなくDPのラベル移行・表示距離更新でも除外する。

- ロビー・地上・ネザー・洞窟・TDM会場を、手編集後に /oaplugin map save <対象> で保存。保存版がある場合は通常の会場生成／再生成・ロビー更新でも保存版を優先する。復元先は保存元のディメンション・座標。
- ブロック・ブロック内のデータ（チェストの中身等）・展示・文字表示・チェスト／鉱石の登録目印とスコア・開始地点／中心情報を一緒に保存。プレイヤー・ドロップ品・戦闘用の一時エンティティは対象外。
- /oaplugin holo でホログラムの作成・既存表示の登録・文字変更・移動・大きさ／色／背景／向き等の編集。手編集表示は動的なロビー表示で上書きしない。map save で他の展示と一緒に保存する。
- 区画ごとの処理、保存履歴、保存完了時の版切り替え、復元前のファイル検証、中断した復元の再起動後の再開、保存中の通常のブロック編集・試合開始の抑止を追加。標準生成へ戻すには /oaplugin map use <対象> generated。

対応：データパック1.9.217＋プラグイン0.35.0＋リソースパック1.9.43（画像・モデル変更なし）。両方の配置後 /oaplugin update apply で再起動。導入のための会場・ロビー・練習場の再生成は不要。保存は導入後に管理者がゲーム内コマンドで行う。本番の既存ワールドへの保存・復元操作は開発側では行っていない。

検証：静的検査・Gradleビルド／単体テストを通過。テスト用Paperで保存・履歴・破損拒否・再起動復元・ロビー更新31項目、未読み込みチャンクと額縁／装備／各種表示の復元18項目が成功。3マップ×ソロ／チームの試合検査は機能検査が成功し、全体313成功・1失敗（洞窟チームの処理時間が基準超過）。待機中のイベント監視を解除するよう修正したが、ユーザーの指示により追加の試合・性能再測定は省略。人による見た目・操作の確認は未実施。記録はdist/validation-1.9.217.json。


## 1.9.216

未使用の判定では、文字列を組み立てるJava側の呼び出し、保存された操作名、マクロの実引数、手動の公開コマンドを起点に含める。空の区画処理だけを削除するときも、チャンク解放と次区画への進行を残す。

- 使用されなくなった関数160個を削除（旧スポーン配置・投擲判定・ガチャ結果・ロビー装飾・災害の旧HUDなど100個、空の水設置／旧統計関数60個）。廃止されたロビー装飾の生成スクリプト2本も削除。
- 災害の旧アクションバー交互表示用のカウンター・タグ更新と、旧水中跳躍・展示ボタンなど、参照されないスコア21種の初期化・書き込みを削除。
- 参照されない設定用の仮スコア9種と、レーダーの表示に使わない方角・ディメンション比較計算も削除。
- マクロ引数・プラグインの動的呼び出し・公開コマンド・互換用別名を含む到達性検査を追加。手動の鉱石／チェスト登録、旧名の武器コマンド、保存データを扱う後始末は維持。

対応：データパック1.9.216＋プラグイン0.34.0＋リソースパック1.9.43（後二者は変更なし）。配置後は /oaplugin update apply で再起動。会場の再生成、ロビー更新 oa.admin 14、練習場の更新は不要。

検証：関数到達性（残る3512関数・未使用候補0）・公開／動的呼び出しと空関数の検査テスト・静的検査を通過。テスト用Paperの3マップ×ソロ／チーム6試合で307項目成功。追加の仮スコア・レーダー・空関数の整理後、最終構成を再起動し地上ソロ131項目とレーダーの座標／ワールド名／チャット・現行設定13項目がすべて成功。水の配置・区画解放・次区画への進行コマンドが同一であることも静的確認し、最終テスト用データがソースと一致することを照合した。追加reloadは省略して起動時の読み込みを検査。人による見た目・操作の確認は未実施。記録：dist/validation-1.9.216.json。


## 1.9.215

表示を廃止するときは、titleの削除だけでなく通常バー側のreturnガードも点検する。宝珠の離脱検査は、他の生存者が近くにいない条件を隔離して確認する（本人だけ離れても発光が残るのが正しい場合がある）。

- ゆずぽん・小豆・ミラノ風ドリア・非常食の説明から「ゲージ」を削除し、満腹度は食料アイコン×2.5だけを表示。効果量は変更なし。既存の持ち物も更新し、生成直後と更新後のコンポーネントを一致させる。
- BR3マップとTDM会場で、装飾用の樽・かまど・ホッパー・未登録のチェストなどの収納を開けないようにする。エンダーチェストも開封不可。登録された通常／特別の物資チェストは開けられる。ロビー・練習場・管理メニューは対象外。
- 試合会場で鉱石を掘っても経験値オーブを出さない。鉱石の破壊・アイテムドロップ・採掘報酬・いとりの進行度は維持。
- 空中補給は、着地前だけ従来通り3秒ごとに補給案内と通常の武器・CT表示を切り替える。着地後は通常の表示へ戻し、補給案内のアクションバーを出さない。着地のチャット・物資・地図の表示は維持。
- 1.9.214で災害のアクションバー上書きを外した際に、通常バー側の旧抑止条件が残っていたため削除。災害中も通常の武器・CT表示を止めない。

対応：データパック1.9.215＋プラグイン0.34.0＋リソースパック1.9.43（変更なし）。両方が配置されたら /oaplugin update apply で再起動。会場・ロビーの再生成、oa.admin 14、練習場の更新は不要。既存の食料は所持中に説明を自動更新。

検証：静的検査（医療品の生成／所持更新の全コンポーネント一致を含む）・Gradle build・テスト用Paper起動。3マップ×ソロ／チームの6試合、収納・採掘48項目（ロビー／練習場との比較、実際の開封と鉱石破壊・アイテム／経験値ドロップを含む）、食料4種、着地前後の補給案内を検査し、今回追加の77項目は全成功。既存の宝珠テストは近くの他の生存者も考慮するよう条件を隔離して修正し、地上ソロを再実行して131項目すべて成功。原記録・再検査は dist/validation-1.9.215.json を参照。追加reloadは省略し起動時の読み込みで検査。人によるクリック・見た目の確認は未実施。


## 1.9.214

- ブタの大行進を2列×6匹の隊列へ変更。隊列は生存者の周りを周回し、全てのブタから毎秒爆発（地形破壊なし、♥×1、同じ人へ2秒に1回、災害ダメージ上限は維持）。危険度★3。動物上限内で隊列ごとに生成。
- ニワトリは頻繁な方向転換と跳躍を行い、生存者を狙って卵を投げる。卵はダメージなし・ノックバックあり・孵化なし。観戦者と練習者は対象外、終了時は卵も片付ける。
- 重力異常20秒・ニワトリ20秒・血の月30秒・竜巻20秒。血の月に名称を統一し、速度Iを付与。災害によるアクションバー上書きを廃止。
- 災害の間隔50〜75秒、初回30〜45秒（保護期間後から計時、予告5秒・補給や収縮との重複回避は従来通り）。
- 海中遺跡のチェスト2か所を両方特別に（地上の特別チェスト計7）。既存会場も次の試合で自動更新し、再生成不要。
- 練習場の展示を台座の中心へ。ゆったりの展示を前後反転。展示は入場時に自動更新。
- たやガチャ：時限爆弾3%、大爆発2%、大当たり0.5%、復活4%、災害コンボ4%。残り11種は各86.5/11%（約7.864%）で完全に均等。巨大化は地上・ネザー5倍、洞窟2.5倍。
- ネロの本人デコイ10秒、攻撃者の盲目・弱体化・発光を各5秒。ゆったりの暗闇を盲目5秒へ。らじの最大体力増加を♥×4（+8HP）へ。
- 固有武器の攻撃力は基礎値と属性加算、補充後の加算、いとりの紫弾・各スキルの直接ダメージを照合。基本ダメージの不一致はなし。表示を補充前の数値（補充後の数値）へ統一し、補充後の説明も同じ並びにする。
- 宝珠の案内を「封印の宝珠／宝珠を右クリックで解錠」へ。生存者が12m以内にいる間は宝珠が発光。

対応：データパック1.9.214＋プラグイン0.33.0＋リソースパック1.9.43（変更なし）。両方の配布がそろってから /oaplugin update apply で再起動。会場・ロビーの再生成不要（oa.admin 14 不要）。練習場の展示は入場時に自動更新。

検証：静的検査・武器ダメージ照合53項目・Gradle build・テスト用Paper起動。3マップのソロ／チーム計6試合（補給・補充・途中参加・勝敗・復元）、災害11種類・2〜3種同時・全災害コンボを自動検査。旧条件の管理メニュー／チーム選択解除、NBT出力省略・既定値省略・効果時間の経過を考慮して検査を修正し、変更箇所と該当処理45項目の再検査は全成功。元の失敗記録と置換理由は dist/validation-1.9.214.json に保持。追加の /reload はメモリ逼迫時に長時間停止したため中断し、起動時の読み込みで検査した。巨大化時は壁際の当たり判定の食い込みの位置診断あり（従来の仕様）。人が操作した見た目・動物の動きの自然さ・ノックバックの手触りは未確認。

落とし穴：練習場の positioned 0 64 0 はX/Zに0.5を加えるため、展示生成前に align xyz を通す。生成関数だけを直接直さず gen_practice_catalog.py も更新する。


## 現状
- 1.9.218：安全地帯はプラグインの zone/SafeZoneManager（円形）。データパックは #zr・#zrb・#znow*・#ztarget*・#phase・#shrinking・#next・#zdmg・br.out・br.edge・br.edged・storage oa:safezone を読むだけ。ワールドボーダーは試合中も300で、縮めない。安置の範囲に出す物は br/zone/area を通す。Ubuntu の自動更新は PowerShell 7 で同じスクリプト（platform.ps1 が差を吸収）、起動ループは start-server.sh。

- 1.9.213：試合開始は br/countdown（#countdown br.tmp が1以上の間、br/tick は試合時間を進めずに return）。試合時間に結び付けた処理を足すときは、カウントダウン中に動かないことに注意。プラグインからデータパックの関数を呼ぶときは DatapackBridge.run（出力なし）を使う（Bukkit.dispatchCommand のコンソールは OP のチャットに記録が流れる）。位置の床判定は #oa:low_floor（高さ1未満の床）も床として扱う。

- 1.9.212：災害は種類ごとの残り秒 #dsN で複数同時に進む（通常の抽選・災害コンボ共通）。定義の正本は scripts/gen_disasters.py（直接編集しない生成物：disaster/go・run・stop・halt・pick・available・announce・bar・start_planned・run_all・count・cfg_defaults・admin/start・multi・list・combo/plan_all）。災害の中身は disaster/k<N>/start・second・end。kN/second は #dis_left を「この災害の残り秒」として読める（run/kN が入れ替える）。継続ダメージは disaster/dmg を通す（同時発生中の上限）。プレイヤーに付ける属性は名前 oa:dis_* にして、終わるときはその名前だけ外す。竜巻・動物の動きはプラグインの DisasterService。マップ定義の disasters（pool）は使わない。

- 1.9.211：持ち物の更新処理（inventory/text_refresh・normal/visual_tick など、目印がない物を書き換える）を足したら、ドロップ表にも同じ目印・同じ中身を入れる。確かめるのは tools/item_parity.py（data get は深い所を {.. と省略するので、種類と custom_data などで区別している）。練習場の通常装備は gen_practice_catalog.py がドロップ表の modifier をそのまま写す。キルログはプラグインの KillLog（ダメージの種類→固有武器の表、攻撃した人のタグ→武器）。新しいダメージの種類・発生源タグを足したら KillLog の表にも足す。医療品の中身を変えたら目印の版（medical_text211）を上げる。

- 1.9.210：プレイヤーの nbt={Health:0.0f} を毎 tick 読むのをやめ、プラグインのタグ oa.dead に。新しく書く「倒れていない人」の条件は tag=!oa.dead（プレイヤー）を使い、NBT はモブだけ。プラグインがないときは internal/life_fallback が同じタグを付ける（#life oa.plugin はプラグインが毎 tick 1、tick の終わりに0）。接地は述語 oa:airborne。固有武器の粒はプラグインの HeldParticles（データパックの visual/held_particles は削除）。

- 1.9.209：展示背面とベンチが正面入口を塞いでいた。gen_lobby_terminalの見た目と別に直通経路を検査する。練習場はgen_practice_catalog.pyでBRのlootから品揃え／見た目／直接配布／旧入口の制限を生成。armor_breakは集計されたbroken統計でなくPlayerItemBreakEventで実物の材質・OAタグ／モデルを確認（誤解除済みの履歴はそのまま）。前回結果JSONへuuidを追加し表示側は非同期プロフィールを利用、未解決ならSteve模型を出さない。実際のゲーム内操作・描画は未確認。

- 1.9.208：医療品の説明更新だけに付くmedical_textフラグで生成直後と差があった。共通compにmedical_text208を含め、全lootへdeepcopy、modifierも同じcompだけを設定。採掘側と所持更新側のデータ一致を保つこと。ユーザー確認で対象は医療品。石炭の通常食料は元からチェストと同じ設定。実際の採掘操作は未確認。出血2/20tick、地図表示の着地判定は変更なし。

- 1.9.207：全員outline=False。5人の文字色を明るく変更。gen_weapon_presentationのJSONコンポーネント更新はfont/shadow等も除去し、地面ラベルの生成ブロックを毎回置き換える。古い白縁用アセットは互換用に残るが参照しない。性能・モデル変更なし。実クライアント描画は未確認。

- 1.9.206：共通fields/namedとgen_weapon_presentation.pyで説明順・色・白縁を生成。TDM HUDはマクロ文字列でなくinterpret付きコンポーネント。白縁フォントは色焼き込みのため文字色をwhiteにし、親の色を継承させない。実クライアントの描画は未確認。

- 1.9.205：rich/UnitTextはアイコン個数のみ。共通fields()でゆーの通常攻撃と右クリック、ふろっしゅの通常攻撃を省略。description205系の版印で既存品も更新。

- 1.9.204：weapon_catalog.py→gen_weapon_text.pyが説明の正本。タグdescription204/description_up、name_v204、itori_text204で既存品も更新。melee_*の実値は変更せずrefill_damage後にloreを更新。いとりは独立した通常ダメージ条件と同じ判定で表示＋1を切替。
- カスタムデータの版フラグは必ず1b（intの1だと既存の述語1bに一致せず毎tick更新になる）。進行度はintで保持。

- 1.9.203：ロビーを空間構成から再設計（出撃ターミナル v203）。生成元は scripts/gen_lobby_terminal.py（＋lobby_models.py で武器モデルの見かけの中心、render_lobby_preview.py でプレビュー）。生成時に、主通路・端末前の到達・当たり判定の重なり・ブロック光（舗装9／芝生7／端末前13以上）・浮き・ガラス板／柵／塀の接続を検査し、失敗すると書き出さない。範囲は1.9.202と同じ X/Z±40・Y-3〜+44。印は origin.terminal:203、202は tick_202 のまま。203では board/tick・gallery/update(46→terminal/refresh)・update_skins(51)・tdm/lobby_build が旧設備を作らない。
- 受付端末は interaction タグ oa.term.<action>。処理はプラグイン PlayerMenu.terminal（本人＝クリックしたプレイヤー）。DP側の入口は lobby/terminal/br_team・tdm_team・set_format・start_br・start_tdm（モード違いは拒否）。BR形式は #pref br.mode（load で 0 に初期化）。
- 表示の文字はプラグイン LobbyBoards が更新（oa.screen.*・oa.terminal.*・oa.gallery.*）。戦績ギャラリーは StatsStore の全期間と前回の試合、実績は oa.t_ach。DPの戦績ボード（board/*）は203では動かない。
- 一般化：text_display の大きさ1は1行が約0.25ブロック（1px=1/40ブロック）。看板の文字は離れて読む距離から大きさを決める（1.9.202の端末の文字は0.4〜0.7で小さすぎた）。
- 一般化：整数座標の `positioned X Y Z` は X/Z がブロック中心（+0.5）になる。ブロック（fill/setblock の ~）は影響しないが、summon した表示・当たり判定は0.5ずれる。lobby/build は `align xyz` を通す（1.9.202 までの表示も0.5ずれていた。tools/lobby_check.py の位置検査で発見）。
- 一般化：26.3 では chain → iron_chain。旧名の fill/setblock は関数ごと読み込めない（check_release.py が検出）。
- 一般化：テスト用サーバーの起動ログの oshi（Windows の性能カウンタ）の ERROR はデータパックと無関係。
- 生成試験でtext/item_displayのtransformationはscaleだけではSerialization errorsになることを確認。translationと左右のquaternionも生成元で明示し、再生成で警告なしを確認。起動だけではsummon時の不備は見えない。

- 1.9.202：lobby/buildはgen_lobby_terminal.py生成のterminal/buildのみ。save_originのterminal:202で新tickへ分岐し、旧gallery/map_labels/練習ゲート/羊毛パッドの再生成を避ける。旧ロビーは手動再建まで旧tick。右ギャラリーへboard処理を原点+26X/+20Zで移設。
- PlayerMenuは /oa とinteractionの実クリック者を使う。oa.ui=1で一般画面へ。旧公開triggerやbr.pick/tdm.teamは維持。map/selectは登録ホストも選択だけ許可。生成・削除は管理者のmap/doのまま。
- 本はgen_player_book.py、管理本はgen_admin_book.py→gen_admin_terminal_book.py。admin/book_contentはmode/map/stateのマクロ、取得時の状態と明記。

- 1.9.201：キル時tdm.foodはキル差分×8。heal_takeはHP10＋tdm.food10。foodLevelの実値も見て、HP・満腹度の両方満タンの場合だけ消費しない。既存プラグイン0.20.0が2tickごとに上限20まで加算。

- 1.9.200：TDMの開始時title times 0/25/0が終了まで残るため、finishで5/60/10に明示。冒険モードの待機者はcombat/select_targetsで除外し、yuttari/use・returnにも待機ガード、clean_playerで保存原点と入力を破棄。
- TdmMenuは固有item_model付き8アイコンを2段配置。管理操作は試合前のbr.host/br.adminだけに表示・実行。warmup中も選択可能、開始時tdm.ui=1。選択の許可はDP側も一致。
- OverworkServiceはインベントリ発動時、復活statusより先にクライアントだけへ実物ゆーを手のスロットに送信し、次tick実スロットを再送。実在庫・手持ちは移動せず、消費は従来どおり1個。
- BR順位は保存するMatchResultと同じ2＋長く生存した非優勝者数。jackpot_titleは優勝者だけへ送り、敗者の順位を上書きしない。

- 1.9.199：oni_hatを実際のTNT頭装備へ変更。inventory/dropで元の頭を落とし、失敗時は上書きしない。oa_tnt_oniタグの固定装備。oni_dropで自前TNTのみ消し、equip_curse/equip_yuua/equipは鬼の間停止。curse/tickは本当にマスクを装着している時だけ走り、TNTへマスクのモデルを上書きしない。
- キリング：enchantment/curseのdamage_immunityを削除して通常攻撃をプラグインcombat/KillingParryで止め、curse/rollを呼ぶ。oa.curse_guardの既存抽選を共有、oa.routed_damageはDP側へ任せる。保護キャンセル後のHIGHEST/ignoreCancelledでパリィの誤発火を防ぐ。必ずプラグイン0.19.0を先に配置し、ペアで反映する。
- TDM再生IV/速度II5秒、tdm.healをプラグインで実HPへ加算して10HPを保証。loadoutは#warmup>0の間は選択武器を配らず、warmup終了時に配布。
- 1.9.198：補給spawnからbr/supply/unique（固有10種、ゆー除外、ゆうあ1個制限）を必ず1回呼ぶ。元気百倍はhealth_revealを全生存者へ10秒、強化は従来どおり使用者だけ。TNT鬼はoni_revealを開始時と毎秒呼び、oa.goni_glowをoni_resetで解除。鬼の押しつけでは全員発光を消さない。
- ゆー：プラグイン0.18.0 weapon/OverworkServiceが手のトーテムなしでキャンセル初期値のEntityResurrectEventを受け、通常インベントリのoa_overwork付きトーテム1個を消費して復活を許可。overwork/usedで従来の2tick待ちへ接続。手にトーテムがある場合は介入しない。PaperのLivingEntityバイトコードで、手にない場合も復活イベント・既定トーテム効果が使われ、used_totem進捗は実物がある場合だけ発火することを確認。実際の致死イベントでの試験は未実施。
- 1.9.197：TDM HUD（hud_player→hud_lineマクロ、保有武器とCT）、回復ドロップ104=4HP、キル時の再生II/速度II/tdm.food+4。満腹度の実数加算はプラグイン0.17.0 TdmMenu。地面はシフトで武器交換し、drop_fromが実アイテムをtdm.savedのitem_displayへコピー。tdm.dropidで本体と名前表示を対応させremoveで両方を消す。tdm.lock=20、tdm.swap_latchedで即時拾い直しを防止。
- マップ#ready=197、生成元gen_tdm_map_v197.py。専用dimension_type oa:tdm（ambient_light0.25）、光源・看板・2方向から登れる整備通路。151候補の静的検査。勝利の音・粒子はロビーへ戻った2tick後に再生。マクロのname/slotとstorageを目視で照合。
- 1.9.196：nero/saveのdimension分岐にoa:tdmがなく、TDM位置がoverworldとして保存されていた。ネロ帰還の境界拒否とゆったり帰還の誤ディメンションにつながる。プラグインNeroMarkServiceもTDMを境界判定の対象外にしていたため対応。死亡時のクライアント再出現はプラグインTdmMenuのPlayerRespawnEventでTDM待機室へ固定し、lobby/login_warpもtdm.playerを除外。
- TDM: GUIはプラグインtdm/TdmMenu、ゲーム本体はデータパックtdm/*。tdm.ui=1でGUI、tdm.wait=200tick、#warmup tdm.sys=200tick、マップ#ready=196。新会場生成元scripts/gen_tdm_map_v196.py（既存gen_tdm_map.pyから起動）。155出現候補・通常移動経路を静的検査。標準装備とキルごと矢5本、重み付きランダム出現、ゆうあ150秒、ゆー不定期。
- 一般化：共通の位置保存・プラグインのディメンション判定・バニラの復活イベントも新ディメンション追加時の点検対象。起動できることはTPや復活が正常である証拠にはならない。
- 1.9.195：TDMを追加。tdm/*が進行・武器選択・拾得・復活・得点を担当。#game oa.game（0=BR/1=TDM）は選択、#active tdm.sysは進行中。br.state=1とbr.playing/br.aliveを武器・参加保護用に共用するが、BRのtick/loot/終了判定は入口で分岐する。BRの保存ID・br.pickは維持。専用dimensionはoa:tdm、マップ生成元はscripts/gen_tdm_map.py。
- 新ディメンションを足すときは武器のマクロ内のディメンション列挙（特にnero/return_live・clear_mark、internal/clear_owned、itoriの演出解除）も足す。TDMではBR境界判定を使わない。プラグイン側はTDMの地図配布除外と味方発光に対応（0.15.0）。
- 検証はユーザー指示により静的・起動チェックまで。試合進行・マップの実地確認は未確認。
- 1.9.194：武器調整。inventory/refill_damageで主手の数値を試合状態に合わせて置換し、加算の重複・練習場への持ち越しを防ぐ。いとりはnormal_damageで補充後の基礎値を3HPに。
- 1.9.193：大爆発（tayayuyu/blast）に「たやゆゆの負け」のタイトル。大当たりのタイトルは win_solo/win_team から 20 tick 後。
- 1.9.192：ガチャに時限爆弾（tayayuyu/oni_*、tick → oni_tick、#g_oni 残り tick、頭のTNTは item_display oa.g_oni_hat を毎 tick 目の上へ tp、押しつけは進捗 oa:tayayuyu/oni_pass＝鬼に直接殴られた人）と大爆発（blast、oa:gacha_blast）。抽選は1〜1500。大当たりのタイトルは win_solo/win_team から schedule。
- 1.9.191：たやゆゆのガチャを入れ替え（spec §7.3）。抽選 tayayuyu/roll（1〜1300、≤13 が大当たり14）、実行 tayayuyu/apply、テスト tayayuyu/test・force・test_menu。TNTの雨は br/second → tnt_second、降るTNT（タグ oa.g_tnt）は world_tick → tnt_tick。災害コンボは disaster/combo/*（#dc1〜6 に種類ごとの残り秒、#dis_left を一時的に入れ替えて kN/second を呼ぶ）。復活のお面は ach/new_kill → revive_rearm（タグ oa.g_revived）。爆速の止まれない動きはプラグイン 0.14.0 の RushService。
- 1.9.190：practice/enter の待機中の条件を外した（試合に出ていない人は試合中も入れる）。不参加パッド（brown_wool、ロビー原点から x=-9〜-7・z=32〜34、lobby/tick で br/sit_out）。今あるロビーには lobby/pad_optout（ストレージ oa:lobby optout_pad）が1回置く。lobby/build にも追加。
- 1.9.189：エリア外の猶予2秒。br/zone/out_track（br/tick から5 tick ごと、br.outt に外にいる tick）、br/zone/player は br.outt 40 以上のときだけダメージ。
- 1.9.188：武器の毎 tick の処理をプラグイン 0.13.0 へ（weapon/FuroballService・NeroMarkService・RootHoldService・ItoriBoltService）。データパックに残すのは、出す（furoball/spawn・nero/mark_or_return・itori/bolt_spawn・hotchikisu/root_target）と当たったあと（furoball/explode・itori/bolt_hit・kill_effect）と粒。プラグインは当たったら `execute as <弾> at @s run function …` を呼ぶ。ふろボールは #f_owner・#f_team・oa.f_current をプラグインが用意。
- 1.9.187：ネロの印の目印 item_display（oa.nero_vis、oa.id＝持ち主、oa.mvis が0で消える。プラグインの OwnerOnlyVisibility が本人以外から隠す）、mark_tick の粒は常時 oa.mark_owner に。nero/return は oa.stapled なら release_root してから飛ぶ。ぴちぴちの fish/fall_guard（fall_damage_multiplier oa:fish_fall、predicate oa:airborne、oa.ffall）。combat/select_targets は debug/select_targets のあとに模擬戦の相手を足す（debug 側が最初に全部消すため）。debug/furo_pool・itori/bolt_step に模擬戦の相手。
- 1.9.186：参加しない印 br.optout（br/leave で付き br/join で外れる。lobby/tick の自動登録は除外、br/team/select は未登録なら br/join）。admin/players/sit_out・set_team {n}・clear_team、admin/reset/*（プラグインから本人として呼ぶ）。試合開始の案内は br/intro → 初心者サポート → br/intro_end。お題のごほうび loot oa:br/medkit。ふろボールの打ち返し：interaction の当たり判定（oa.furo_hitbox、oa.fid で結ぶ、oa.fhb が0で消える）、furoball/deflect_check・deflect。バフ品 400tick・nutrition 5（印 buff_v1186）。補給 br/supply/far_check（#sup_min2）・cave_chest。毒霧 k4 は中心の目印1つ、半径 #fog_r。ネロの印 #flight 48・mark_step 0.25m×4・mark_clear（#oa:spawn_clear）・mark_climb（oa.mclimb）、粒は oa.mark_owner だけ。練習場 practice/vanilla/*、curse/radar はダミーも（@e[tag=oa.radar_target]）、enchantment/bat に debug_mob の分岐。tools/autoupdate/update.ps1 は applyMode restart（loadedSha・installedAt で置いただけかを見分ける）。
- 1.9.185：br/team/reset は br.pick を消さない（試合後も保つ）、cleanup/done・abort・br/restore の最後に br/team/sync。保護期間はソロでも oa_brgrace に入れない（live_join・tayayuyu/peace・revive も）、プレイヤー同士のダメージはプラグイン 0.9.0 の GraceProtection（EntityDamageByEntityEvent）。応急キットは consume 1秒・14HP・再生 I 10秒、印 kit_v1185（medical/upgrade）。medical/cap の上限は2tick後に cap_clear で外す（同じ tick に外すと即時回復が満タンまで効いていた）。yuua/strike の相手は @a（死んだプレイヤーは @e で選べない）。
- 1.9.184：即時リスポーン・実績メッセージ（br/start→finish・cleanup）とゆうあの死亡メッセージ（yuua/silence_*）をディメンションごとに設定（internal/gamerule_match・gamerule_all、引数 rule・value のマクロ）。保存・戻しはオーバーワールドの値。自然回復と br/world/* のスポーン系はまだ実行位置だけ。
- 1.9.183：ロケーターバーを全ディメンションで OFF（br/locator/all_off、毎秒 br/locator/tick から。true のワールドだけ書き換え）。Paper のゲームルールはワールドごと。同じ理由で、br/start の自然回復・即時リスポーン・実績メッセージ、ゆうあの show_death_messages、br/world/* のスポーン系は、実行位置（多くはオーバーワールド）にしか効いていない（未修正）。
- 1.9.182：軽量化。毎tick全員の持ち物の1マスずつの確認に、先頭で「対象の物がどこにもなければ return 0」の行（`items entity @s container.*` などのワイルドカード）。inventory/check のマスごとの処理は inventory/scan_slots、player_tick の oa.kind の11行は internal/kind_scan に移しただけ（順番も元のまま）。ground/pick は足もと1.5に拾える物がなければ終了、oa.pick の検索に type・distance。鉱石の点は br.ostg の4組に分けて1秒に1回＋生存者から8以内は5tickごと（ご褒美は7以内の人に渡すため）。測り方：テスト用サーバーで `tick query`（smoke_test.py の --max-mspt）と `/debug function oa:tick` → `oa_battleroyale_plugin/tools/trace_summary.py`。残る重いもの：ach/armor_check（毎秒1人50コマンド）、br/loot/chest_tick、br/zone/hud、br/ui/item_name。
- 1.9.181：通算（oa.t_games・t_win・t_kill）はプラグインの試合の記録が正本（br/stats/add で足さない、result/show で ach/stats_check を呼ばない。プラグインが書き込んで呼ぶ）。実績 yuua_sleep・killing_sleep は続けて30秒以上（br.a_w1/a_w5）。封印の宝珠の残り秒数の表示を1つずれていたのを修正（disaster/relic/pulse は dtmr/20、開始時に「あと5秒」）。
- 1.9.180：admin/players/live_join（途中参加）にも tp_fix（TP直後）と tp_fix_all（3tick後から10tickごと7回）、保存の前に internal/id。br/restore の保存データなし → br/restore_missing（br.retry=1 で毎tickのくり返しを止める）。admin/players/spawn_cave_try の高さ判定を体積の選択から Pos[1] のスコアに（大きさ0の防具立てが選ばれず洞窟の途中参加が毎回失敗）、admin/players/spawn の目印は生存者の位置に出す。実績 yuua_sleep・killing_sleep を被っている期間ごとに（br.a_k1/a_k5、oa.a_on1/a_on5）。どれもプラグインの自動テスト（途中参加の検査）で発見・確認。
- 1.9.179：1.9.178 の advancement/ach_trig/dqn.json が読み込めず、サーバーが起動しない不具合を修正。26.3 の entity_killed_player の player／entity は条件1つ（オブジェクト）で、配列は不可（Paper 26.3 のテスト用サーバーで発見・修正後に起動を確認）。
- 1.9.178：実績 tayayuyu_dqn。tayayuyu/hat_all で引いた本人に oa.dqn、advancement/ach_trig/dqn.json（entity_killed_player、倒した人の頭が kind:1）→ ach/trig/dqn。
- 1.9.177：lazi のマスクに防具力3・防具強度2（item_modifier visual/k3 の set_attributes、replace:false。印 mask_v1177 で既存品にも1回）。
- 1.9.176：lazi は CT2秒（oa.cd 40）、音波2HP、息切れ30%（oa.breath 40＝鈍足2秒）。1.9.175 の連続回数 oa.lzn は廃止（load からも削除。既存ワールドの目的は残るが未使用）。
- 1.9.175：lazi の音波4HP、抽選 息切れ25%／攻撃75%、攻撃4連続の次は息切れ（oa.lzn、load で作成、lazi/out_of_breath で0）。
- 1.9.174：ツルハシの can_break を固定（br/enter）、br/mining/player は廃止（return 0）。報酬は loot give、鉱石の位置のアイテムは tp で本人へ。洞窟の終盤演出を減らした。チェストの再補充の札の秒ずれは静的には原因不明（処理落ちを推定）。
- 1.9.173：実績の作り直し（表は scripts/gen_ach_1_9_123.py）。キルの相手が要る実績は、倒された側のタグ（oa.nm_*／oa.stapled／oa.tired）を条件にした進捗 advancement/ach_trig/*.json と、そのご褒美 function ach/trig/*（自分で進捗を取り消して何度でも判定）。毎秒の判定は ach/second（br/second から生存者ごと）、防具の破損は ach/armor_check（統計 minecraft.broken、目的 oa.ab0〜oa.ab24）。試合ごとの数は ach/reset（br/start の assign_pid）で0に戻す。
- 1.9.172：特別チェストの削減。地上はタイルの apply／water_apply の該当行を直接書き換え（register/chest ↔ chest_rich、loot chest_basic ↔ chest_site。地上のタイルは生成スクリプトで作り直さない）。ネザーは build_map_nether.py の最後で riches の一部を chests へ移す（_keep）。洞窟は build_map_cave.py の各配置の数と、祭壇・島の移し替え。
- 1.9.171：finale/step はマップ定義の y（全マップ 80）で演出関数を呼ぶ。洞窟は天井の上になるので finale/cave で 29 下げて finale/cave_at を呼ぶ。ランプ（神殿の床の輪 A/B/C と天井 D）は build_map_cave.py が置き、点滅の関数 maps/cave/finale_lamps・finale_all_on・finale_pillars も書き出す（神殿の床の立ち位置 y51 を原点とした相対座標）。br/finale/lamps_on（試合の終わり）に洞窟のランプを全部つける行を足した。地図パネルの描き直しは scripts/voxelize_tiles.py（地上のタイル関数→3D）と、リソースパックの source/build_lobby_map_*_1_9_39.py。
- 1.9.170：洞窟の古代都市（build_map_cave.py の「# 5 古代都市」の節、乱数 SEED+55）を作り直し：中央の4区画は広場、残りの区画に家・塔・廃墟。明るさは dimension_type の ambient_light 0.1 と、トンネル・エリアの明かりの確率。リソースパック 1.9.38（地図パネルの名前）。
- 1.9.169：ネザーの生成スクリプトの最後（到達性の検算の前）に、宝物庫の中庭の通常チェスト8を乱数なしで追加（変わるのは apply/place の 44・45・54 だけ）。洞窟は NCH=100・NORE=180（定数）、神殿の壁ぎわ8、中間の空洞3ずつ。マップ選択の文字は lobby/mapsel/labels（peek で行き先を探す。step_try と同じ順）。
- 1.9.168：特別チェストの最低保証（loot_table br/rich_iron を chest_site のプールに、chest_initial_late は rich のとき loot insert）。補給の着地後の光の柱（supply/fx の end_rod）を削除。マップ選択は前へ／次へ（lobby/mapsel/step・step_try、マーカー oa.mapsel_prev/next、文字 oa.mapsel_t_cur。マップを増やしたら step_try に1行足し、折り返しの数を直す）。左右は「パネルの前に立つと東が左」という推定で、前へ＝+x 側。
- 1.9.167：洞窟マップ（key `cave`、id 2、`oa:br_cave`）。生成は `scripts/build_map_cave.py`（2Dの「開いた場所・床・天井までの高さ・エリア」を描いてから3Dに起こす。床は隣と1段以内になるまでならす。到達性はBFSで検査）。地図パネルは `scripts/render_cave_panel.py`。マップごとの分岐は `#map oa.mapid matches 1 in oa:br_nether` の行を機械的に複製して `matches 2 in oa:br_cave` を足した（74ファイル112行）ほか、`unless dimension oa:br unless dimension oa:br_nether` に `unless dimension oa:br_cave` を足した。洞窟だけ動きを変えたのは：補給（launch_cave、place_try の under、ground_ok の頭上8、cave_fallback）、地面の武器（ground_try の under、random_ground の追加試行）、途中参加（admin/players/spawn_cave）、spawn_reroll、k3（warn_cave・impact_cave＝落盤）、finale/cave、pool/cave。`spreadplayers under` は岩だけの列では奈落（最低高度）に置くので、必ず床の判定で落とすこと。バリアを `#oa:spawn_unsafe_floor` に足した。
- 1.9.166：ぴちぴちの速度（oa:fish 1.5 add_multiplied_total）を廃止。ユーザーが v1.9.165.1（7101ee7）で fish/speed_upgrade の追加行を消し、active_changed の追加行も削除。外す処理（speed_upgrade・active_changed・cleanup の remove）は残す（古い付与を外すため）。
- 1.9.165：練習場の武器の名札の z を 14.5／18.5 → 15.5／19.5（台座のブロックの中心＝item_display と同じ）。1.9.161 以前から1ブロックずれていた。レイアウト版 1999。
- 1.9.164：ぴちぴちの激流を2に（fish_riptide_on.json）。所持中のアイテムを差し替えるため custom_data の目印を `{oa:{riptide1916:1b,rip2:1b}}` にして riptide_tick の判定も合わせた（この目印を変えないと、既存のトライデントが古いレベルのまま残る）。
- 1.9.163：k1/check・k2/check・k3/impact の屋根判定 `positioned over world_surface positioned ~ ~-40.9 ~ unless entity @s[dx=0,dy=40,dz=0]` は、箱が高さ41（dy+1）で上端が最上面+0.1 になり、外の人も常に「屋根の下」だった（1.9.131 から酸性雨・寒波、隕石群も同じ書き方でダメージなし）。−41.9 に直した。
- 1.9.162：ロビーの飾りは lobby/decor_v162（scripts/gen_lobby_decor_1_9_162.py で生成、build の decor の直後）。戦績ボードの行は `execute if entity @a[tag=oa.bsN]` 付きで召喚。ぴちぴちの跳躍 oa:fish_jump 0.5。練習場の台座は practice/build の各ブロック（11行ずつ）と showcase をずらし（平面図は build を Python でボクセルに展開して確認）、建物の名前の text_display を削除、レイアウト版 1998。練習場メニューの本は2ページ（custom_data practice_book_v162、古い本は practice/book で消して配り直す）、208＝practice/click/clear_items。
- 1.9.161：保護期間中のチームの名前表示を hideForOtherTeams に（br/grace/start）。補給の予告を tick 3900/6300/8700 に（br/loot/tick。中身の段階は preview の時刻範囲 ..6000/6001..8400/8401.. のまま合う）。災害は disaster/busy の秒の範囲では始めず、#dis_cd を0のまま待つ。補給の着地点は br/supply/place_try（spreadplayers を最大20回）→ ground_ok（#oa:supply_ground、#oa:spawn_clear で足・頭・上、前後左右2ブロック先の2段の段差。草の上なら ground_down で下げる）。特別チェストは chest_site の重み 上位2:通常3、chest_rare で当選率2倍。
- 1.9.160：特別チェスト（`br.rich`）に金色の粒（br/loot/chest_tick の末尾、0.5秒ごと）と、開封後の札「★ 特別チェスト／開封済み」。空中補給の落下範囲（br/supply/drop）を、縮小後のエリア（第1便 半分80、第2・3便 半分45）から10引いた値に。以前は予告の瞬間の #half（縮小開始時で、縮む前の大きさ）から8引いていた。
- 1.9.159：再補充までの残り時間を、チェストの名前から「開封済み」の札（text_display `br.open_label`）の2行目へ移した（br/loot/open_label が storage oa:br open_label を作り、open_label_all が毎秒札を書き換える。tick 7240 以降は書き換えない。特別チェストの札は `br.open_rich` で対象外。mark_open は `br.open_new` を付けて召喚直後に書き換える）。chest_tick の CustomName の書き換えはやめ、残った名前は br/finish と chest_initial で消す。災害のアクションバー（k1/hit・k2/hit・k4/zone・k5/shake）からダメージ量を外した。
- 1.9.158：1.9.157 は `ach/info` の2行目（`data modify storage oa:ach_info set value {}`、パスなし）が読み込みエラーで、本番の自動更新に巻き戻された（更新スクリプトの1件のエラーでも巻き戻す修正が正しく働いた）。生成スクリプトからその行を外し、`check_release.py` に「data modify のパスなし」の検査を追加。内容は 1.9.157 と同じ。
- 1.9.157：表示の改善。ゆーの名前を「ゆー：オーバーワーク」に。補給の便は「第N便 ★」だけ。「今回のお題」「達成するとごほうびがもらえます。」。開始の案内を3行に。通常チェストの名前（画面の題名）に再補充までの残り時間（br/loot/chest_title → chest_tick が1秒に1回 CustomName を書き換え、br/finish で消す）。実績の解除メッセージに説明のホバー（gen_ach が ach/info を書き出し、ach/give → ach/announce）。固有装備を拾ったお知らせに show_item のホバー（inventory/pick_notice。説明文を付けたあとに読み直す）。災害は3秒前から効果音だけでカウントダウン（disaster/warn）、チャットの説明は効果時間と一言だけ。ロビーの展示の看板は `oa.admin 46` で更新。
- 1.9.156：ネザーのチェストを約1.5倍（68→102：通常58→88、上位10→14）。`scripts/build_map_nether.py` の間引き（thin、1.9.119/1.9.120）をやめ、砦の廃墟の中央の東2マスに通常チェストを1つ追加。生成スクリプトは決定的で、変更前のコードで現行の出力を完全に再現できることを確かめてから変えた（地形の差は「空気→チェスト」34マスだけ）。ネザー会場の再生成が必要。地面の固有武器は序盤（tick 1200〜3600）も50%で追加の抽選（br/loot/ground_event）。
- 1.9.155：開始地点を地表にそろえる。登録は `br/spawn_points/add_find`（切り捨てた高さ→1つ上→1つ下→2つ下の順に `spawn_points/check`）。開始TP後の補正 `br/tp_fix` は、ブロック単位にそろえた高さで地表判定し、埋まっていれば上（tp_fix_up、最大80）、浮いていれば下（tp_fix_down、最大4）。`tp_position` でTP直後にも呼ぶ。「少し下にTPされる」原因はコード上では特定できていない（以前の判定は足と頭のブロックだけで、床の高さを見ていなかった）。
- 1.9.154：`br/spawn_points/add_here` の2行目で `tellraw @s` が抜けていた（1.9.141 で混入、`run return run [{text:…}]`）。関数ごと読み込めず、開始地点の登録が動かなかった。さらに自動更新が読み込みエラーで巻き戻すため、本番は 1.9.150〜1.9.153 が入らず 1.9.149 のままだった（1.9.141〜1.9.149 は `update.ps1` の `$errs[0].Trim()` の不具合で判定が落ち、誤りを含んだまま入っていた）。`tools/check_release.py` に「行頭と `run` の直後が実在するコマンドか」の検査を追加。`update.ps1` は `$errs = @(…)` に修正（サーバー側のコピーは手で差し替える）。補給の樽・鎖の `block_display` は 26.3 の新形式 `{id:…,properties:…}` に（1.9.134 の `{Name:…,Properties:…}` も誤りだった。本番ログの Serialization errors で判明）。
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
- 160個のタイル関数：`tiles/place/N`（ブロック）、`tiles/water/N`（水）、`tiles/apply/N`（チェスト・鉱石登録）、`delete/apply/N`（削除）。`oa:map/rebuild` は place を再実行する。
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
