from pathlib import Path
import json,math,re,shutil
p=Path('revision/pack');f=p/'data/oa/function';o=Path('release_1_8_0')
def w(x,s):x.parent.mkdir(parents=True,exist_ok=True);x.write_text(s)
def j(x,d):w(x,json.dumps(d,ensure_ascii=False,indent=2))
def add(x,s):w(x,x.read_text()+'\n'+s+'\n')
# One Bernoulli sample per server tick, avoiding multiple native immunity queries per hit.
w(f/'curse/prepare.mcfunction','''execute store result score #guard_roll oa.tmp run random value 1..100
execute if score #guard_roll oa.tmp matches 1..25 run tag @s add oa.curse_guard
''')
x=f/'tick.mcfunction';w(x,'''tag @a remove oa.curse_guard
execute as @a if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/prepare
'''+x.read_text())
w(f/'curse/roll.mcfunction','execute if entity @s[tag=oa.curse_guard] run function oa:curse/blocked\n')
w(f/'curse/blocked.mcfunction','''scoreboard players set @s oa.blocked 1
particle minecraft:flash{color:[0.8,0.3,1.0,1.0]} ~ ~1 ~ 0 0 0 0 1 normal @a[distance=..40]
particle minecraft:firework ~ ~1 ~ 0.6 0.8 0.6 0.1 40 normal @a[distance=..40]
particle minecraft:reverse_portal ~ ~1 ~ 0.6 0.8 0.6 0.25 36 normal @a[distance=..40]
playsound minecraft:item.shield.block player @a[distance=..32] ~ ~ ~ 1.8 0.65
playsound minecraft:block.amethyst_block.resonate player @a[distance=..32] ~ ~ ~ 1.6 1.6
playsound minecraft:entity.firework_rocket.blast player @a[distance=..32] ~ ~ ~ 1.2 1.3
''')
x=p/'data/oa/enchantment/curse.json';d=json.loads(x.read_text());terms=d['effects']['minecraft:damage_immunity'][0]['requirements']['terms'];terms=[t for t in terms if not (t.get('type')=='minecraft:inverted' and t.get('term',{}).get('type')=='minecraft:damage_source_properties')]
for i,t in enumerate(terms):
 if t.get('type')=='minecraft:random_chance':terms[i]={'type':'minecraft:entity_properties','entity':'this','predicate':{'minecraft:nbt':'{Tags:["oa.curse_guard"]}'}}
d['effects']['minecraft:damage_immunity'][0]['requirements']['terms']=terms;j(x,d)
x=p/'data/minecraft/tags/damage_type/bypasses_enchantments.json';d=json.loads(x.read_text());d['values']=[a for a in d['values'] if a not in ['oa:execution','oa:yuua_counter']];j(x,d)
# Route the counter with an exact source entity and allow the killing guard before execution.
x=p/'data/oa/enchantment/hat.json';d=json.loads(x.read_text());counter=d['effects']['minecraft:post_attack'][0];prep=json.loads(json.dumps(counter));prep['affected']='victim';prep['effect']={'type':'minecraft:run_function','function':'oa:yuua/counter_prepare'}
for eff in counter['effect']['effects']:
 if eff.get('type')=='minecraft:damage_entity':eff.clear();eff.update(type='minecraft:run_function',function='oa:yuua/counter_strike')
