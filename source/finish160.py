from pathlib import Path
from PIL import Image
import json,shutil,zipfile,re,math,hashlib
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';F=P/'data/oa/function';O=R/'release_1_6';RP=O/'resourcepack'
p=F/'internal/active_changed.mcfunction';s=p.read_text().replace('oa.fish146','oa.fish160').replace('oa:fish 2.375','oa:fish 1.7');s+='\nattribute @s minecraft:max_health modifier remove oa:lazi_health\ntag @s remove oa.lazi_hp\n';p.write_text(s)
# Also expose an optional supplemental-hit counter for testing, never claim it is a native event.
with (F/'load.mcfunction').open('a') as f:f.write('\nscoreboard objectives add oa.throw_hits dummy\n')
with (F/'throwable/observe/hit.mcfunction').open('a') as f:f.write('\nscoreboard players add @s oa.throw_hits 1\n')
with (F/'admin/projectile_check.mcfunction').open('a') as f:f.write('scoreboard players add @s oa.throw_hits 0\ntellraw @s [{text:"自分への補助命中判定回数：",color:"aqua"},{score:{name:"@s",objective:"oa.throw_hits"}}]\n')
# Merge generated map while preserving user-facing named status.
status=(P/'data/oa_map2/function/status.mcfunction').read_text()
for n in ['oa_map','oa_map2']:shutil.copytree(R/f'map300_project/pack/data/{n}',P/f'data/{n}',dirs_exist_ok=True)
(P/'data/oa_map2/function/status.mcfunction').write_text(status)
shutil.copytree(R/'map300_project/pack/source',P/'source/map_generator',dirs_exist_ok=True)
# Readme updates describe the current build, not an appended changelog.
p=P/'README_JA.md';s=p.read_text();s=s.replace('試合中の登録鉱石のみ対象です。','試合中の登録鉱石のみ対象です。')
s=s.replace('サーバーで `/reload`','添付Jump Padの機能は本体へ統合済みです。同じjumppad名前空間の単独ジャンプパッドZIPは重複させず外してください。\nサーバーで `/reload`')
s=s.replace('道路の埋め込み照明、岩・壁の遮蔽物があります。','道路の埋め込み照明、岩・壁の遮蔽物、ジャンプパッド6か所があります。石の感圧板＋レンガが目印で、試合の生存参加者が踏むと添付版の物理キャリア方式で発射します。ジャンプパッドを反映するにはマップを全面再生成します。生成範囲の既存建築は上書きするためバックアップしてください。')
s=s.replace('武器の説明とCTはアイテム説明欄を確認。','主手に持つ固有装備の攻撃速度は1.8回/秒。頭へ装着しているときに別の通常武器の攻撃速度を変える効果ではありません。ゆー・通常バット・ノックバック棒にはこの指定を適用しません。\n武器の説明とCTはアイテム説明欄を確認。')
s=s.replace('自動スポーン','自動スポーン')
s+='\n## 地面出現と飛び道具の確認\n固有装備・ゆーのランダムな地面出現では、自然地形の床と頭上の空きを検査し、葉・木材屋根・銅屋根・レンガ屋根等の場所を却下します。条件不適合の回は出現しないため、実出現数は地形・読み込み状況で変わります。管理者が直接アイテムを落とす操作まで移動・削除するものではありません。\n管理ブックの飛び道具チェック、または /trigger oa.admin set 34 で保護期間・生存参加状態・読み込み中の雪玉と卵・補助命中回数を確認できます。追加効果のテストは試合中、開始保護終了後に敵同士で行ってください。\n26.3のプレイヤーは雪玉・卵による0ダメージを通常の被ダメージとして処理しないため、標準の対プレイヤーノックバックがありません。これをサーバー設定で消されたと断定できません。server.propertiesは未提供なので実値は未確認です。PvP全体を許可するにはpvp=trueであることをサーバー管理者が確認してください。本体側ではnativeの弾を手動でTP・消去せず、雪玉の鈍足／卵の粒子だけを従来の補助推定で付与します。意図的な対プレイヤー追加ノックバックや追加ダメージは実装していません。\n'
p.write_text(s)
p=P/'WEAPONS_JA.md';s=p.read_text().replace('3.375倍','2.7倍').replace('大音量。2秒ごと','大音量・装着中最大HP＋6（ハート3個）。2秒ごと');s=s.replace('CTは共有スコアで管理し','主手で持つ固有装備の攻撃速度は1.8回/秒です（ゆー除外）。CTは共有スコアで管理し');p.write_text(s)
p=RP/'README_JA.md';s=p.read_text().replace('全固有装備・通常バット','ぴちぴちは添付の透明背景の魚画像をそのまま使用しています。\n全固有装備・通常バット');p.write_text(s)
for base in [P,RP]:
 for p in base.rglob('*'):
  if p.is_file() and p.suffix in ['.json','.mcmeta','.mcfunction','.md']:
   try:s=p.read_text()
   except UnicodeError:continue
   s=s.replace('1.5.2','1.6.0').replace('1.5.0','1.6.0');p.write_text(s)
v=json.loads((P/'VALIDATION.json').read_text());v.update({'version':'1.6.0','jump_pads':6,'imported_jump_pack':'user supplied Jump_Pad_26.3_fixed(1).zip','unique_attack_speed':1.8,'lazi_extra_max_hp':6,'fish_speed_total_multiplier':2.7,'fish_texture':'exact supplied PNG bytes','ground_spawn':'natural surface whitelist plus 2 air blocks; rejected attempts omitted','server_properties':'not supplied; pvp actual value unknown'});(P/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
for n in ['build160_map.py','build160_runtime.py','finish160.py']:shutil.copyfile(R/n,P/'source'/n)
shutil.copyfile(R/'map300_project/output/OA_BR_Map_Overview.png',O/'OA_BR_Map_Overview.png')
# Verify all directly referenced functions, including the integrated jump-pad namespace.
for p in P.rglob('*.json'):json.loads(p.read_text())
for p in P.rglob('*.mcfunction'):
 for l in p.read_text().splitlines():
  if '$(' in l:assert l.startswith('$'),(p,l)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,k=m[1].split(':',1);assert (P/f'data/{ns}/function/{k}.mcfunction').exists(),(p,m[1])
assert math.isclose(4-2.2,1.8) and math.isclose((1+2.375)*.8,1+1.7)
assert (R/'upload/image(3).png').read_bytes()==(RP/'assets/oa/textures/item/pichipichi_fish.png').read_bytes()
manifest=json.loads((P/'source/map_generator/../map_generator/../../../../map300_project/pack/MAP_MANIFEST.json').read_text()) if False else json.loads((R/'map300_project/pack/MAP_MANIFEST.json').read_text());assert len(manifest['jump_pads'])==6
for name in ['load','tick']:
 assert 'jumppad:'+name in json.loads((P/f'data/minecraft/tags/function/{name}.json').read_text())['values']
for base,name in [(P,'OA_BattleRoyale_v1.6.0.zip'),(RP,'OA_BattleRoyale_Resources_v1.6.0.zip')]:
 with zipfile.ZipFile(O/name,'w',zipfile.ZIP_DEFLATED) as z:
  for p in base.rglob('*'):
   if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(base))
 with zipfile.ZipFile(O/name) as z:assert z.testzip() is None
 print(name,(O/name).stat().st_size)
print('PASS JSON, direct refs/macros, integrated jump-pad tags, 6pad metadata, speed arithmetic, exact fish texture bytes, ZIPCRC. No server run.')
