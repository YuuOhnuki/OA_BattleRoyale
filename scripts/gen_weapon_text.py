"""Generate the same descriptions for tools, chat, menus and reference docs.
Run from any cwd: py -3 scripts/gen_weapon_text.py. Does not change weapon mechanics.
"""
from pathlib import Path
import json,re,sys,copy
sys.dont_write_bytecode=True
sys.path.insert(0,str(Path(__file__).resolve().parent))
from weapon_catalog import WEAPONS,MEDICINE
R=Path(__file__).resolve().parents[1];D=R/'data/oa';P=R.parent/'oa_battleroyale_plugin';RP=R.parent/'oa_battleroyale_resourcepack'
def dump(x):return json.dumps(x,ensure_ascii=False,separators=(',',':'))
def write(p,s):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s,encoding='utf-8')
def jwrite(p,x):write(p,json.dumps(x,ensure_ascii=False,indent=2)+'\n')
def t(s,c='white',**kw):return dict(text=s,color=c,italic=False,**kw)
def rich(s):
 out=[];at=0
 for m in re.finditer(r'(?P<hp>[0-9]+(?:\.[0-9]+)?)HP|満腹度(?P<food>[0-9]+(?:\.[0-9]+)?)ゲージ（内部(?P<points>[0-9]+)ポイント）',s):
  if at<m.start():out.append(t(s[at:m.start()]))
  if m['hp']:
   n=float(m['hp']);out.extend([t('\ue100','red',font='oa:icons'),t(f'×{n/2:g}')])
  else:out.extend([t('\ue101','white',font='oa:icons'),t(f'×{m["food"]}')])
  at=m.end()
 if at<len(s):out.append(t(s[at:]))
 return out or [t(s)]
def row(label,value):return dict(text='',italic=False,extra=[t(label+'：','gray')]+rich(value))
def wrap(component,width=260):
 """Wrap lore without losing label colours or the custom icon font."""
 import unicodedata
 parts=component.get('extra',[component]);out=[];line=[];used=0
 for part in parts:
  style={k:v for k,v in part.items() if k!='text'}
  for ch in part.get('text',''):
   advance=8 if part.get('font')=='oa:icons' else 9 if unicodedata.east_asian_width(ch) in ('W','F','A') else 6
   if used+advance>width:
    out.append(dict(text='',italic=False,extra=line));line=[t('  ')];used=8
   if line and {k:v for k,v in line[-1].items() if k!='text'}==style:line[-1]['text']+=ch
   else:line.append(dict(text=ch,**style))
   used+=advance
 if line:out.append(dict(text='',italic=False,extra=line))
 return out
def title(w):return w['name']+'：'+w['title']
def attack(w,up=False):
 s=''
 if w['hp'] is not None:s=f"{w['hp']:g}HP"+(f"（補充後{w['hp']+1:g}HP）" if w['kind'] in [4,6,8,9,10] else '')+'。'
 if w['speed'] is not None:s+=f"攻撃速度{w['speed']:g}回／秒。"
 return s+w['attack']
def note(w):return '※固有武器と同時に所持可能。' if w.get('consumable') else '※固有武器は一人一個まで所持可能'

def named(w,s=None):
 if w.get('outline'):return t(s or title(w),'white',font='oa:weapon_'+w['id'],bold=False,shadow_color=0)
 return t(s or title(w),w['color'],bold=True)
def fields(w,up=False):
 rows=[('モチーフ',w['motif']),('特徴',w['sentence'])]
 if w['kind'] in [1,3,5]:rows.append(('装備効果',w['equip']))
 else:
  if w['kind'] not in [11,12]:rows.append(('通常攻撃',attack(w,up)))
  rows.append(('発動' if w['kind']==11 else '右クリック',w['right']))
 if w['kind']==4:rows.append(('シフト右クリック',w['shift']))
 rows.append(('CT',w['ct']))
 return rows
