from pathlib import Path
import json,zipfile,shutil,re
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';F=P/'data/oa/function';O=R/'release_1_6';RP=O/'resourcepack';shutil.copytree(R/'release_1_5/resourcepack',RP,dirs_exist_ok=True)
def fn(n,s):p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n')
def add(n,s):
 with (F/(n+'.mcfunction')).open('a') as f:f.write('\n'+s.strip()+'\n')
def js(p,v):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
# Merge the user's exact jump-pad implementation, without requiring a second datapack.
with zipfile.ZipFile(R/'upload/Jump_Pad_26.3_fixed(1).zip') as z:
 for n in z.namelist():
  if n.startswith('data/jumppad/') and not n.endswith('/'):
   p=P/n;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(z.read(n))
for which in ['load','tick']:
 p=P/f'data/minecraft/tags/function/{which}.json';v=json.loads(p.read_text());v['values']=list(dict.fromkeys(v['values']+['jumppad:'+which]));js(p,v)
p=P/'data/jumppad/function/load.mcfunction';s=p.read_text().replace('tellraw @a ','tellraw @a[tag=br.admin] ');p.write_text(s)
p=P/'data/jumppad/function/tick.mcfunction';s=p.read_text().replace('@a[tag=!jp_riding,scores={jp_cd=0}]','@a[tag=br.alive,gamemode=!spectator,tag=!jp_riding,scores={jp_cd=0}]');p.write_text(s)
# Remove carrier and only its own immunity at the end; never touch the map itself.
add('br/finish','execute in minecraft:overworld as @e[type=minecraft:armor_stand,tag=jp_vehicle] at @s run function jumppad:land\nexecute as @a[tag=jp_no_fall] run function jumppad:clear_fall_immunity')
# A stable modifier ID sets base4 attack speed to1.8 for held unique items.
speed={'id':'oa:unique_speed','attribute':'minecraft:attack_speed','amount':-2.2,'operation':'add_value','slot':'mainhand'}
js(P/'data/oa/item_modifier/unique_speed.json',{'type':'minecraft:sequence','functions':[{'type':'minecraft:set_attributes','replace':False,'modifiers':[speed]},{'type':'minecraft:set_custom_data','tag':'{oa:{speed_v160:1b}}'}]})
for name in ['melee_iron','melee_fish','melee_staple','melee_komame']:
 p=P/f'data/oa/item_modifier/{name}.json';v=json.loads(p.read_text())
 for f in v['functions']:
  if f.get('type')=='minecraft:set_attributes':f['modifiers']=[m for m in f['modifiers'] if m['id']!='oa:unique_speed']+[speed]
 js(p,v)
add('inventory/visual','$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{unique:1b}}] unless items entity @s $(slot) *[minecraft:custom_data~{oa:{speed_v160:1b}}] run item modify entity @s $(slot) oa:unique_speed')
for name in ['yuua','pichipichi','lazi','nero','killing','yuttari','hotchikisu','komame']:
 p=F/f'give/internal/{name}.mcfunction';s=p.read_text();idx=s.find('tag @e[tag=oa.spawn] remove oa.spawn')
 if idx!=-1:s=s[:idx]+'item modify entity @e[type=minecraft:item,tag=oa.spawn,limit=1] contents oa:unique_speed\n'+s[idx:]
 p.write_text(s)
