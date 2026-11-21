"""Practice pickups derived from the actual BR chest tables; no separate item whitelist.
Regenerates pickup entities, grants, compatibility group grants and the practice book.
"""
from pathlib import Path
import copy,json,re,sys
sys.dont_write_bytecode=True
from book_layout import check_page
R=Path(__file__).resolve().parents[1];D=R/'data/oa';F=D/'function'
dump=lambda x:json.dumps(x,ensure_ascii=False,separators=(',',':'))
def write(path,s):path.parent.mkdir(parents=True,exist_ok=True);path.write_text(s,encoding='utf-8')
def js(path,x):write(path,json.dumps(x,ensure_ascii=False,indent=2)+'\n')
items={};seen=set()
def walk(x):
 if isinstance(x,list):
  for v in x:walk(v)
 elif isinstance(x,dict):
  n=x.get('name','');t=x.get('type')
  if t=='minecraft:loot_table' and isinstance(n,str):table(n)
  if t=='minecraft:item' and (n.endswith(('_sword','_axe','_spear','_helmet','_chestplate','_leggings','_boots')) or n in ['minecraft:bow','minecraft:crossbow','minecraft:shield','minecraft:stick','minecraft:wooden_shovel','minecraft:arrow']):
   c={}
   for mod in x.get('modifier',[]):
    if mod['type']=='minecraft:set_components':c.update(copy.deepcopy(mod['components']))
   if n=='minecraft:wooden_shovel' and c.get('minecraft:custom_data',{}).get('oa_normal')!='bat':return
   key=n+dump(c);items[key]=(n,c)
  for v in x.values():walk(v)
def table(name):
 if name in seen:return
 seen.add(name);p=R/'data'/name.replace(':','/loot_table/');p=p.with_suffix('.json')
 if p.exists():walk(json.loads(p.read_text(encoding='utf-8')))
for n in ['oa:br/chest_basic','oa:br/chest_upgraded','oa:br/chest_site','oa:br/rich_iron']:table(n)
normal=sorted(items.values(),key=lambda e:(e[0].endswith(('_helmet','_chestplate','_leggings','_boots')),e[0],dump(e[1])))
assert len(normal)<=32,len(normal)
assert not any('netherite' in n or n in ['minecraft:diamond_axe','minecraft:trident'] for n,_ in normal)
guard=['execute unless entity @s[tag=oa.practice,gamemode=!spectator] run return 0','execute unless dimension oa:practice run return 0','execute store result score #practice_space oa.tmp run function oa:practice/catalog/has_space','execute if score #practice_space oa.tmp matches 0 run return run tellraw @s {text:"持ち物に空きを1つ作ってから受け取ってください。",color:"yellow"}']
slots=[f'hotbar.{n}' for n in range(9)]+[f'inventory.{n}' for n in range(27)]
write(F/'practice/catalog/has_space.mcfunction','\n'.join(f'execute unless items entity @s {s} * run return 1' for s in slots)+'\nreturn 0\n')
for i,(n,c) in enumerate(normal):
 entry={'type':'minecraft:item','name':n,'modifier':[{'type':'minecraft:set_components','components':c}] if c else []}
 if n=='minecraft:arrow':entry['modifier'].append({'type':'minecraft:set_count','count':64})
 js(D/f'loot_table/practice/catalog_{i}.json',{'type':'minecraft:chest','pools':[{'rolls':1,'entries':[entry]}]})
 write(F/f'practice/catalog/give_{i}.mcfunction','\n'.join(guard+[f'loot give @s loot oa:practice/catalog_{i}','playsound minecraft:entity.item.pickup player @s ~ ~ ~ 0.6 1.2'])+'\n')
# Strip only the old weapon buttons; weather/exit/DPS controls remain usable.
p=F/'practice/build.mcfunction';lines=p.read_text(encoding='utf-8').splitlines()
legacy=R/'source/practice_legacy_buttons209.json'
remove=set();clear=[]
for i,s in enumerate(lines):
 if 'data:{action:"practice/click/weapon_' in s:
  remove.add(i)
  if i and lines[i-1].startswith('setblock ') and 'button[' in lines[i-1]:
   remove.add(i-1);clear.append(' '.join(lines[i-1].split()[:4])+' minecraft:air')