def lore(w,up=False,progress=None):
 rows=[row(a,b) for a,b in fields(w,up)]
 if progress is not None:
  stages=[0,1,5,7,10,15];stage=sum(progress>=n for n in stages);nxt=next((n for n in stages if n>progress),None)
  rows.append(row('解放',f"段階{stage}／6・進行度{progress}"+(f'／次は{nxt}' if nxt is not None else'／全解放')))
 rows.append(t(note(w),'gray'))
 return [line for component in rows for line in wrap(component)]
def modifier(w,up=False,progress=None):
 data={'description214':1,'description_up':int(up),'name_v172':1,'name_v204':1}
 if w['kind']==6:data['description238']=1
 if progress is not None:
  data['itori_text214']=progress;data['itori_stage']=sum(progress>=n for n in [0,1,5,7,10,15]);data['itori_lore194']=progress
 tag='{oa:{'+','.join(k+':'+str(v)+('' if k in ['itori_text214','itori_stage','itori_lore194'] else 'b') for k,v in data.items())+'}}'
 return {'type':'minecraft:sequence','functions':[{'type':'minecraft:set_components','components':{'minecraft:custom_name':named(w),'minecraft:lore':lore(w,up,progress),'minecraft:tooltip_display':{'hidden_components':['minecraft:enchantments','minecraft:attribute_modifiers']}}},{'type':'minecraft:set_custom_data','tag':tag}]}
menu={};reference=['# 固有武器・消耗品の説明（1.9.215）','', 'ダメージは補充前を本文に、補充後を括弧内に記載。','', '体力は♥、満腹度は食料アイコンの個数で表示。ダメージは軽減前。','']
for w in WEAPONS:
 kind=w['kind'];key=f'k{kind}' if kind<=10 else 'yu' if kind==11 else 'frosch'
 jwrite(D/f'item_modifier/lore/{key}.json',modifier(w))
 if kind<=10:
  if kind<10:jwrite(D/f'item_modifier/name/k{kind}.json',{'type':'minecraft:sequence','functions':[{'type':'minecraft:set_components','components':{'minecraft:custom_name':named(w)}},{'type':'minecraft:set_custom_data','tag':'{oa:{name_v172:1b,name_v204:1b}}'}]})
  if kind in [4,6,8,9]:jwrite(D/f'item_modifier/lore/k{kind}_plus1.json',modifier(w,True))
  if kind==10:
   for n in range(16):
    jwrite(D/f'item_modifier/lore/k10_progress_{n}.json',modifier(w,False,n))
    jwrite(D/f'item_modifier/lore/k10_progress_{n}_plus1.json',modifier(w,True,n))
 body=[t('\n━━ ','gold'),named(w),t(' ━━\n','gold')]
 for label,value in fields(w)+w['extra']:
  body.extend([row(label,value),t('\n')])
 body += [t(note(w)+'\n','gray')]
 if kind==9:body.append(t('［ガチャ全16結果を見る］','green',underlined=True,click_event={'action':'run_command','command':'/trigger oa.gallery set 10'}))
 write(D/f'function/lobby/gallery/info/{w["info"]}.mcfunction','tellraw @s '+dump(body)+'\n')
 if kind==11:jwrite(D/'item_modifier/lore/yu.json',modifier(w))
 if kind==12:
  # A description modifier must not rewrite consumable components or stack size.
  jwrite(D/'item_modifier/furo_lore182.json',{'type':'minecraft:sequence','functions':[{'type':'minecraft:set_components','components':{'minecraft:custom_name':named(w),'minecraft:lore':lore(w)}},{'type':'minecraft:set_custom_data','tag':'{furo_lore209:1b,furo_lore182:1b}'}]})
  def update_furo(node):
   if isinstance(node,list):
    for n in node:update_furo(n)
   elif isinstance(node,dict):
    c=node.get('components',{})
    if 'minecraft:lore' in c:c['minecraft:lore']=lore(w);c['minecraft:custom_name']=named(w)
    for n in node.values():update_furo(n)
  for old in ['furo_lore181','furo_stack1927']:
   f=D/f'item_modifier/{old}.json';j=json.loads(f.read_text(encoding='utf-8'));update_furo(j);jwrite(f,j)
 if kind==11:
  give='give @s minecraft:totem_of_undying[minecraft:custom_name='+dump(named(w))+',minecraft:custom_data={oa_overwork:1b},minecraft:max_stack_size=1,minecraft:item_model="oa:yu",minecraft:lore='+dump(lore(w))+'] 1'
  f=D/'function/give/overwork.mcfunction';s=f.read_text(encoding='utf-8');s=re.sub(r'^give @s minecraft:totem_of_undying.*$',lambda m:give,s,flags=re.M);write(f,s)
 # Canonical English entry points; legacy functions and all saved kind/serial IDs remain.
 if w['id']!=w['legacy']:write(D/f'function/give/{w["id"]}.mcfunction',f'function oa:give/{w["legacy"]}\n')
 menu[str(kind)]={'id':w['id'],'info':w['info'],'name':title(w),'short':w['name'],'lore':lore(w),'sentence':w['sentence'],'name_component':named(w),'short_component':named(w,w['name']),'color':w['color'],'outline':w['outline']}
 reference+=['## '+title(w),'',w['sentence'],'',f'- コマンドID：`{w["id"]}`',f'- モチーフ：{w["motif"]}',*[f'- {a}：{b}' for a,b in fields(w) if a!='モチーフ']]+[f'- {a}：{b}' for a,b in w['extra']]+['',note(w),'', '**改善案（未実装・性能変更なし）：** '+w['idea'],'']
