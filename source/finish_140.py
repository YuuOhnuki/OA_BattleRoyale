from pathlib import Path
from PIL import Image
import json,shutil,re,zipfile,math
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';F=P/'data/oa/function';O=R/'release_1_4';RP=O/'resourcepack'
# Integrate freshly generated terrain into the single main pack.
for n in ['oa_map','oa_map2']:shutil.copytree(R/f'map300_project/pack/data/{n}',P/f'data/{n}',dirs_exist_ok=True)
shutil.copytree(R/'map300_project/pack/source',P/'source/map_generator',dirs_exist_ok=True)
# Upright source orientation, not a chain of flips. OA glyphs are upright in the bitmap.
Image.open(R/'map300_project/output/OA_BR_Map_Overview.png').crop((28,90,1078,1140)).resize((512,512),Image.Resampling.LANCZOS).convert('RGBA').save(RP/'assets/oa/textures/item/br_map.png')
# More local decorative particles; recipients and counts bounded.
p=F/'lobby/ambience.mcfunction';s=p.read_text().replace('0.1 8 normal','0.1 16 normal');s+='''$execute in minecraft:overworld positioned $(x) $(y) $(z) positioned ~0 ~2 ~0 run particle minecraft:cherry_leaves ~ ~ ~ 20 1 20 0.01 5 normal @a[tag=br.lobby_now]
''';p.write_text(s)
# Include running movement in the lobby footstep feedback as well.
p=P/'data/oa/function/load.mcfunction';s=p.read_text()+'\nscoreboard objectives add oa.lfxr dummy\n';p.write_text(s)
p=F/'lobby/social_fx.mcfunction';s=p.read_text();s='execute if score @s oa.r_run > @s oa.lfxr run particle minecraft:end_rod ~ ~0.15 ~ 0.2 0.05 0.2 0.005 2 normal @a[distance=..20]\n'+s+'scoreboard players operation @s oa.lfxr = @s oa.r_run\n';p.write_text(s)
# Don't make an admin-only give action depend on /function knowledge.
p=F/'public/menu.mcfunction';s=p.read_text();s+='''tellraw @s [{text:"[観戦から参加へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.return"}},{text:" [自分の統計]",color:"aqua",click_event:{action:"run_command",command:"/trigger oa.stats"}}]
execute if entity @s[tag=br.admin] run tellraw @s [{text:"[管理メニュー]",color:"gold",click_event:{action:"run_command",command:"/trigger oa.admin"}}]
''';p.write_text(s)
# /refresh_displays only updates board title; rebuilding is required for geometry.
p=F/'lobby/refresh_displays.mcfunction';p.write_text('execute as @e[type=minecraft:text_display,tag=oa.lobby_label] if data entity @s text{text:"BR MAP｜上：南・海／下：北・山岳\\n左：東・森／右：西・市街地"} run data merge entity @s {text:{text:"BR MAP｜北：山岳・雪／東：森\\n西：市街地／南：海・港",color:"gold"}}\n')
# Single current player/admin guide; no append-only release notes.
readme='''# OAバトルロワイヤル 1.4.0

Java Edition 26.3・バニラ用。最大10人、ソロまたは2〜3人の固定チーム。倒されたら観戦、最後の生存者／チームが優勝します。

## 導入
本体OA_BattleRoyale_v1.4.0.zipをワールド/datapacksへ、OA_BattleRoyale_Resources_v1.4.0.zipを各クライアントのresourcepacksへ入れます。本体には305×305のマップ生成とロビー生成も含まれます。旧本体・旧別配布マップ生成パック・旧リソースパックは重複させず交換してください。サーバーで `/reload`、クライアントでリソースパックを有効化します。既存の所持品を導入だけで消去しません。

## 最初の設定と管理メニュー
OPがプレイヤーとして最初に1回だけ `/function oa:admin` を実行します。本人を管理者・開始ホストへ登録し、必要な基本設定を補完します。バニラのデータパックでは独自の /oa コマンドを登録できないため、以後は `/trigger oa.admin` とチャットのクリック式メニューで操作します。ほかのプレイヤーが管理用triggerを実行しても、管理者タグがなければ拒否します。OP付与自体はサーバー管理者が行います。

| 操作 | コマンド |
|---|---|
| 管理メニュー | /trigger oa.admin |
| 準備チェック | /trigger oa.admin set 2 |
| 現在地を基準にマップ新規生成 | /trigger oa.admin set 3 |
| 現在地にロビー作成 | /trigger oa.admin set 4 |
| ソロ／チーム開始 | /trigger oa.admin set 5 ／ set 6 |
| 試合を中止して復元 | /trigger oa.admin set 7 |
| 累計ランキング全消去 | /trigger oa.admin set 8 |
| 木のバット／ノックバック棒を入手 | /trigger oa.admin set 9 ／ set 10 |
| マップ生成停止／再開 | /trigger oa.admin set 11 ／ set 12 |
| 同じ中心でマップ全面再生成 | /trigger oa.admin set 13 |
| 登録済みロビーの再建 | /trigger oa.admin set 14 |
| 自分の統計 | /trigger oa.stats |

triggerは実行後に再び使えるようになります。短時間に連続入力した場合は次のtickまで待ってください。マップ生成・ロビー作成・再建は、説明された範囲の建築を上書きします。先にバックアップしてください。統計消去も取り消せないため、必要ならワールドを保存してください。

## マップとロビーを用意する
1. マップを作る空き地の上端にしたい場所へ移動します（例：X0/Y80/Z0）。管理メニューのマップ生成を選びます。この操作は実行者を観戦モードにします。
2. 生成は基準X/Z−152〜+152、Y−20〜Y。中央地面は基準Y−11、立つ位置はY−10です。基準Yは0〜250。準備チェックで生成完了と登録成功（チェスト48／鉱石108）を確認してください。
3. マップと重ならない別の空き地へ移動し、ロビー作成を選びます。ロビーは81×81、基準Y−3〜Y+44を上書きします。作成Yは−61〜275。
4. `/trigger br.join` で参加登録。観戦者にした本人は `/trigger oa.return` で参加に戻りロビー中央へ移動できます。
5. 準備チェックでBR中心・基本設定・ロビー・マップ処理状態・登録成功件数・参加人数・チーム未選択を確認します。リソースパックの適用は各自の画面で確認してください。

地形や照明の更新を反映するにはマップ全面再生成、ロビーの配置を反映するにはロビー再建が必要です。どちらも既存の同範囲を上書きします。準備チェックの登録件数は自動生成の結果であり、後から手で壊した全チェスト等の存在を完全監査するものではありません。開始コマンドには保存品や人数の追加検査も残しています。
マップは北に山岳・雪、東に密度のある森と遺跡、西に市街地、南に浜・港・船。道路の埋め込み照明、岩・壁の遮蔽物があります。ロビーのBR俯瞰図は8×8ブロック。以前の表示中心から3ブロック下へ移動し、OAの文字を上向きに読める元画像の向きに統一しています。北が上の固定画像で、プレイヤー位置や試合中の変化は反映しません。

## プレイヤーの遊び方
`/trigger oa.menu` で案内、`/trigger br.lobby` でロビー移動。羊毛に乗るとチーム選択、灰色は観戦。観戦時のチャットの「参加へ戻る」をクリックするか `/trigger oa.return` で戻れます。試合中は復帰できません。
ホストが開始パッドに5秒立つと最後の3秒をカウントし開始。管理メニューから直接開始することもできます。開始前の所持品・経験値・ゲームモードを保存し、パン2個と採掘用ツルハシを配布してランダム配置します。
最初の1分はPvP・通常環境ダメージから保護。終了はタイトルと効果音で通知。初期安置は300×300で、2〜3分230、4〜5分160、6〜7分90、9〜10分20、決着しなければ10〜11分2へ縮小します。各収縮の3・2・1秒前にベルを1回ずつ鳴らします。待機の最後10秒は収縮開始タイマー、収縮中は完了タイマーです。最終の連続収縮では既存の完了表示を維持します。
6分でチェストを1回上書き補充。石炭鉱石は食料、レッドストーン鉱石は医療品。登録鉱石は60秒で再生成し、実物の石炭・レッドストーンは出ません。各採掘は別途2%でゆーを追加抽選します。
固有装備は合計1個まで。スキルは右クリック、頭装備は右クリックで装着。武器の説明とCTはアイテム説明欄を確認。アクションバーは固有装備名を優先します。ロケーターバーは完全非表示です。
試合終了後は所持品・経験値・ゲームモードを復元してロビー中央へ移動。試合外ボーダーは最大幅です。再接続時はロビーへ戻り、試合中の離脱は失格扱いです。

## ロビーと展示
短い高低差アスレ4本、庭園、7人のモチーフ展示、ゲーム・アイテム案内があります。展示は無敵設定と耐性・回復で通常攻撃から保護します。HPを有限の対戦対象にはしませんが、管理者の /kill や削除コマンドの対象外にはできません。自由な腕ポーズは再現していません。ゆー・ほちきすはMCID未登録のアイテム展示。
試合参加中ではないロビー内のプレイヤーは落下補正0、耐火・水中呼吸、HP・満腹度自動回復を受けます。PvPは可能。任意の奈落・窒息等を完全無効化する処理ではありません。歩行・走行・攻撃に粒子、チーム変更や開始にも演出があります。

## 累計ランキング
試合中の参加者について与ダメージ・被ダメージ・地上移動距離・ジャンプ・撃破・死亡・勝利数を保存します。待機中は10秒ごとにサイドバーの項目を切り替え、上位15人まで表示します。スコアはワールドに保存され、退出した人の記録も残ります。試合中は試合用スコアボードを優先します。サイドバー表示はワールド共通で、ロビー外の待機プレイヤーにも表示されます。
ダメージ値の単位は0.1HP、移動は歩行＋走行をmへ換算。空中・遊泳・乗り物の移動は含みません。ダメージ・撃破はバニラ統計に依存し、特殊即死処理など全攻撃の戦績を保証するものではありません。勝利数は本データパックの勝者判定から記録します。記録開始は本版導入後です。ランキング消去は管理メニューで実行できます。

## アイテム・テスト・検証
武器の仕様はWEAPONS_JA.md、出現率・バフ消耗品はLOOT_JA.md。文書はこの3つです。バットは `/function oa:give/bat`、棒は `/function oa:give/stick` でも入手できます。バフ6種は `/function oa:give/buffs`。
JSON、関数参照、タイマー・統計の静的検査、マップ全100区画のブロック照合、全チェスト・鉱石・船内への経路検査を実施。サーバー読み込み、実プレイヤー能力、複数人対戦、マップ描画、ランキング動作は未検証です。yuは手持ちのバニラトーテム発動、ゆったりは移動処理による追加押し出し、ぴち被弾ジャンプは短い浮遊効果、チェスト開放は表示による代替です。
'''
(P/'README_JA.md').write_text(readme)
p=P/'WEAPONS_JA.md';s=p.read_text().replace('こまめ','こまめ');s=s.replace('耐性I','耐性I')
# Update the existing Komame section rather than appending release notes.
if 'こまめ' in s:s=s.replace('小さくなり','小さくなり')
s=s.replace('耐性I＋体力増強I','耐性I＋体力増強I＋移動速度上昇I').replace('耐性I・体力増強I','耐性I・体力増強I・移動速度上昇I')
if '移動速度上昇I' not in s:s=s.replace('こまめ | 小豆バー','こまめ | 小豆バー（スキル中10秒：移動速度上昇I）')
p.write_text(s)
# Item lore must describe the added speed buff.
p=P/'data/oa/item_modifier/lore/k8.json'
if p.exists():
 s=p.read_text();s=s.replace('耐性','移動速度上昇・耐性') if '移動速度上昇' not in s else s;p.write_text(s)