counter['effect']['effects'].append({'type':'minecraft:run_function','function':'oa:yuua/counter_cleanup'});d['effects']['minecraft:post_attack'].insert(0,prep);j(x,d)
w(f/'yuua/counter_prepare.mcfunction','tag @a remove oa.yuua_counter_source\ntag @s add oa.yuua_counter_source\n')
w(f/'yuua/counter_cleanup.mcfunction','tag @a remove oa.yuua_counter_source\n')
w(f/'yuua/counter_strike.mcfunction','''scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
execute if entity @a[tag=oa.yuua_counter_source,limit=1] run damage @s 10000 oa:yuua_counter by @a[tag=oa.yuua_counter_source,limit=1]
''')
x=f/'yuua/check_attacker.mcfunction';s=x.read_text().replace('tag @s add oa.hat_victim','scoreboard players set @s oa.blocked 0\nexecute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll\nexecute if score @s oa.blocked matches 1 run return 0\ntag @s add oa.hat_victim');w(x,s)
# Direct scripted attacks use the same guard and reliable feedback.
for name in ['tayayuyu/fire_hit','tayayuyu/bomb_damage']:
 x=f/(name+'.mcfunction');s=x.read_text();s='scoreboard players set @s oa.blocked 0\nexecute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll\nexecute if score @s oa.blocked matches 1 run return 0\n'+s;w(x,s)
# Scale multiplier is +150%, giving a final 2.5x baseline size.
x=f/'tayayuyu/giant_all.mcfunction';w(x,x.read_text().replace('1.75倍','2.5倍').replace('amount:0.75','amount:1.5'))
# Visible outline of the actual union of three radius-3 spheres (centres y=-1,0,+1).
fx=[]
for y in [-4,-3.5,-3,-2,-1,0,1,2,3,3.5,4]:
 rad=max([math.sqrt(max(0,9-(y-c)**2)) if abs(y-c)<=3 else 0 for c in [-1,0,1]])
 n=20 if rad>0 else 1
 for i in range(n):
  a=2*math.pi*i/n;fx.append(f'particle minecraft:dust{{color:[1.0,0.6,0.1],scale:1.4}} ~{rad*math.cos(a):.4f} ~{y:.4f} ~{rad*math.sin(a):.4f} 0 0 0 0 1 normal @a[distance=..32]')
fx.append('playsound minecraft:block.beacon.activate player @a[distance=..24] ~ ~ ~ 0.8 1.8');w(f/'hotchikisu/range_fx.mcfunction','\n'.join(fx)+'\n')
# Furoball: a consumable projectile, separate from the one-unique-weapon slot limit.
comp={'minecraft:custom_name':{'text':'ふろボール','color':'gold','italic':False},'minecraft:custom_data':{'oa_furoball':True},'minecraft:item_model':'minecraft:fire_charge','minecraft:max_stack_size':16,'minecraft:food':{'nutrition':0,'saturation':0,'can_always_eat':True},'minecraft:consumable':{'consume_seconds':.05,'animation':'none','sound':'minecraft:item.firecharge.use','has_consume_particles':False,'on_consume_effects':[]},'minecraft:use_cooldown':{'seconds':1.,'cooldown_group':'oa:furoball'},'minecraft:lore':[{'text':'右クリック：爆風で周囲を吹き飛ばす','color':'gray','italic':False},{'text':'自分は爆風で上昇／使い切り','color':'gray','italic':False}]}
entry={'type':'minecraft:item','name':'minecraft:paper','modifier':[{'type':'minecraft:set_components','components':comp}]}
j(p/'data/oa/loot_table/br/test/furoball.json',{'type':'minecraft:chest','pools':[{'rolls':1,'entries':[entry]}]})
for name,chance in [('chest_basic',10),('chest_upgraded',15)]:
 x=p/f'data/oa/loot_table/br/{name}.json';d=json.loads(x.read_text());e=json.loads(json.dumps(entry));e['weight']=chance;d['pools'].append({'rolls':1,'entries':[e,{'type':'minecraft:empty','weight':100-chance}]});j(x,d)