jwrite(P/'src/main/resources/weapon-descriptions.json',menu)
reference=[re.sub(r'([0-9]+(?:\.[0-9]+)?)HP',lambda m:f'♥×{float(m[1])/2:g}',line) if line.startswith('- ') else line for line in reference]
reference+=['## 通常武器','', '| 武器 | 現在の効果 | 説明の改善案（未実装） |','|---|---|---|','| 木のバット | ♥×2・0.8回／秒、ノックバック | 大振りの押し出し武器として役割を明記 |','| 木のノックバック棒 | ♥×0.5・4回／秒、ノックバックII | ダメージより位置取り用と強調 |','','## 医療品・食品','']
med_lore={};med_components={}
for key,(name,use) in MEDICINE.items():
 lines=[row('効果',use),t('※固有武器と同時に所持可能。','gray')]
 med_lore[key]=lines
 f=D/f'item_modifier/medical/{key}.json';j=json.loads(f.read_text(encoding='utf-8'))
 comp=j['components'] if 'components' in j else j['functions'][0]['components']
 comp['minecraft:custom_name']=t(name,'gold',bold=True);comp['minecraft:lore']=lines
 # Fresh loot and refreshed inventory items must have identical data, including
 # the migration flag. A flag added only after pickup prevents stacking.
 comp['minecraft:custom_data']={k:v for k,v in comp['minecraft:custom_data'].items() if not re.fullmatch(r'medical_text\d+',k)}
 comp['minecraft:custom_data']['medical_text215']=True
 med_components[key]=copy.deepcopy(comp)
 jwrite(f,{'type':'minecraft:sequence','functions':[{'type':'minecraft:set_components','components':comp}]})
 reference += [f'- **{name}**：'+re.sub(r'([0-9]+(?:\.[0-9]+)?)HP',lambda m:f'♥×{float(m[1])/2:g}',use)]