for base in [P,RP]:
 for p in base.rglob('*'):
  if p.is_file() and p.suffix in ['.json','.mcmeta','.mcfunction','.md']:
   try:s=p.read_text()
   except UnicodeError:continue
   if '1.3.0' in s:p.write_text(s.replace('1.3.0','1.4.0'))
p=P/'VALIDATION.json';v=json.loads(p.read_text());v.update({'version':'1.4.0','map_tree_count':246,'stats':'native round deltas; runtime not tested','admin_menu':'OP bootstrap once then permission-tag-checked trigger','board_size':[8,8],'board_shift_y':-3,'ability_volume_multiplier':1.2,'komame_speed_seconds':10});p.write_text(json.dumps(v,ensure_ascii=False,indent=2))
for name in ['make_140_map.py','make_140_runtime.py','finish_140.py']:shutil.copyfile(R/name,P/'source'/name)
# Staged overview is optional downloadable actual block data, not a concept image.
shutil.copyfile(R/'map300_project/output/OA_BR_Map_Overview.png',O/'OA_BR_Map_Overview.png')
for base,name in [(P,'OA_BattleRoyale_v1.4.0.zip'),(RP,'OA_BattleRoyale_Resources_v1.4.0.zip')]:
 for p in base.rglob('*.json'):json.loads(p.read_text())
 with zipfile.ZipFile(O/name,'w',zipfile.ZIP_DEFLATED) as z:
  for p in base.rglob('*'):
   if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(base))
 with zipfile.ZipFile(O/name) as z:assert z.testzip() is None
print('Packaged1.4.0')
