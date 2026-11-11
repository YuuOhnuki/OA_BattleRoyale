from pathlib import Path
from PIL import Image
import json,shutil,re,zipfile
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';O=R/'release_1_3';RP=O/'resourcepack';shutil.copytree(R/'release_1_2_2/resourcepack',RP,dirs_exist_ok=True)
p=RP/'assets/oa/textures/item/br_map.png';Image.open(p).transpose(Image.Transpose.FLIP_LEFT_RIGHT).save(p)
# The inventory front must remain a face regardless of inherited item rotations.
for name in ['raji','killing']:
 p=RP/f'assets/oa/models/item/{name}.json';v=json.loads(p.read_text())
 for e in v['elements']:
  front=e.get('faces',{}).get('north')
  if front:e['faces']['south']=json.loads(json.dumps(front))
 v['display']['gui']['rotation']=[12,180,0]
 p.write_text(json.dumps(v,indent=2))
# Static profiles retain textures without UUID/name re-resolution, and migrate old items.
for kind in [3,5]:
 p=P/f'data/oa/item_modifier/visual/k{kind}.json';v=json.loads(p.read_text())
 for f in v['functions']:
  c=f.get('components',{})
  if 'minecraft:profile' in c:c['minecraft:profile']={'properties':c['minecraft:profile']['properties']}
  if f['type']=='minecraft:set_custom_data':f['tag']='{oa:{visual_v140:1b,head_v130:1b}}'
 p.write_text(json.dumps(v,ensure_ascii=False,indent=2))
p=P/'data/oa/function/inventory/visual.mcfunction';lines=[]
for l in p.read_text().splitlines():
 if 'oa:visual/k3' in l or 'oa:visual/k5' in l:l=l.replace('visual_v140:1b','head_v130:1b')
 lines.append(l)
p.write_text('\n'.join(lines)+'\n')
# Even already worn heads are repaired once, without changing serial/curse age.
p=P/'data/oa/function/curse/tick.mcfunction';p.write_text('execute unless items entity @s armor.head *[minecraft:custom_data~{oa:{head_v130:1b}}] run item modify entity @s armor.head oa:visual/k5\n'+p.read_text())
# Yuu ground display is separate from the unique-gear age/ownership path.
p=P/'data/oa/function/world_tick.mcfunction';s=p.read_text();s+='''
execute if score #vclock br.tmp matches 0 as @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa_overwork:1b}}}}] at @s run function oa:overwork/ground
''';p.write_text(s)
(P/'data/oa/function/overwork/ground.mcfunction').write_text('execute if data entity @s Item.components."minecraft:custom_name" run data modify entity @s CustomName set from entity @s Item.components."minecraft:custom_name"\ndata merge entity @s {CustomNameVisible:1b}\nexecute if entity @a[distance=..24] run particle minecraft:smoke ~ ~0.4 ~ 0.15 0.2 0.15 0.01 3 normal @a[distance=..24]\nexecute if entity @a[distance=..24] run particle minecraft:wax_on ~ ~0.5 ~ 0.25 0.2 0.25 0 3 normal @a[distance=..24]\n')
p=P/'data/oa/function/br/mining/reward.mcfunction';s=p.read_text();s+='execute store result score #yu_mine br.tmp run random value 1..50\nexecute if score #yu_mine br.tmp matches 1 run function oa:give/internal/overwork\n';p.write_text(s)
# Reserve Yuua's automatic spawn at issuance, including hats sitting in chests.
p=P/'data/oa/function/br/start.mcfunction';s=p.read_text().replace('scoreboard players set #state br.state 1','scoreboard players set #state br.state 1\nscoreboard players set #yuua_issued br.tmp 0\nexecute as @a if items entity @s inventory.* *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players set #yuua_issued br.tmp 1\nexecute as @a if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players set #yuua_issued br.tmp 1\nexecute as @a if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run scoreboard players set #yuua_issued br.tmp 1');p.write_text(s)
p=P/'data/oa/function/br/loot/unique.mcfunction';s=p.read_text();needle='execute store result score #kind br.tmp run random value 1..130';s=s.replace(needle,needle+'\nexecute if score #kind br.tmp matches 1..10 if score #yuua_issued br.tmp matches 1 run execute store result score #kind br.tmp run random value 11..130');p.write_text(s)
p=P/'data/oa/function/give/internal/yuua.mcfunction';s=p.read_text();# Only automatic match generation calls this once; explicit give is guarded as well.
s='execute if score #yuua_issued br.tmp matches 1 run return 0\nscoreboard players set #yuua_issued br.tmp 1\n'+s;p.write_text(s)
# Rename all item-facing instances, preserving IDs and commands.
for p in P.rglob('*'):
 if p.is_file() and p.suffix in ['.json','.mcfunction','.mcmeta','.md']:
  try:s=p.read_text()
  except UnicodeError:continue
  s=s.replace('ほちきす：ホッチキス','ほちきす | ホッチキス').replace('ほちきす：ほちきす','ほちきす | ホッチキス')
  if p.name=='hotchikisu.mcfunction' or (p.parent.name=='lore' and p.stem=='k7'):
   s=s.replace('"text":"ほちきす"','"text":"ほちきす | ホッチキス"').replace('"text": "ほちきす"','"text": "ほちきす | ホッチキス"')
  s=s.replace('1.2.2','1.3.0');p.write_text(s)