def refresh_loot(node):
 if isinstance(node,list):
  for n in node:refresh_loot(n)
 elif isinstance(node,dict):
  c=node.get('components',{});data=c.get('minecraft:custom_data',{});key={1:'heal1',2:'heal2'}.get(data.get('br_heal_kind')) or data.get('oa_buff')
  if key in MEDICINE:c.update(copy.deepcopy(med_components[key]))
  if data.get('oa_furoball'):
   c['minecraft:custom_name']=named(WEAPONS[-1]);c['minecraft:lore']=lore(WEAPONS[-1])
   # 1.9.211: 持ち物の更新（inventory/text_refresh の furo_lore209）と同じ目印を最初から付ける。付いていないと拾ったあとに書き換わり重ならない
   data['furo_lore182']=True;data['furo_lore209']=True;data['furo_stack1927']=True
  for n in node.values():refresh_loot(n)
BAT_VISUAL=json.loads((D/'item_modifier/bat_visual.json').read_text(encoding='utf-8'))['functions']
def bat_parity(node):
 # 1.9.211: 木のバットは持つと oa:bat_visual で書き換わっていた（目印 oa_bat_v151）。ドロップ表でも最後に同じ modifier を通す
 if isinstance(node,list):
  for n in node:bat_parity(n)
 elif isinstance(node,dict):
  for key in ('modifier','functions'):
   fs=node.get(key)
   if isinstance(fs,list) and any(f.get('type')=='minecraft:set_components' and f.get('components',{}).get('minecraft:custom_data',{}).get('oa_normal')=='bat' for f in fs if isinstance(f,dict)):
    # 26.3 には loot function の minecraft:reference がない（起動しなくなる）。oa:bat_visual の中身をそのまま写す
    fs[:]=[f for f in fs if not (isinstance(f,dict) and f.get('type')=='minecraft:reference')]
    if not any(f.get('type')=='minecraft:set_custom_data' and 'oa_bat_v151' in f.get('tag','') for f in fs):fs.extend(copy.deepcopy(BAT_VISUAL))
  for n in node.values():bat_parity(n)
for f in (D/'loot_table').rglob('*.json'):
 before=f.read_text(encoding='utf-8');j=json.loads(before);refresh_loot(j);bat_parity(j)
 if json.loads(before)!=j:jwrite(f,j)
reference=[re.sub(r'満腹度([0-9.]+)ゲージ',r'満腹度アイコン×\1',re.sub(r'（内部[0-9.]+ポイント）','',line)) for line in reference]
write(R/'WEAPONS_JA.md','\n'.join(reference)+'\n')
write(R/'docs/weapon-description-review.md','\n'.join(reference)+'\n')
# One versioned slot updater upgrades old items without discarding unrelated custom data.
lines=[]
for w in WEAPONS[:9]:
 k=w['kind'];base=f'$execute if items entity @s $(slot) *[minecraft:custom_data~{{oa:{{kind:{k}}}}}]'
 version='description238' if k==6 else 'description214'
 if k in [4,6,8,9]:
  for up in [0,1]:
   cond=('if' if up else 'unless')+' items entity @s $(slot) *[minecraft:custom_data~{oa:{damage194_up:1b}}]'
   lines.append(base+' '+cond+f' unless items entity @s $(slot) *[minecraft:custom_data~{{oa:{{{version}:1b,description_up:{up}b}}}}] run item modify entity @s $(slot) oa:lore/k{k}'+('_plus1' if up else ''))
 else:lines.append(base+f' unless items entity @s $(slot) *[minecraft:custom_data~{{oa:{{description214:1b}}}}] run item modify entity @s $(slot) oa:lore/k{k}')
