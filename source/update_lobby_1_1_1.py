from pathlib import Path
import json,re,shutil,zipfile,math
from PIL import Image
R=Path('/workspace/scratch/221a7bbb4169'); O=R/'release_1_1_1';P=R/'revision/pack';L=P/'data/oa/function/lobby'
s=(L/'build.mcfunction').read_text();s=s[:s.index('fill ~-12 ~0 ~-12 ~-12 ~0 ~-12')]
s='\n'.join(l for l in s.splitlines() if not (l.startswith('fill ') and 'minecraft:water' in l))+'\n';s=s.replace('展示回廊・庭園・上空アスレチック','展示回廊・ミニアスレ・BRマップ案内')
cmd=[]
def fill(x,y,z,a,b,c,v):cmd.append(f'fill ~{x} ~{y} ~{z} ~{a} ~{b} ~{c} minecraft:{v}')
def label(x,y,z,text,color='aqua'):
 n={'Tags':['oa.lobby_label'],'text':{'text':text,'color':color},'billboard':'center','background':1073741824,'shadow':True,'line_width':260,'view_range':1.5}
 cmd.append(f'summon minecraft:text_display ~{x} ~{y} ~{z} '+json.dumps(n,ensure_ascii=False,separators=(',',':')))
# Remove both pool lips and replace the pool beds with patterned dry paving.
for x in [-10,10]:
 fill(x-3,0,25,x+3,0,31,'air');fill(x-3,-1,25,x+3,-1,31,'smooth_quartz')
# Four short repeatable rise-and-fall courses, kept off the team/start pads.
manifest=[]
for k,(z,wood) in enumerate([(-24,'oak'),(-18,'spruce'),(18,'birch'),(24,'cherry')],1):
 steps=[]
 for x,ht in zip([-6,-3,0,3,6],[.5,1,2,1,.5]):
  block=wood+'_slab[type=bottom,waterlogged=false]' if ht==.5 else wood+'_planks'
  fill(x,0,z-1,x,0 if ht<2 else 1,z+1,block);steps.append([x,ht,z])
 fill(-9,-1,z-1,-8,-1,z+1,'sea_lantern')
 label(-10,1.5,z,f'ミニアスレ {k}\n低→高→低／何度でもジャンプ')
 manifest.append({'lane':k,'steps':steps,'center_spacing':3})
