from pathlib import Path
import json,shutil,re,zipfile
from PIL import Image
p=Path('revision/pack'); out=Path('release_1_6_1'); out.mkdir(exist_ok=True)
r=out/'resourcepack'; shutil.copytree('release_1_6/resourcepack',r,dirs_exist_ok=True)
def write(path,s):
 path.parent.mkdir(parents=True,exist_ok=True);path.write_text(s,encoding='utf8')
m=p/'data/oa/item_modifier/visual/k5.json';j=json.loads(m.read_text());j['functions'][0]['item']='minecraft:leather_helmet'
c=j['functions'][1]['components'];c.pop('minecraft:profile',None);c['minecraft:equippable']['asset_id']='oa:killing_mask'
j['functions'].insert(2,{'type':'minecraft:set_attributes','replace':True,'modifiers':[{'id':'oa:unique_speed','attribute':'minecraft:attack_speed','amount':-2.2,'operation':'add_value','slot':'mainhand'}]})
j['functions'][-1]['tag']='{oa:{visual_v140:1b,mask_v161:1b,speed_v160:1b}}';write(m,json.dumps(j,indent=2))
for f in [p/'data/oa/function/curse/tick.mcfunction',p/'data/oa/function/inventory/visual.mcfunction']:
 lines=f.read_text().splitlines();write(f,'\n'.join(l.replace('head_v130','mask_v161') if 'oa:visual/k5' in l else l for l in lines)+'\n')
s=Image.open(r/'assets/oa/textures/skin/f_kirisan_1110.png').convert('RGBA');tex=Image.new('RGBA',(64,32));tex.paste(s.crop((0,0,32,16)),(0,0));tex.alpha_composite(s.crop((32,0,64,16)),(0,0));target=r/'assets/oa/textures/entity/equipment/humanoid/killing_mask.png';target.parent.mkdir(parents=True,exist_ok=True);tex.save(target)
write(r/'assets/oa/equipment/killing_mask.json',json.dumps({'layers':{'humanoid':[{'texture':'oa:killing_mask'}]}}))
f=p/'data/oa/function/load.mcfunction';write(f,f.read_text()+'\nscoreboard objectives add oa.tpush dummy\n')
f=p/'data/oa/function/tick.mcfunction';write(f,f.read_text()+'\nexecute as @a[scores={oa.tpush=1..}] at @s run function oa:throwable/push/tick\n')
f=p/'data/oa/function/internal/cleanup.mcfunction';write(f,f.read_text()+'\nscoreboard players set @s oa.tpush 0\n')
f=p/'data/oa/function/throwable/observe/hit.mcfunction';write(f,f.read_text()+'\nfunction oa:throwable/push/start\n')
b=p/'data/oa/function/throwable/push'
write(b/'start.mcfunction','''# Independent of Yuttari displacement; fixed bounded zero-damage push.
scoreboard players set #px oa.tmp 0
scoreboard players set #pz oa.tmp 0
execute if score #mx oa.tmp matches 1.. run scoreboard players set #px oa.tmp 7
execute if score #mx oa.tmp matches ..-1 run scoreboard players set #px oa.tmp -7
execute if score #mz oa.tmp matches 1.. run scoreboard players set #pz oa.tmp 7
execute if score #mz oa.tmp matches ..-1 run scoreboard players set #pz oa.tmp -7
execute if score #px oa.tmp matches 0 if score #pz oa.tmp matches 0 run return 0
execute store result storage oa:throw_push x double 0.01 run scoreboard players get #px oa.tmp
execute store result storage oa:throw_push z double 0.01 run scoreboard players get #pz oa.tmp
execute store result storage oa:throw_push id int 1 run scoreboard players get @s oa.id
function oa:throwable/push/save with storage oa:throw_push
scoreboard players set @s oa.tpush 3
''')
write(b/'save.mcfunction','$data modify storage oa:players p$(id).throw_push set from storage oa:throw_push\n')
write(b/'load.mcfunction','$data modify storage oa:throw_push set from storage oa:players p$(id).throw_push\n')
write(b/'tick.mcfunction','''execute unless entity @s[tag=br.alive,gamemode=!spectator,tag=!oa.decoy,tag=!br.pvp_grace] run return run scoreboard players set @s oa.tpush 0
execute if data entity @s RootVehicle run return run scoreboard players set @s oa.tpush 0
execute if score #state br.state matches 0 run return run scoreboard players set @s oa.tpush 0
execute store result storage oa:throw_push id int 1 run scoreboard players get @s oa.id
function oa:throwable/push/load with storage oa:throw_push
function oa:throwable/push/step with storage oa:throw_push
scoreboard players remove @s oa.tpush 1
''')
write(b/'step.mcfunction','$execute positioned ~$(x) ~ ~$(z) run function oa:throwable/push/probe\n')
probe=['execute unless loaded ~ ~ ~ run return 0']
for x in [-.3,.3]:
 for z in [-.3,.3]:
  for y in [.05,.9,1.75]: probe.append(f'execute unless block ~{x} ~{y} ~{z} #oa:push_passable run return 0')