# Correct the displayed horizontal directions too.
p=P/'data/oa/function/lobby/build.mcfunction';s=p.read_text().replace('左：西・市街地／右：東・森','左：東・森／右：西・市街地');p.write_text(s)
p=P/'data/oa/function/lobby/refresh_displays.mcfunction';p.write_text('execute as @e[type=minecraft:text_display,tag=oa.lobby_label] if data entity @s text{text:"BR MAP｜上：南・海／下：北・山岳\\n左：西・市街地／右：東・森"} run data merge entity @s {text:{text:"BR MAP｜上：南・海／下：北・山岳\\n左：東・森／右：西・市街地",color:"gold"}}\n')
# Assemble generation namespaces into the same datapack; merge vanilla entry tags.
for name in ['oa_map','oa_map2']:
 shutil.copytree(R/f'map300_project/pack/data/{name}',P/f'data/{name}',dirs_exist_ok=True)
for name in ['load','tick']:
 p=P/f'data/minecraft/tags/function/{name}.json';v=json.loads(p.read_text());m=json.loads((R/f'map300_project/pack/data/minecraft/tags/function/{name}.json').read_text());v['values']=list(dict.fromkeys(v['values']+m['values']));p.write_text(json.dumps(v,indent=2))
# Keep generation source, but do not copy multiple map README files.
shutil.copytree(R/'map300_project/pack/source',P/'source/map_generator',dirs_exist_ok=True)
p=P/'README_JA.md';s=p.read_text().replace('上が南・下が北','上が南・下が北、左が東・右が西');s=s.replace('本体ZIP','OA_BattleRoyale本体ZIP');s+='''\n## マップ生成・配布構成
OA_BattleRoyale本体にはマップ生成も含まれます。古いOA本体ZIPと別配布のOA_BR_Map生成ZIPをdatapacksから外し、このZIP1個へ入れ替えてください。同じ名前空間のパックを重ねて導入しないでください。リソースパックは完全版ZIPを1個だけ使用します。
マップの新規生成は空いた場所で `/function oa_map:start`。実行位置のX/Z−152〜+152、Y−20〜Yを上書きする305×305です。中央地面は指定Y−11。状態はoa_map:status、停止／再開はoa_map:pause／oa_map:resume、再生成はoa_map:rebuild。既存のマップ・ロビーへ今回のゲーム調整を反映するだけなら再生成・ロビー再建は不要です。
ゆーを地面へ落とすと煙と金色の粒子、名前が表示されます。石炭・レッドストーンの登録鉱石の採掘時は、通常報酬に加えて2%でゆーが1個出ます。試合中の登録鉱石のみ対象です。
ゆうあは試合の自動抽選で1試合1個まで。チェスト内の未取得品も出現済みに数え、壊れた後もその試合では追加出現しません。管理者による外部コマンド・既存品の持ち込みや複製まで削除する仕組みではありません。
''';p.write_text(s)
p=P/'LOOT_JA.md';s=p.read_text();s+='\n全登録鉱石の通常報酬とは別に、採掘ごとに2%で「ゆー | オーバーワーク」1個を追加抽選します。ゆうあは自動抽選で試合あたり1個まで。出現済みなら同レア枠をほかの8種類で再抽選します。木のバットと木のノックバック棒は前半・後半とも木の斧と同じ重みです。\n';p.write_text(s)
for p in RP.rglob('*'):
 if p.is_file() and p.suffix in ['.json','.mcmeta','.md']:
  try:s=p.read_text()
  except UnicodeError:continue
  if '1.2.2' in s:p.write_text(s.replace('1.2.2','1.3.0'))
shutil.copyfile(__file__,P/'source/update_130.py')
# Static verification of actual weapon pool membership/weights.
for name in ['chest_basic','chest_upgraded']:
 t=json.loads((P/f'data/oa/loot_table/br/{name}.json').read_text());es=[e for po in t['pools'] for e in po.get('entries',[])];axe=next(e['weight'] for e in es if e.get('name')=='minecraft:wooden_axe')
 for title in ['木のバット','木のノックバック棒']:
  e=next(e for e in es if any(m.get('components',{}).get('minecraft:custom_name',{}).get('text')==title for m in e.get('modifier',[])));assert e['weight']==axe
 print(name,'axe/bat/stick weight',axe)
for base,name in [(P,'OA_BattleRoyale_v1.3.0.zip'),(RP,'OA_BattleRoyale_Resources_v1.3.0.zip')]:
 for p in base.rglob('*.json'):json.loads(p.read_text())
 with zipfile.ZipFile(O/name,'w',zipfile.ZIP_DEFLATED) as z:
  for p in base.rglob('*'):
   if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(base))
 with zipfile.ZipFile(O/name) as z:assert z.testzip() is None
print('Merged map/core; checkedJSON and ZIP')