if not legacy.exists():js(legacy,clear)
clear=json.loads(legacy.read_text(encoding='utf-8'))
out=['# Generated practice pickup migration; controls and saved player inventory are preserved.','kill @e[tag=oa.practice_pick]','kill @e[tag=oa.practice_catalog]']+clear
out += [f'kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={{data:{{action:"practice/click/weapon_{i}"}}}}]' for i in range(1,13)]
models={'pichipichi':1,'yuua':2,'yuttari':3,'killing':4,'raji':5,'komame':6,'nero':7,'yu':8,'hotchikisu':9,'tayayuyu':10,'fire_charge':11,'itori':12}
custom=[]
for s in lines:
 if not s.startswith('summon minecraft:item_display ') or 'oa.practice_showcase' not in s:continue
 parts=s.split(' ',5);d=json.loads(parts[5]);item=d['item'];model=item.get('components',{}).get('minecraft:item_model',item['id']).split(':')[-1]
 info=models[model];x,y,z=parts[2:5];custom.append(info)
 out.append(f'summon minecraft:interaction {x} ~1 {z} '+dump({'Tags':['oa.practice_pick',f'oa.practice.pick.weapon.{info}'],'width':1.2,'height':2.0,'response':True}))
assert sorted(custom)==list(range(1,13)),custom
for i,(n,c) in enumerate(normal):
 x=[-30,-26,-22,-18,18,22,26,30][i%8];z=26+4*(i//8)
 out += [f'setblock ~{x} ~1 ~{z} minecraft:chiseled_quartz_block',f'setblock ~{x} ~0 ~{z} minecraft:sea_lantern']
 item={'id':n,'count':1,'components':c}
 out.append(f'summon minecraft:item_display ~{x+.5} ~2.35 ~{z+.5} '+dump({'Tags':['oa.practice_catalog'],'item':item,'item_display':'fixed','billboard':'center','brightness':{'block':15,'sky':15},'transformation':{'scale':[0.65]*3},'view_range':0.6}))
 out.append(f'summon minecraft:interaction ~{x+.5} ~1 ~{z+.5} '+dump({'Tags':['oa.practice_pick',f'oa.practice.pick.normal.{i}'],'width':1.2,'height':2.0,'response':True}))
 name=c.get('minecraft:custom_name',{'translate':'item.'+n.replace(':','.')})
 out.append(f'summon minecraft:text_display ~{x+.5} ~3.15 ~{z+.5} '+dump({'Tags':['oa.practice_catalog'],'text':{'text':'','extra':[name,{'text':'\n右クリックで受け取る','color':'gray'}]},'billboard':'center','line_width':140,'view_range':0.5,'transformation':{'scale':[0.65]*3}}))
out.append('data modify storage oa:practice catalog set value 209')
write(F/'practice/catalog/build.mcfunction','\n'.join(out)+'\n')
write(F/'practice/catalog/update.mcfunction','execute in oa:practice unless loaded 0 64 0 run return 0\nexecute in oa:practice positioned 0 64 0 run function oa:practice/catalog/build\n')
new=[s for i,s in enumerate(lines) if i not in remove]
if 'function oa:practice/catalog/build' not in new:new.append('function oa:practice/catalog/build')
write(p,'\n'.join(new)+'\n')
for i in range(1,13):
 p=F/f'practice/click/weapon_{i}.mcfunction';s=p.read_text(encoding='utf-8');a=s.index('function oa:lobby/gallery/info/')
 if 'catalog/has_space' not in s:s=s[:a]+'\n'.join(guard)+'\n'+s[a:]
 write(p,s)
melee=[f'function oa:practice/catalog/give_{i}' for i,(n,c) in enumerate(normal) if n.endswith(('_sword','_axe','_spear')) or c.get('minecraft:custom_data',{}).get('oa_normal')]
ranged=[f'function oa:practice/catalog/give_{i}' for i,(n,c) in enumerate(normal) if n in ['minecraft:bow','minecraft:crossbow','minecraft:arrow']]
for file,content in [('melee',melee),('ranged',ranged),('shield',[f'function oa:practice/catalog/give_{i}' for i,(n,c) in enumerate(normal) if n=='minecraft:shield'])]:write(F/f'practice/vanilla/{file}.mcfunction','\n'.join(content)+'\n')
# Existing trigger numbers remain, but 211 cannot issue netherite equipment.
p=F/'practice/vanilla/dispatch.mcfunction';s=p.read_text(encoding='utf-8');s=re.sub(r'execute if score @s oa.lobby matches 211 .*','execute if score @s oa.lobby matches 211 run tellraw @s {text:"バトルロワイヤルに出現しない装備は練習できません。展示から選んでください。",color:"yellow"}',s)
if not s.startswith('execute unless entity'):s='execute unless entity @s[tag=oa.practice] run return 0\nexecute unless dimension oa:practice run return 0\n'+s
write(p,s)
p=F/'practice/vanilla/armor.mcfunction';s=p.read_text(encoding='utf-8');body=s[s.index('$item replace'):]
prefix=['execute unless entity @s[tag=oa.practice] run return 0','execute unless dimension oa:practice run return 0','$data modify storage oa:practice_request armor set value "$(m)"','execute unless data storage oa:practice_request {armor:"leather"} unless data storage oa:practice_request {armor:"chainmail"} unless data storage oa:practice_request {armor:"iron"} unless data storage oa:practice_request {armor:"diamond"} run return run tellraw @s {text:"この防具はバトルロワイヤルに出現しません。",color:"yellow"}']
write(p,'\n'.join(prefix)+'\n'+body)
# Small generated book, all pages checked against the actual book limits.
def text(s,color='black'):return {'text':s,'color':color}
def link(s,code):return dict(text(s+'\n','dark_blue'),click_event={'action':'run_command','command':f'/trigger oa.lobby set {code}'},underlined=True)
pages=[]
for title,body in [('練習場の操作',[text('展示の武器を右クリックすると\n持ち物へ直接入ります。\n空きが必要です。\n\n'),link('DPS測定',201),link('模擬戦 ON/OFF',202),link('CTをリセット',207),link('持ち物を消す',208)]),('時間・天候',[link('昼',203),link('夜',204),link('晴れ',206),link('雨',205),link('ロビーへ戻る',1)]),('バトロワの通常装備',[text('バトロワの出現品だけを展示。\n鉄の槍も試せます。\n\n'),link('鉄防具を着る',209),link('ダイヤ防具を着る',210),link('近接武器セット',212),link('弓・クロスボウ・矢',213),link('盾',214),link('防具を脱ぐ',215)])]:
 parts=[dict(text(title+'\n\n','dark_purple'),bold=True)]+body;check_page(parts);pages.append({'raw':{'text':'','extra':parts}})
book={'title':{'raw':'練習場メニュー'},'author':'OA','generation':0,'resolved':True,'pages':pages}
js(D/'item_modifier/practice_book209.json',{'type':'minecraft:set_components','components':{'minecraft:written_book_content':book,'minecraft:custom_name':{'text':'練習場メニュー','color':'aqua','italic':False},'minecraft:custom_data':{'oa_practice_book':True,'practice_book_v209':True}}})
write(F/'practice/catalog/refresh_book.mcfunction','\n'.join(f'execute if items entity @s {slot} *[minecraft:custom_data~{{oa_practice_book:1b}}] unless items entity @s {slot} *[minecraft:custom_data~{{practice_book_v209:1b}}] run item modify entity @s {slot} oa:practice_book209' for slot in slots+['weapon.offhand'])+'\n')
write(F/'practice/book.mcfunction','clear @s *[minecraft:custom_data~{oa_practice_book:1b}]\ngive @s minecraft:written_book[minecraft:written_book_content='+dump(book)+',minecraft:custom_name={text:"練習場メニュー",color:"aqua",italic:false},minecraft:custom_data={oa_practice_book:1b,practice_book_v209:1b},minecraft:max_stack_size=1]\n')
js(R/'work/practice-catalog209.json',{'items':[{'id':n,'components':c} for n,c in normal],'unique_pickups':sorted(custom),'legacy_buttons_removed':len(clear)})
print(f'Practice catalog: {len(normal)} BR normal items, 12 unique weapons, {len(clear)} old buttons removed')