lines.append('$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:10}}] run function oa:itori/item_stage {slot:"$(slot)"}')
write(D/'function/inventory/lore.mcfunction','\n'.join(lines)+'\n')
lines=[]
for up in [0,1]:
 cond=('if score #state br.state matches 1 if score #time br.time matches 7200.. if entity @s[tag=br.alive,tag=!oa.practice]' if up else '')
 # Explicit flag computed by the same condition as normal_damage, even for a head/offhand slot.
 if up==0:lines+=['scoreboard players set #itori_text_up oa.tmp 0','execute if entity @s[tag=br.alive,tag=!oa.practice] if score #state br.state matches 1 if score #time br.time matches 7200.. run scoreboard players set #itori_text_up oa.tmp 1']
 lines.append(f'$execute if score #itori_text_up oa.tmp matches {up} unless items entity @s $(slot) *[minecraft:custom_data~{{oa:{{description214:1b,itori_text214:$(points),description_up:{up}b}}}}] run item modify entity @s $(slot) oa:lore/k10_progress_$(points)'+('_plus1' if up else ''))
write(D/'function/itori/item_progress.mcfunction','\n'.join(lines)+'\n')
# Update held items as soon as the actual refill modifier changes.
f=D/'function/inventory/refill_damage.mcfunction';s=f.read_text(encoding='utf-8')
if 'description214' not in s:s+='\n# description214: base damage followed by refill damage in parentheses.\nfunction oa:inventory/lore {slot:"weapon.mainhand"}\n'
write(f,s)
# Current gacha list is derived from the same result announcements used by gameplay.
names=['health_all','fire_all','revive_all','hat_all','tnt_all','rush_all','chaos_all','gather','mood_all','combo_all','giant_all','critical','exposed','jackpot','oni_all','blast']
out=[t('━━ たやゆゆ：ガチャ全16結果 ━━\n','gold',bold=True),t('時限爆弾3%、大爆発2%、大当たり0.5%、復活・災害コンボ各4%、ほか各約7.864%。CT45秒。\n','white')]
for i,name in enumerate(names,1):
 src=(D/f'function/tayayuyu/{name}.mcfunction').read_text(encoding='utf-8');matches=[]
 for line in src.splitlines():
  if not line.startswith('tellraw '):continue
  matches.extend(re.findall(r'(?:"text"\s*:\s*|\btext\s*:\s*)"((?:[^"\\]|\\.)*)"',line))
  if len(matches)>=2:break
 if matches:
  label=matches[0].split('：')[-1];value=matches[1].lstrip(' →') if len(matches)>1 else '結果は発動時に表示。'
  if name=='jackpot':value='使用者以外の生存者を倒す。最後の1人になれば即座に優勝。'
  if name=='fire_all':value='生存者全員：10秒間、毎秒2HPの炎ダメージ・発光10秒'   # 1.9.229：アナウンスの♥がアイコンの別要素のため、ここで書く（rich が 2HP を♥×1 のアイコンにする）
  out += [row(label+'（'+({15:'3%',16:'2%',14:'0.5%',3:'4%',10:'4%'}.get(i,'約7.864%'))+'）',value),t('\n')]
write(D/'function/lobby/gallery/gacha_results.mcfunction','tellraw @s '+dump(out)+'\n')
# UI icons are original 8px pixel art, with no external image dependency.
from PIL import Image
im=Image.new('RGBA',(16,8));pix=im.load()
heart=['.##.##..','#######.','#######.','.#####..','..###...','...#....','........','........']
food=['...###..','..#####.','..#####.','...###..','..##....','.##.....','##......','.#......']
for offset,pattern,col in [(0,heart,(255,255,255,255)),(8,food,(229,162,78,255))]:
 for y,row_ in enumerate(pattern):
  for x,ch in enumerate(row_):
   if ch=='#':pix[x+offset,y]=col
path=RP/'assets/oa/textures/font/status_icons.png';path.parent.mkdir(parents=True,exist_ok=True);im.save(path)
jwrite(RP/'assets/oa/font/icons.json',{'providers':[{'type':'bitmap','file':'oa:font/status_icons.png','ascent':7,'height':8,'chars':['\ue100\ue101']}]})
from gen_weapon_presentation import generate
generate(WEAPONS,named,R,RP)
print('Generated unified weapon descriptions, colours, outlined fonts, progression/refill variants and status icons.')