# Static overview board. No map item IDs or world save edits are necessary.
fill(-7,1,36,7,15,36,'polished_blackstone_bricks');fill(-6,2,35,6,14,35,'smooth_quartz')
n={'Tags':['oa.lobby_exhibit','oa.lobby_map'],'item':{'id':'minecraft:paper','count':1,'components':{'minecraft:item_model':'oa:br_map'}},'item_display':'fixed','billboard':'fixed','transformation':{'translation':[0.0,0.0,0.0],'left_rotation':[0.0,0.0,0.0,1.0],'scale':[12.0,12.0,1.0],'right_rotation':[0.0,0.0,0.0,1.0]},'view_range':2.0,'brightness':{'block':15,'sky':15}}
cmd.append('summon minecraft:item_display ~0.5 ~8.5 ~34.8 '+json.dumps(n,separators=(',',':')))
label(0.5,16.2,34,'BR MAP｜北：山岳・雪／東：森\n西：市街地／南：海・港','gold')
label(0.5,1.2,33,'305×305 俯瞰図\n現行マップ生成データの固定展示／リソースパック必須','white')
(L/'build.mcfunction').write_text(s+'\n'.join(cmd)+'\n')
# Remove obsolete sky-goal trigger and function: no reward/teleport on new courses.
p=L/'tick.mcfunction';p.write_text('\n'.join(l for l in p.read_text().splitlines() if 'oa.lobby_goal' not in l)+'\n')
(L/'goal.mcfunction').unlink(missing_ok=True)
(L/'upgrade.mcfunction').write_text('execute unless data storage oa:lobby origin{ready:1b} run return run tellraw @s {text:"ロビー未登録です。oa:lobby/createで作成してください。",color:"red"}\nexecute unless score #state br.state matches 0 run return run tellraw @s {text:"試合停止中に実行してください。",color:"red"}\nfunction oa:lobby/rebuild_registered with storage oa:lobby origin\ntellraw @s {text:"ロビーを更新しました。旧アスレ・装飾池を撤去しました。",color:"green"}\n')
(L/'rebuild_registered.mcfunction').write_text('$execute in minecraft:overworld positioned $(x) $(y) $(z) align xyz run function oa:lobby/build\n')
# Merge overview asset into the full existing resource pack.
RP=O/'resourcepack';shutil.copytree(R/'release_1_0/resourcepack',RP,dirs_exist_ok=True)
im=Image.open(R/'release_1_1/OA_BR_Map_Overview.png').crop((28,90,1078,1140)).resize((512,512),Image.Resampling.LANCZOS).convert('RGBA')
tex=RP/'assets/oa/textures/item/br_map.png';im.save(tex)
model={'parent':'minecraft:item/generated','textures':{'layer0':'oa:item/br_map'},'gui_light':'front','display':{'fixed':{'rotation':[0,0,0],'translation':[0,0,0],'scale':[1,1,1]}}}
(RP/'assets/oa/models/item/br_map.json').write_text(json.dumps(model,indent=2))
(RP/'assets/oa/items/br_map.json').write_text(json.dumps({'model':{'type':'minecraft:model','model':'oa:item/br_map'}},indent=2))
p=RP/'assets/minecraft/atlases/items.json';a=json.loads(p.read_text());a['sources'].append({'type':'minecraft:single','resource':'oa:item/br_map','sprite':'oa:item/br_map'});p.write_text(json.dumps(a,indent=2))
p=RP/'pack.mcmeta';a=json.loads(p.read_text());a['pack']['description']='OA Visuals 完全版 1.1.1 / BRロビー案内図 / Java26.3';p.write_text(json.dumps(a,ensure_ascii=False,indent=2))
with (RP/'README_JA.md').open('a') as f:f.write('\n1.1.1：ロビー用BR俯瞰図モデルoa:br_mapを追加。全既存モデルを含む完全版。ロビーの案内図は固定画像で、プレイヤー位置や建築変更の自動追従はしません。\n')
# Replace obsolete documentation instead of keeping conflicting instructions.
p=P/'README_JA.md';s=p.read_text();a=s.index('アスレチックは北西寄り');b=s.index('指定7人は',a);s=s[:a]+s[b:];s=s.replace('64足場の上空アスレチック','高低差のある短いミニアスレ4本');s=s.replace('1.1.0','1.1.1');s+='''

## 1.1.1 ロビー更新
上空へ続く旧アスレを撤去し、画像を参考に高さ0.5→1→2→1→0.5ブロックの短いコースを4本設置。各足場は幅3・進行方向の奥行1、中心間隔3ブロック。繰り返し遊ぶコースで、自動ジャンプやクリア報酬はありません。チーム選択パッドとは別の位置です。
装飾池と縁を撤去し、床を乾いた舗装へ変更。旧ロビーの水と旧足場を撤去するには、更新した本体とリソースパックを導入し `/reload` 後、ロビーの近くで `/function oa:lobby/upgrade` を実行してください。登録済みロビーの81×81、Y−3〜Y+44を再建するため、範囲内の追加建築は上書きされます。バックアップしてください。試合停止中のみ実行できます。新規作成は従来どおりoa:lobby/create。
南側にBRマップの大型俯瞰図を追加。現行1.1.0の305×305生成データ由来の固定画像です。マップアイテムではなく専用リソースパックの展示用画像なので、プレイヤー位置・後からの建築変更は反映しません。**リソースパックも今回の完全版へ交換してください。** BR地形自体は前版から変更していないため、BRマップの再生成は不要です。
ロビーの短いアスレと図の向き・描画はゲーム内未検証。サーバー起動・実走・複数人テストは行っていません。
''';p.write_text(s)
for p in P.rglob('*'):
 if p.is_file() and p.suffix in ['.mcfunction','.json','.mcmeta']:
  try:s=p.read_text()
  except UnicodeError:continue
  if '1.1.0' in s:p.write_text(s.replace('1.1.0','1.1.1'))
p=P/'VALIDATION.json';v=json.loads(p.read_text());v['parkour_platforms']=20;v['parkour_courses']=4;v['lobby_water_source_blocks']=0;v['map_board']='static overview texture; in-game rendering untested';p.write_text(json.dumps(v,ensure_ascii=False,indent=2))
(O/'COURSE_GEOMETRY.json').write_text(json.dumps(manifest,indent=2))
# Store source and compact validation inside the source pack, not as more README files.
source=P/'source';source.mkdir(exist_ok=True);shutil.copyfile(__file__,source/'update_lobby_1_1_1.py');shutil.copyfile(O/'COURSE_GEOMETRY.json',source/'lobby_courses.json')
for pack,name in [(P,'OA_Weapons_26.3_Prototype.zip'),(RP,'OA_Visuals_26.3_Prototype.zip')]:
 for p in pack.rglob('*.json'):json.loads(p.read_text())
 with zipfile.ZipFile(O/name,'w',zipfile.ZIP_DEFLATED) as z:
  for p in pack.rglob('*'):
   if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(pack))
 with zipfile.ZipFile(O/name) as z:assert z.testzip() is None
print('Built datapack and complete RP; 4 courses, 20 steps, no pool sources, map image512²')