probe+=['tp @s ~ ~ ~'];write(b/'probe.mcfunction','\n'.join(probe)+'\n')
# Existing docs are updated in place.
for root in [p,r]:
 for f in root.rglob('*'):
  if f.is_file() and f.suffix in ['.mcfunction','.json','.md','.mcmeta']:
   t=f.read_text();u=t.replace('1.6.0','1.6.1');
   if u!=t:write(f,u)
f=p/'WEAPONS_JA.md';t=f.read_text();t=re.sub(r'- 雪玉：.*', '- 雪玉・卵：プレイヤーへのダメージ0。命中補助検知時に3tickで最大約0.30ブロック水平に押し出します（壁判定付きの短距離TPによる代替で、ネイティブ速度ではありません）。雪玉は鈍足II3秒と冷気、卵は命中粒子。',t);write(f,t)
f=p/'README_JA.md';t=f.read_text();t=re.sub(r'雪玉・卵そのものの移動.*', '雪玉・卵の弾の移動・衝突・消滅はバニラです。補助命中推定時はダメージ0、3tick合計最大約0.30ブロックの水平押し出し（壁判定付き短距離TP）を付与します。完全なネイティブ命中イベント／速度ノックバックではなく、壁際・同時移動・至近距離の命中は実機確認が必要です。',t);t=re.sub(r'26.3のプレイヤーは雪玉.*','26.3の通常の雪玉・卵には対プレイヤーのノックバックがないため、控えめな押し出しで補っています。server.propertiesは未提供で実値は確認できません。pvp=trueを確認してください。',t);t+='\nキリングのお面の装着表示には専用防具テクスチャを使用します。最新の完全版リソースパックが必須です。既存マスクも所持・装着時に自動変換します。スキンの再取得に依存しません。検証は静的ファイル検証のみで、サーバー起動・プレイヤー・複数人テストは行っていません。\n';write(f,t)
# Static validation.
for root in [p,r]:
 for f in root.rglob('*.json'):json.loads(f.read_text())
 for f in root.rglob('*.mcmeta'):json.loads(f.read_text())
for f in (p/'data').rglob('*.mcfunction'):
 for l in f.read_text().splitlines():
  if '$(' in l and not l.startswith('#'):assert l.startswith('$'),(f,l)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),m[1]
for name,root in [('OA_BattleRoyale_v1.6.1.zip',p),('OA_BattleRoyale_Resources_v1.6.1.zip',r)]:
 with zipfile.ZipFile(out/name,'w',zipfile.ZIP_DEFLATED) as z:
  for f in sorted(root.rglob('*')):
   if f.is_file():z.write(f,f.relative_to(root))
 with zipfile.ZipFile(out/name) as z:assert z.testzip() is None
print('JSON, macro prefixes, direct references, ZIP CRC: PASS')