# Exact+6HP while worn: independent of potion level granularity.
p=F/'lazi/tick.mcfunction';p.write_text('execute unless entity @s[tag=oa.lazi_hp] run attribute @s minecraft:max_health modifier add oa:lazi_health 6 add_value\ntag @s add oa.lazi_hp\n'+p.read_text())
add('internal/cleanup','attribute @s minecraft:max_health modifier remove oa:lazi_health\ntag @s remove oa.lazi_hp\ntag @s remove oa.fish160')
p=F/'fish/speed_upgrade.mcfunction';s=p.read_text().replace('2.375','1.7').replace('oa.fish146','oa.fish160');p.write_text(s)
p=F/'fish/tick.mcfunction';p.write_text(p.read_text().replace('oa.fish146','oa.fish160'))
# Use the supplied transparent sprite unchanged; no generated replacement.
tex=RP/'assets/oa/textures/item/pichipichi_fish.png';shutil.copyfile(R/'upload/image(3).png',tex)
p=RP/'assets/oa/models/item/pichipichi.json';v=json.loads(p.read_text());v['textures']['layer0']='oa:item/pichipichi_fish';js(p,v)
p=RP/'assets/minecraft/atlases/items.json';v=json.loads(p.read_text());v['sources'].append({'type':'minecraft:single','resource':'oa:item/pichipichi_fish','sprite':'oa:item/pichipichi_fish'});js(p,v)
# Reject foliage and every authored roof material after native spreadplayers picks a spot.
js(P/'data/oa/tags/block/ground_spawn_surface.json',{'values':['minecraft:grass_block','minecraft:dirt','minecraft:coarse_dirt','minecraft:rooted_dirt','minecraft:podzol','minecraft:mycelium','minecraft:dirt_path','minecraft:stone','minecraft:deepslate','minecraft:gravel','minecraft:sand','minecraft:red_sand','minecraft:snow_block','minecraft:packed_ice']})
p=F/'br/loot/random_ground.mcfunction';s=p.read_text().replace('at @s run function oa:br/loot/unique','at @s run function oa:br/loot/ground_surface');p.write_text(s)
fn('br/loot/ground_surface','''execute unless loaded ~ ~-1 ~ run return 0
execute unless block ~ ~-1 ~ #oa:ground_spawn_surface run return 0
execute unless block ~ ~ ~ minecraft:air run return 0
execute unless block ~ ~1 ~ minecraft:air run return 0
function oa:br/loot/unique''')
# Diagnostics report only observable server-side state; do not pretend to read server.properties.
fn('admin/projectile_check','''tellraw @s {text:"飛び道具チェック（Java26.3）",color:"gold"}
execute if entity @s[tag=br.pvp_grace] run tellraw @s {text:"開始保護：有効（追加効果を抑止中）",color:"yellow"}
execute unless entity @s[tag=br.pvp_grace] run tellraw @s {text:"開始保護：なし",color:"green"}
execute if entity @s[tag=br.alive] run tellraw @s {text:"参加状態：生存参加者",color:"green"}
execute unless entity @s[tag=br.alive] run tellraw @s {text:"参加状態：生存参加者ではありません（追加効果の対象外）",color:"yellow"}
scoreboard players set #snow_n oa.tmp 0
scoreboard players set #egg_n oa.tmp 0
execute as @e[type=minecraft:snowball] run scoreboard players add #snow_n oa.tmp 1
execute as @e[type=minecraft:egg] run scoreboard players add #egg_n oa.tmp 1
tellraw @s [{text:"読み込み中の雪玉：",color:"aqua"},{score:{name:"#snow_n",objective:"oa.tmp"}},{text:"／卵："},{score:{name:"#egg_n",objective:"oa.tmp"}}]
tellraw @s {text:"26.3標準ではプレイヤーへ雪玉・卵のノックバックはありません。pvp設定値はデータパックから読めません。server.propertiesのpvp=trueを確認してください。",color:"gray"}''')
add('admin/dispatch','execute if score @s oa.admin matches 34 run function oa:admin/projectile_check')
p=F/'admin/book.mcfunction';s=p.read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');b=s.index(',minecraft:custom_name=',a);v=json.loads(s[a:b]);v['pages'].append({'raw':{'text':'飛び道具の確認\n\n','extra':[{'text':'[状態チェック]\n\n','color':'dark_blue','underlined':True,'click_event':{'action':'run_command','command':'/trigger oa.admin set 34'}},{'text':'保護終了後、敵同士で試してください。\n\n26.3では雪玉・卵の標準ノックバックはありません。','color':'black'}]}});s=s[:a]+json.dumps(v,ensure_ascii=False,separators=(',',':'))+s[b:];p.write_text(s.replace('book_v152','book_v160'))
# Update lore and its migration marker.
p=P/'data/oa/item_modifier/lore/k3.json';v=json.loads(p.read_text())
for f in v.get('functions',[]):
 for row in f.get('components',{}).get('minecraft:lore',[]):
  if '右クリック' in row.get('text',''):row['text']=row['text']+'／装着中HP+6'
 if f.get('type')=='minecraft:set_custom_data':f['tag']=f['tag'].replace('lore_release1','lore_v160')
js(p,v)
p=F/'inventory/lore.mcfunction';lines=p.read_text().splitlines();p.write_text('\n'.join(l.replace('lore_release1','lore_v160') if 'oa:lore/k3' in l else l for l in lines)+'\n')
print('Runtime and resource changes ready')
