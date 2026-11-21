"""Name colours shared by every entry point (outlined fonts kept for compatibility).
Bitmap source: Noto Sans CJK JP Regular (SIL OFL 1.1, licence in resourcepack).
No gameplay or saved IDs are changed.
"""
import json,re,math
from PIL import Image,ImageFont,ImageDraw

def generate(weapons,named,repo,rp):
 dump=lambda x:json.dumps(x,ensure_ascii=False,separators=(',',':'))
 d=repo/'data/oa/function'
 for w in weapons:
  if not w['outline']:continue
  chars=sorted(set(w['name']+'：'+w['title']))
  rows=[''.join(chars[n:n+16]).ljust(16,'\0') for n in range(0,len(chars),16)]
  atlas=Image.new('RGBA',(16*32,len(rows)*32))
  font=ImageFont.truetype(str(rp/'source/weapon_fonts/NotoSansCJKjp-Regular.otf'),26)
  draw=ImageDraw.Draw(atlas);top=2-font.getbbox('昭')[1]
  for i,ch in enumerate(chars):
   box=font.getbbox(ch)
   draw.text((i%16*32+2-box[0],i//16*32+top),ch,font=font,fill=w['color'],stroke_width=2,stroke_fill='white')
  file='weapon_'+w['id']
  atlas.save(rp/f'assets/oa/textures/font/{file}.png')
  (rp/f'assets/oa/font/{file}.json').write_text(dump({'providers':[{'type':'bitmap','file':f'oa:font/{file}.png','ascent':8,'height':10,'chars':rows}]})+'\n',encoding='utf-8')
 # BR obtains the item's custom_name. TDM needs a component, not a macro string.
 f=d/'tdm/hud_player.mcfunction';s=f.read_text(encoding='utf-8')
 s=re.sub(r'(data modify storage oa:tdm_hud name set value )"固有武器なし"',r'\1{text:"固有武器なし",color:"gray"}',s)
 for w in weapons:
  s=re.sub(r'(execute if score @s tdm.weapon matches '+str(w['kind'])+r' run data modify storage oa:tdm_hud name set value ).*',lambda m:m[1]+dump(named(w,w['name'])),s)
 f.write_text(s,encoding='utf-8')
 f=d/'tdm/hud_line.mcfunction';s=f.read_text(encoding='utf-8').replace('{text:" 青  |  $(name)  CT ",color:"gold"}','{text:" 青  |  ",color:"aqua"},{nbt:"name",storage:"oa:tdm_hud",interpret:true},{text:"  CT ",color:"white"}').lstrip('$');f.write_text(s,encoding='utf-8')
 # Ground labels receive their own text component at creation, not a live storage reference.
 f=d/'tdm/loot/label.mcfunction';s=f.read_text(encoding='utf-8')
 s=re.sub(r'# weapon-colour\d+\n.*?(?=function oa:tdm/loot/label_spawn)', '',s,flags=re.S)
 pos=s.index('function oa:tdm/loot/label_spawn')
 if '# weapon-colour207' not in s:
  lines=['# weapon-colour207','data modify storage oa:tdm_label component set value {text:"",extra:[]}', 'data modify storage oa:tdm_label component.text set from storage oa:tdm_label name']
  for w in weapons:
   if w['kind']==9 or w['kind']==12:continue
   k=103 if w['kind']==11 else w['kind']
   c={'text':'','extra':[named(w,w['name']),{'text':' [近づくと取得]' if k==103 else ' [シフトで交換]','color':'gray'}]}
   lines.append(f'execute if score @s tdm.type matches {k} run data modify storage oa:tdm_label component set value '+dump(c))
  s=s[:pos]+'\n'.join(lines)+'\n'+s[pos:]
 f.write_text(s,encoding='utf-8')
 f=d/'tdm/loot/label_spawn.mcfunction';s=f.read_text(encoding='utf-8')
 s=s.replace('$summon','summon').replace('text:{text:"$(name)",color:"gold"}','text:{text:""}')
 if 'component' not in s:s+='\ndata modify entity @e[tag=tdm.label_new,limit=1] text set from storage oa:tdm_label component\n'
 f.write_text(s,encoding='utf-8')
 f=d/'itori/hud.mcfunction';s=f.read_text(encoding='utf-8').replace('{"text":"いとり：昭心 ","color":"light_purple"}',dump(named(weapons[9],'いとり：昭心 ')));f.write_text(s,encoding='utf-8')
 # Existing placed practice labels are migrated once. No rebuilding is needed.
 lines=[]
 for w in weapons:
  sel=f'@e[type=minecraft:text_display,tag=oa.practice_weapon_{w["info"]},tag=!oa.text209]'
  label=w['name'] if w['kind']!=12 else 'ふろっしゅ：ふろボール'
  lines += [f'execute in oa:practice as {sel} run data modify entity @s text set value '+dump(named(w,label)),f'execute in oa:practice run tag {sel} add oa.text209']
 (d/'presentation/refresh_labels.mcfunction').write_text('\n'.join(lines)+'\n',encoding='utf-8')
 # Static labels and exact weapon name components in generated/build sources.
 names={}
 for w in weapons:
  for label in [w['name'],w['name']+'：'+w['title']]:names[label]=w
  if w['kind']==4:names['ねろ']=w;names['ネロ']=w
 for f in d.rglob('*.mcfunction'):
  if f.parts[-3:-1]==('gallery','info'):continue
  s=f.read_text(encoding='utf-8')
  def replace(m):
   raw=json.loads('"'+m['label']+'"');label=raw.split('\n')[0];w=names.get(label)
   if not w:return m[0]
   c=named(w,w['name'] if label in ['ねろ','ネロ'] else label)
   if '\n' in raw:c={'text':'','extra':[c,{'text':'\n'+raw.split('\n',1)[1],'color':'gray','font':'minecraft:default'}]}
   return dump(c)
  # Rebuild previously styled names too: remove the old font/shadow overrides.
  s2=re.sub(r'\{"text"\s*:\s*"(?P<label>(?:[^"\\]|\\.)*)",[^{}\n]*\}',replace,s)
  s2=re.sub(r'\{(?:"text"|text)\s*:\s*"(?P<label>(?:[^"\\]|\\.)*)"\s*,\s*(?:"color"|color)\s*:\s*"[^"\n]+"(?:\s*,\s*(?:"bold"|bold)\s*:\s*(?:true|false))?\s*\}',replace,s2)
  if s2!=s:f.write_text(s2,encoding='utf-8')