w(f/'give/furoball.mcfunction','loot give @s loot oa:br/test/furoball\n')
j(p/'data/oa/advancement/furoball/use.json',{'criteria':{'used':{'trigger':'minecraft:consume_item','conditions':{'item':{'predicates':{'minecraft:custom_data':{'oa_furoball':True}}}}}},'rewards':{'function':'oa:furoball/use'}})
a=f/'furoball'
w(a/'refund.mcfunction','execute unless entity @s[gamemode=creative] run loot give @s loot oa:br/test/furoball\n')
w(a/'use.mcfunction','''advancement revoke @s only oa:furoball/use
execute unless score #state br.state matches 1 run return run function oa:furoball/unavailable
execute unless entity @s[tag=br.alive,gamemode=!spectator] run return run function oa:furoball/unavailable
execute if entity @s[tag=br.pvp_grace] run return run function oa:furoball/protected
execute if entity @s[tag=oa.self_decoy] run return run function oa:furoball/unavailable
scoreboard players set #f_count oa.tmp 0
execute as @e[type=minecraft:item_display,tag=oa.furoball] run scoreboard players add #f_count oa.tmp 1
execute if score #f_count oa.tmp matches 20.. run return run function oa:furoball/unavailable
scoreboard players operation #f_owner oa.tmp = @s oa.id
scoreboard players operation #f_team oa.tmp = @s oa.team
execute anchored eyes positioned ^ ^ ^0.5 run function oa:furoball/spawn
playsound minecraft:item.firecharge.use player @a[distance=..24] ~ ~ ~ 1.4 0.8
''')
w(a/'unavailable.mcfunction','function oa:furoball/refund\ntellraw @s {text:"今はふろボールを使用できません。",color:"yellow"}\n')
w(a/'protected.mcfunction','function oa:furoball/refund\nfunction oa:combat/protection_notice\n')
w(a/'spawn.mcfunction','''summon minecraft:item_display ~ ~ ~ {Tags:["oa.furoball","oa.furo_new"],item:{id:"minecraft:fire_charge",count:1},item_display:"fixed",brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],scale:[0.5f,0.5f,0.5f],right_rotation:[0f,0f,0f,1f]}}
tp @e[type=minecraft:item_display,tag=oa.furo_new,limit=1] ~ ~ ~ ~ ~
scoreboard players operation @e[tag=oa.furo_new] oa.fowner = #f_owner oa.tmp
scoreboard players operation @e[tag=oa.furo_new] oa.fteam = #f_team oa.tmp
scoreboard players operation @e[tag=oa.furo_new] br.round = #round br.round
scoreboard players set @e[tag=oa.furo_new] oa.ftime 60
tag @e[tag=oa.furo_new] remove oa.furo_new
''')
w(a/'tick.mcfunction','''execute unless score #state br.state matches 1 run return run kill @s
execute unless score @s br.round = #round br.round run return run kill @s
scoreboard players remove @s oa.ftime 1
execute if score @s oa.ftime matches ..0 run return run kill @s
tag @e[tag=oa.f_current] remove oa.f_current
tag @s add oa.f_current
scoreboard players operation #f_owner oa.tmp = @s oa.fowner
scoreboard players operation #f_team oa.tmp = @s oa.fteam
scoreboard players set #f_hit oa.tmp 0
scoreboard players set #f_step oa.tmp 4
function oa:furoball/step
''')
w(a/'step.mcfunction','''execute unless loaded ~ ~ ~ run return run kill @s
execute unless block ~ ~ ~ #oa:push_passable run return run function oa:furoball/explode
execute if block ~ ~ ~ minecraft:water run return run function oa:furoball/explode
execute store result score #f_probe_x oa.tmp run data get entity @s Pos[0] 10000
execute store result score #f_probe_y oa.tmp run data get entity @s Pos[1] 10000
execute store result score #f_probe_z oa.tmp run data get entity @s Pos[2] 10000
execute as @a[tag=br.alive,tag=!br.pvp_grace,gamemode=!spectator,distance=..6] unless score @s oa.id = #f_owner oa.tmp run function oa:furoball/body
execute if score #f_hit oa.tmp matches 1 run return run function oa:furoball/explode
particle minecraft:flame ~ ~ ~ 0.08 0.08 0.08 0.01 2 normal @a[distance=..48]
scoreboard players remove #f_step oa.tmp 1
execute if score #f_step oa.tmp matches 0 run return 0
tp @s ^ ^ ^0.25
execute at @s run function oa:furoball/step
''')
s=(f/'throwable/observe/body.mcfunction').read_text().replace('#obs_team oa.team','#f_team oa.tmp')
s=re.sub(r'#(body_[a-z_]+|probe_[xyz]|height_factor|height_neg|height|three|ten)\b',lambda m:'#f_'+m[1],s)
s=s.replace('at @s run function oa:throwable/observe/hit','run scoreboard players set #f_hit oa.tmp 1');w(a/'body.mcfunction',s)
w(a/'explode.mcfunction','''particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1 normal @a[distance=..48]
particle minecraft:flame ~ ~ ~ 0.8 0.6 0.8 0.15 45 normal @a[distance=..48]
playsound minecraft:entity.generic.explode player @a[distance=..48] ~ ~ ~ 1.5 0.85
tag @a remove oa.f_source
execute as @a if score @s oa.id = #f_owner oa.tmp run tag @s add oa.f_source
execute as @a[tag=br.alive,tag=!br.pvp_grace,gamemode=!spectator,distance=..3.5] at @s run function oa:furoball/blast
execute as @a[tag=oa.f_source,tag=br.alive,distance=..3.5] at @s run function oa:furoball/up
tag @a remove oa.f_source
kill @s
''')
w(a/'blast.mcfunction','''execute if score @s oa.id = #f_owner oa.tmp run return 0
execute if score #f_team oa.tmp matches 1.. if score @s oa.team = #f_team oa.tmp run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
function oa:furoball/push
execute if entity @a[tag=oa.f_source] run damage @s 3 minecraft:explosion by @a[tag=oa.f_source,limit=1]
execute unless entity @a[tag=oa.f_source] run damage @s 3 minecraft:explosion
''')
w(a/'push.mcfunction','''tag @a remove oa.f_victim
tag @s add oa.f_victim
execute at @e[type=minecraft:item_display,tag=oa.f_current,limit=1] run summon minecraft:marker ~ ~ ~ {Tags:["oa.f_dir"]}
execute as @e[type=minecraft:marker,tag=oa.f_dir,limit=1] at @s run tp @s ~ ~ ~ facing entity @a[tag=oa.f_victim,limit=1] feet
execute store result storage oa:fire_args id int 1 run scoreboard players get @s oa.id
function oa:furoball/save_push with storage oa:fire_args
scoreboard players set @s oa.kpush 6
scoreboard players set @s oa.kboost 1
kill @e[type=minecraft:marker,tag=oa.f_dir]
tag @s remove oa.f_victim
''')
w(a/'save_push.mcfunction','$data modify storage oa:players p$(id).kb_yaw set from entity @e[type=minecraft:marker,tag=oa.f_dir,limit=1] Rotation[0]\n')
w(a/'up.mcfunction','''effect give @s minecraft:levitation 1 44 true
scoreboard players set @s oa.fup 3
tag @s add oa.furo_up
particle minecraft:cloud ~ ~0.1 ~ 0.5 0.1 0.5 0.12 20 normal @a[distance=..32]
''')
w(a/'up_tick.mcfunction','''scoreboard players remove @s oa.fup 1
execute if score @s oa.fup matches ..0 run function oa:furoball/clear_up
''')
w(a/'clear_up.mcfunction','''execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:44}] run effect clear @s minecraft:levitation
tag @s remove oa.furo_up
scoreboard players set @s oa.fup 0
''')
for obj in ['oa.fowner','oa.fteam','oa.ftime','oa.fup']:add(f/'load.mcfunction',f'scoreboard objectives add {obj} dummy')
add(f/'world_tick.mcfunction','execute as @e[type=minecraft:item_display,tag=oa.furoball] at @s run function oa:furoball/tick')
add(f/'tick.mcfunction','execute as @a[tag=oa.furo_up] at @s run function oa:furoball/up_tick')
for name in ['br/eliminate','br/enter','br/restore']:add(f/(name+'.mcfunction'),'function oa:furoball/clear_up')
add(f/'br/finish.mcfunction','execute in minecraft:overworld run kill @e[type=minecraft:item_display,tag=oa.furoball]\nexecute as @a[tag=oa.furo_up] run function oa:furoball/clear_up')
add(f/'admin/dispatch.mcfunction','execute if score @s oa.admin matches 37 run function oa:give/furoball')
# Participant-facing written guide and self-only trigger controls.
l=f/'lobby/guide'
pages=[]
def textpage(text):return {'raw':{'text':text,'color':'black'}}
def buttons(title,items):return {'raw':{'text':title+'\n\n','color':'black','extra':[{'text':label+'\n\n','color':color,'underlined':True,'click_event':{'action':'run_command','command':f'/trigger oa.lobby set {action}'}} for label,action,color in items]}}
pages.append(buttons('OA ロビー案内',[('ゲームに参加',1,'dark_green'),('観戦者になる',2,'dark_gray'),('参加へ戻る',6,'dark_green'),('自分の統計',3,'dark_aqua')]))
teamcolors=['ピンク','水色','赤','青','黄緑','黄','紫','オレンジ','白','黒']
for start in [1,6]:pages.append(buttons('チームを選択',[(f'チーム{i}（{teamcolors[i-1]}）',100+i,'dark_blue') for i in range(start,start+5)]))
pages.append(textpage('試合のルール\n\n最後の生存者／チームが勝利。\n死亡すると観戦へ。\n開始1分は保護期間。\n安置は段階的に縮小。\n6分でチェスト再補充。\n固有装備は1人1個。\nチーム戦は味方を攻撃不可。'))
items=[('ゆうあ：ピンク帯の麦わら帽子','拾うと強制装着。発光し、攻撃・反撃で相手を倒す。30秒で壊れる。'),('ぴちぴち：冷凍さかな','持つと素早く移動・高くジャンプ。攻撃した相手を跳ねさせる。落下ダメージなし。'),('らじ：防音マイク付きマスク','右クリックで装着。周囲へ音波攻撃。時々息切れして遅くなる。'),('ネロノワール：ペスト医師の杖','右クリックで印と帰還。しゃがみ右クリックで本人デコイ。共通CT10秒。'),('キリング：呪いの「き」マスク','強制装着・取り外し不可。高速移動・盲目。参加者の攻撃を25%で無効化。1分で壊れる。'),('ゆったり：瞬間奇襲アイテム','右クリックで敵の背後に奇襲し、元の場所へ帰還。相手を吹き飛ばす。CT10秒。'),('ほちきす：ホッチキス','右クリックで周囲を2.5秒拘束。CT15秒。通常攻撃で短時間出血。'),('こまめ：小豆バー','右クリックで10秒小さくなり、耐性・体力・速度を強化。CT20秒。'),('たやゆゆ：変態ガチャ','右クリックで16種類の全体ガチャ。味方・自分も巻き込む。CT45秒。まれに打ち上げる。')]
for title,desc in items:pages.append(textpage(title+'\n\n'+desc))
pages.append(textpage('回復・消耗品\n\n包帯：右クリックですぐ回復。\n応急キット：2秒使用で回復。\nゆー：手に持つと致死攻撃の身代わり。後からデバフ。\nふろボール：右クリックで投てき。爆風で相手を吹き飛ばし、自分は上昇。'))
pages.append(textpage('鉱石と医療品\n\n石炭鉱石：食料。\nレッドストーン鉱石：医療品。\n時々その場で回復も。\n\nビール：再生\nドリア：耐性\nサーモン・ゆずぽん：速度\n小豆：体力\n非常食：跳躍と攻撃\nバフはすべて10秒。'))
pages.append(textpage('通常装備\n\nバット：強い押し出し。\nノックバック棒：押し出し。\n雪玉：小さなダメージと鈍足。\n卵：小さなダメージと押し出し。\n弓・クロスボウ：矢を使用。\n盾：攻撃を防ぐ。\n食料：ステーキ・りんご。'))
book={'title':{'raw':'OA ロビー案内'},'author':'OA BattleRoyale','generation':0,'resolved':True,'pages':pages}
line='give @s minecraft:written_book[minecraft:written_book_content='+json.dumps(book,ensure_ascii=False,separators=(',',':'))+',minecraft:custom_name={text:"OA ロビー案内",color:"aqua",italic:false},minecraft:custom_data={oa_player_book:1b,guide_v180:1b},minecraft:max_stack_size=1] 1'
s='''execute if items entity @s inventory.* *[minecraft:custom_data~{oa_player_book:1b,guide_v180:1b}] run return 0
execute if items entity @s hotbar.* *[minecraft:custom_data~{oa_player_book:1b,guide_v180:1b}] run return 0
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_player_book:1b,guide_v180:1b}] run return 0
clear @s *[minecraft:custom_data~{oa_player_book:1b}]
scoreboard players set #guide_free oa.tmp 0
'''
for slot in [f'hotbar.{i}' for i in range(9)]+[f'inventory.{i}' for i in range(27)]:s+=f'execute unless items entity @s {slot} * run scoreboard players set #guide_free oa.tmp 1\n'
s+='execute if score #guide_free oa.tmp matches 0 run return 0\n'+line+'\n';w(l/'book.mcfunction',s)
w(l/'dispatch.mcfunction','''execute if score @s oa.lobby matches 3 run return run function oa:stats/personal
execute if score @s oa.lobby matches 6 run return run function oa:lobby/return
execute if score @s oa.lobby matches 2 run return run function oa:lobby/guide/watch
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中の参加・チーム変更は管理者へ依頼してください。",color:"yellow"}
execute if score @s oa.lobby matches 1 run return run function oa:lobby/return
execute if score @s oa.lobby matches 101..110 run function oa:br/join
'''+''.join(f'execute if score @s oa.lobby matches {100+i} run function oa:br/team/{i}\n' for i in range(1,11)))
w(l/'watch.mcfunction','''execute if score #state br.state matches 1 if entity @s[tag=br.alive] run return run function oa:br/surrender
execute if score #state br.state matches 0 run return run function oa:lobby/watch
execute if entity @s[tag=br.playing] run return 0
tag @s add br.watch
tag @s remove br.lobby
gamemode spectator @s
execute if data storage oa:br center run function oa:internal/tp with storage oa:br center
''')
add(f/'load.mcfunction','scoreboard objectives add oa.lobby trigger')
add(f/'public/tick.mcfunction','''execute as @a[scores={oa.lobby=1..}] at @s run function oa:lobby/guide/dispatch
scoreboard players set @a oa.lobby 0
scoreboard players enable @a oa.lobby''')
add(f/'lobby/tick.mcfunction','execute if score #clock oa.beat matches 0 as @a[tag=br.lobby_now,tag=!br.playing] at @s run function oa:lobby/guide/book')
# Written books cannot be opened normally in spectator; keep an explicit return control in chat.
add(f/'lobby/watch.mcfunction','tellraw @s {text:"[参加者へ戻る]",color:"green",click_event:{action:"run_command",command:"/trigger oa.lobby set 6"}}')
# Admin test convenience.
x=f/'admin/book.mcfunction';s=x.read_text();start=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');end=s.index(',minecraft:custom_name=',start);d=json.loads(s[start:end]);d['pages'].append(buttons('投てきアイテム',[('ふろボールを入手',37,'dark_red')]))
# Admin controls use the admin trigger, not the participant selector.
d['pages'][-1]['raw']['extra'][0]['click_event']['command']='/trigger oa.admin set 37';s=s[:start]+json.dumps(d,ensure_ascii=False,separators=(',',':'))+s[end:];w(x,s.replace('book_v172','book_v180'))
shutil.copy('release_1_8_0/build180.py',p/'source/build180.py')
print('180 features written')
