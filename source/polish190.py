from pathlib import Path
import json,copy,shutil
P=Path('revision/pack');F=P/'data/oa/function'
def edit(n,a,b):
 p=F/(n+'.mcfunction');s=p.read_text();assert a in s,(n,a);p.write_text(s.replace(a,b))
def pre(n,s):
 p=F/(n+'.mcfunction');p.write_text(s+'\n'+p.read_text())
def add(n,s):
 p=F/(n+'.mcfunction');p.write_text(p.read_text()+'\n'+s+'\n')
def w(n,s):
 p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n')
# Restore normal carrying rules immediately even for a player who was not a tester before debug.
edit('debug/stop','tag @s remove oa.debug','''tag @s remove oa.debug
execute if entity @s[tag=oa.current] run tag @s add oa.db_was_current
tag @s add oa.current
function oa:inventory/check
execute unless entity @s[tag=oa.db_was_current] run tag @s remove oa.current
tag @s remove oa.db_was_current''')
# Central timing switch includes all hand skills and Lazi's automatic attacks.
guard='''execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0'''
for n in ['skill','lazi/sonic','nero/decoy','nero/mark_or_return','yuttari/use','hotchikisu/use','komame/use']:pre(n,guard)
# Disabling the personal one-item rule must not block issuing the test hat globally.
edit('give/internal/yuua','execute if score #yuua_issued br.tmp matches 1','execute unless entity @s[tag=oa.debug] if score #yuua_issued br.tmp matches 1')
edit('give/internal/yuua','scoreboard players set #yuua_issued br.tmp 1','execute unless entity @s[tag=oa.debug] run scoreboard players set #yuua_issued br.tmp 1')
# Damage recursion guard for the additional hat hook.
p=P/'data/oa/enchantment/hat.json';d=json.loads(p.read_text());d['effects']['minecraft:post_attack'][-1]['requirements']['terms'].append({'type':'minecraft:inverted','term':{'type':'minecraft:damage_source_properties','predicate':{'tags':[{'id':['oa:execution','oa:yuua_counter'],'expected':True}]}}});p.write_text(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
# Snapshot counts at start: historic statistics must never turn into free stacks.
add('debug/start','scoreboard players set @s oa.db_snow 0\nscoreboard players set @s oa.db_egg 0')
# Native snow/egg collision still runs unchanged. Observer only applies OA effects AFTER vanilla removes projectile.
edit('throwable/observe/world','execute unless score #state br.state matches 1','execute unless entity @a[tag=oa.debug,tag=oa.db_free_match] unless score #state br.state matches 1')
edit('throwable/observe/init','execute if score #throw_owner oa.tmp matches 0 run return 0','execute on origin if entity @s[tag=oa.debug,tag=oa.db_free_match] run scoreboard players operation #throw_owner oa.tmp = @s oa.id\nexecute if score #throw_owner oa.tmp matches 0 run return 0')
edit('throwable/observe/impact','execute unless entity @a[tag=oa.observe_owner] run return 0','execute as @a[tag=oa.debug,tag=oa.db_free_match] if score @s oa.id = #obs_owner oa.tmp run tag @s add oa.observe_owner\nexecute unless entity @a[tag=oa.observe_owner] run return 0')
edit('throwable/observe/ray','execute if score #hit oa.tmp matches 1 run return 0','''execute if entity @a[tag=oa.observe_owner,tag=oa.debug] as @a[tag=oa.debug,tag=!oa.observe_owner,tag=!oa.self_decoy,tag=!oa.decoy_grace,nbt=!{Health:0.0f},distance=..3,sort=nearest] unless score #hit oa.tmp matches 1 run function oa:throwable/observe/body
execute if entity @a[tag=oa.observe_owner,tag=oa.db_mobs] as @e[tag=oa.debug_mob,distance=..3,nbt=!{Health:0.0f},sort=nearest] unless score #hit oa.tmp matches 1 run function oa:throwable/observe/body
execute if score #hit oa.tmp matches 1 run return 0''')
# Debug projectiles may only supplement damage against consenting targets, never normal lobby bystanders.
edit('throwable/observe/ray','execute as @a[tag=br.alive','execute unless entity @a[tag=oa.observe_owner,tag=oa.debug] as @a[tag=br.alive')
edit('throwable/observe/body','execute if score #obs_team oa.team matches 1..','execute unless entity @a[tag=oa.observe_owner,tag=oa.db_friendly] if score #obs_team oa.team matches 1..')
edit('throwable/push/tick','execute unless entity @s[tag=br.alive','execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=oa.debug_mob] unless entity @s[tag=br.alive')
edit('throwable/push/tick','execute unless score #state br.state matches 1','execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=oa.debug_mob] unless score #state br.state matches 1')
add('debug/mob/tick','execute if score @s oa.tpush matches 1.. run function oa:throwable/push/tick')
# Mob observer push gets its actual velocity, while normal player movement code remains untouched.
pre('throwable/push/start','execute if entity @s[tag=oa.debug_mob] run return run function oa:debug/mob/throw_push')
w('debug/mob/throw_push','''execute store result entity @s Motion[0] double 0.00012 run scoreboard players get #mx oa.tmp
execute store result entity @s Motion[2] double 0.00012 run scoreboard players get #mz oa.tmp
data modify entity @s Motion[1] set value 0.1d''')
# Furoball mob range bypass honors team switch too; flags read from exact source.
for n in ['furoball/body','furoball/blast']:
 edit(n,'execute if score #f_team oa.tmp matches 1..','execute unless entity @a[tag=oa.f_source,tag=oa.db_friendly] if score #f_team oa.tmp matches 1..')
# Body collision occurs before oa.f_source is set; tag source for collision for the duration of projectile tick.
pre('furoball/body','execute if entity @s[tag=oa.debug_mob] run scoreboard players set @s oa.team 0')
# Mob target damage bounds approximate player-sized bodies. Flag limitation in docs, do not claim exact model matching.
# Ensure debug result labels are descriptive, not only integer values.
labels=['最大体力アップ','炎の呪い','スピードアップ','脱落者の復活','全員ぴょんぴょん','ゆうあの帽子','足元にTNT','全員ちび化','席替えタイム','強制集合','平和な世界','全員キリング気分','丸見え大会','空腹の時間','全員巨大化','大ハズレ：自己紹介']
edit('debug/gacha/use','tellraw @a[tag=oa.debug] [{text:"[ガチャテスト] 結果 ",color:"light_purple"},{score:{name:"#gacha_roll",objective:"oa.tmp"}}]','\n'.join(f'execute if score #gacha_roll oa.tmp matches {i+1} run tellraw @a[tag=oa.debug] {{text:"[ガチャテスト] {s}",color:"light_purple"}}' for i,s in enumerate(labels)))
# Target context cleanup is always scoped and source tagged only synchronously.
# Fix guide team names against the actual registered teams.
p=F/'lobby/guide/book.mcfunction';s=p.read_text();i=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',i);d=json.loads(s[i:e])
colors={1:('ピンク','dark_purple'),2:('水色','dark_aqua'),3:('赤','dark_red'),4:('青','dark_blue'),5:('黄緑','dark_green'),6:('黄','gold'),7:('紫','dark_purple'),8:('オレンジ','gold'),9:('白','gray'),10:('黒','black')}
for pg in d['pages']:
 for c in pg['raw']['extra']:
  cmd=c.get('click_event',{}).get('command','')
  if cmd.startswith('/trigger oa.lobby set 10') or cmd=='/trigger oa.lobby set 110':
   n=int(cmd.rsplit(' ',1)[1])-100
   if n in colors:
    name,color=colors[n];c['text']=f'チーム{n}（{name}）\n';c['color']=color
s=s[:i]+json.dumps(d,ensure_ascii=False,separators=(',',':'))+s[e:];p.write_text(s)
# Wrap book text into readable 14-line pages, keeping each button intact.
def splitlines_pixels(s):
 lines=[];cur='';pixels=0
 for ch in s:
  if ch=='\n':lines.append(cur);cur='';pixels=0;continue
  width=9 if ord(ch)>255 else (4 if ch==' ' else 6)
  if pixels+width>110:lines.append(cur);cur='';pixels=0
  cur+=ch;pixels+=width
 if cur:lines.append(cur)
 return lines
for name in ['admin/book','debug/book_give','lobby/guide/book']:
 p=F/(name+'.mcfunction');s=p.read_text();i=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',i);d=json.loads(s[i:e]);out=[]
 for pg in d['pages']:
  parts=pg['raw']['extra'];header=parts[0];header_lines=len(splitlines_pixels(header['text']));body=[];used=header_lines
  def flush():
   global body,used
   if body:out.append({'raw':{'text':'','extra':[copy.deepcopy(header),*body]}})
   body=[];used=header_lines
  for c in parts[1:]:
   # Placeholder values are short Japanese words; expansion is counted conservatively.
   estimate=c['text']
   import re
   estimate=re.sub(r'\$\([a-z_]+\)','なし',estimate)
   ln=len(splitlines_pixels(estimate))
   if ln+used<=14:body.append(c);used+=ln;continue
   if 'click_event' in c or ln<=14-header_lines:
    flush();body.append(c);used+=ln;continue
   # Long prose component: split at rendered line boundaries, preserving the style.
   for line in splitlines_pixels(c['text']):
    if used>=14:flush()
    bit=copy.deepcopy(c);bit['text']=line+'\n';body.append(bit);used+=1
  flush()
 d['pages']=out;s=s[:i]+json.dumps(d,ensure_ascii=False,separators=(',',':'))+s[e:];p.write_text(s)
# Avoid legacy administrator tag rewriting a brand-new book marker on re-issue.
# Source snapshots include exact active commands for reproducibility.
shutil.copyfile('release_1_9_0/polish190.py',P/'source/polish190.py')
p=P/'README_JA.md';s=p.read_text();s+='''
標的へのダメージは本当に発生します。一般モブの死亡・移動は元に戻せません。ロビー展示・無敵エンティティは自動選択から除外しています。モブの当たり箱に対する一部の追加効果判定は既存のプレイヤー向け近似を共用するため、大型・小型モブの端への命中では違いが出る可能性があります。固有装備を複数持てても常時強化は元の「装着・選択中の装備」の優先順位で処理します。全装備の常時効果が同時発動するモードではありません。
''';p.write_text(s)
