from pathlib import Path
import json,shutil,zipfile,re,math
from PIL import Image,ImageDraw,ImageFont
R=Path('/workspace/scratch/221a7bbb4169');O=R/'release_1_2';P=R/'revision/pack';RP=O/'resourcepack';shutil.copytree(R/'release_1_1_1/resourcepack',RP,dirs_exist_ok=True)
def js(p,obj):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(json.dumps(obj,ensure_ascii=False,indent=2)+'\n')
p=P/'data/oa/function/br/enter.mcfunction';p.write_text(p.read_text().replace('give @s minecraft:bread 6','give @s minecraft:bread 2'))
p=P/'data/oa/function/br/loot/chest_rare.mcfunction';s=p.read_text().replace('random value 1..100','random value 1..200');s=s.replace('#rare_chance br.tmp 4','#rare_chance br.tmp 12').replace('#rare_chance br.tmp 5','#rare_chance br.tmp 15').replace('#rare_chance br.tmp 6','#rare_chance br.tmp 18').replace('#rare_chance br.tmp 8','#rare_chance br.tmp 24');p.write_text(s)
p=P/'data/oa/function/br/loot/ground_event.mcfunction';s=p.read_text();a=s.index('scoreboard players set #extra_chance');s=s[:a]+'''execute in minecraft:overworld run function oa:br/loot/random_ground with storage oa:br_spawn
scoreboard players set #extra_chance br.tmp 0
execute if score #time br.time matches 4800.. run scoreboard players set #extra_chance br.tmp 375
execute if score #time br.time matches 7200.. run scoreboard players set #extra_chance br.tmp 750
execute if score #time br.time matches 9600.. run scoreboard players set #extra_chance br.tmp 125
execute if score #time br.time matches 9600.. in minecraft:overworld run function oa:br/loot/random_ground with storage oa:br_spawn
execute store result score #extra_roll br.tmp run random value 1..1000
execute if score #extra_roll br.tmp <= #extra_chance br.tmp in minecraft:overworld run function oa:br/loot/random_ground with storage oa:br_spawn
''';p.write_text(s)
items=[('beer','ビール',['regeneration'],'再生I',14,True),('doria','ミラノ風ドリア',['resistance'],'耐性I',14,False),('salmon','サーモン',['speed'],'移動速度上昇I',14,False),('paimon','非常食',['jump_boost','strength'],'跳躍力上昇I・攻撃力上昇I',2,False),('yuzupon','ゆずぽん',['speed'],'移動速度上昇I',14,True),('azuki','小豆',['health_boost'],'体力増強I',14,False)]
heal=json.loads((P/'data/oa/loot_table/br/heal.json').read_text());entries=heal['pools'][0]['entries'];entries[0]['weight']=26;entries[1]['weight']=2
for key,name,effects,desc,weight,drink in items:
 components={'minecraft:custom_name':{'text':name,'color':'aqua' if key!='paimon' else 'light_purple','italic':False},'minecraft:custom_data':{'oa_buff':key},'minecraft:max_stack_size':64,'minecraft:food':{'nutrition':0,'saturation':0,'can_always_eat':True},'minecraft:consumable':{'consume_seconds':1.0,'animation':'drink' if drink else 'eat','sound':'minecraft:entity.generic.drink' if drink else 'minecraft:entity.generic.eat','has_consume_particles':not drink,'on_consume_effects':[{'type':'minecraft:apply_effects','effects':[{'id':'minecraft:'+e,'duration':100,'amplifier':0,'show_particles':True,'show_icon':True} for e in effects],'probability':1.0}]},'minecraft:item_model':'oa:buff_'+key,'minecraft:lore':[{'text':('飲む' if drink else '食べる')+'と'+desc+'（5秒）','color':'gray','italic':False},{'text':'右クリックで使用／1個消費','color':'gray','italic':False}]}
 entry={'type':'minecraft:item','name':'minecraft:paper','weight':weight,'modifier':[{'type':'minecraft:set_components','components':components}]};entries.append(entry)
 js(P/f'data/oa/loot_table/br/buffs/{key}.json',{'type':'minecraft:chest','pools':[{'rolls':1,'entries':[dict(entry,weight=1)]}]})
 js(RP/f'assets/oa/items/buff_{key}.json',{'model':{'type':'minecraft:model','model':'oa:item/buff_'+key}})
 js(RP/f'assets/oa/models/item/buff_{key}.json',{'parent':'minecraft:item/generated','textures':{'layer0':'oa:item/buff_'+key},'gui_light':'front'})
js(P/'data/oa/loot_table/br/ore_medical.json',heal)
p=P/'data/oa/function/br/mining/broken.mcfunction';s=p.read_text().replace('table:"heal"','table:"ore_medical"');p.write_text(s)
f=P/'data/oa/function/give/buffs.mcfunction';f.write_text('\n'.join('loot give @s loot oa:br/buffs/'+i[0] for i in items)+'\n')
# Minecraft-native pixel sprites, all kept in the items atlas.
font=ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf',7)
for key,*_ in items:
 im=Image.new('RGBA',(64,64));d=ImageDraw.Draw(im)
 if key=='beer':
  d.rounded_rectangle((12,15,45,56),4,fill='#f1c14c',outline='#65351a',width=2);d.rectangle((16,24,40,51),fill='#d18a16');d.rounded_rectangle((41,23,56,45),5,outline='#e0edf1',width=5);d.rectangle((47,28,51,40),fill=(0,0,0,0));d.ellipse((10,10,29,24),fill='#fff5d6');d.ellipse((23,8,43,24),fill='#fff9e1');d.ellipse((36,12,48,25),fill='#f7edd3');d.line((20,29,20,47),fill='#ffe8a0',width=3)
 elif key=='doria':
  d.ellipse((3,21,61,54),fill='#666477');d.ellipse((5,16,59,49),fill='#e6e5da');d.ellipse((9,19,55,44),fill='#d59c37');d.ellipse((12,21,52,41),fill='#ffe49c')
  for x,y in [(20,26),(35,24),(43,31),(26,35),(18,34),(36,36)]:d.rectangle((x,y,x+4,y+3),fill='#a64825')
  for x,y in [(25,25),(40,35),(30,33)]:d.rectangle((x,y,x+2,y+2),fill='#527135')
 elif key=='salmon':
  d.polygon([(5,31),(15,24),(25,14),(43,16),(55,27),(57,34),(44,45),(25,47),(14,39),(4,44),(8,32)],fill='#b04847');d.polygon([(18,28),(28,20),(43,21),(52,29),(45,34),(29,37),(18,34)],fill='#eb9b85');d.polygon([(21,37),(30,39),(43,37),(41,43),(26,44)],fill='#425756');d.rectangle((45,25,48,28),fill='#172c33');d.polygon([(27,15),(32,8),(37,16)],fill='#6b3542')
 elif key=='paimon':
  # Paimon-inspired chibi: floating crown, white bob, peach cape, starry navy outfit.
  d.ellipse((19,3,46,10),outline='#d7af73',width=3);d.polygon([(22,7),(26,0),(31,7),(36,1),(41,8)],fill='#e8c68e');d.rounded_rectangle((16,15,48,40),8,fill='#f9f4eb');d.polygon([(13,25),(19,12),(35,11),(49,18),(53,31),(45,27),(43,18),(35,23),(28,18),(21,30)],fill='#fffdf8');d.ellipse((22,23,43,40),fill='#f4c8b5');d.rectangle((24,28,27,31),fill='#426b9d');d.rectangle((37,28,40,31),fill='#426b9d');d.line((30,35,34,35),fill='#a75d66',width=2);d.polygon([(21,39),(44,39),(51,53),(37,58),(17,53)],fill='#ebc7b9');d.polygon([(25,39),(39,39),(42,54),(22,54)],fill='#253a5b');d.polygon([(32,42),(34,46),(38,47),(34,49),(32,53),(30,49),(26,47),(30,46)],fill='#d9e9ee');d.rectangle((24,55,29,61),fill='#f7f2ee');d.rectangle((36,55,41,61),fill='#f7f2ee');d.ellipse((10,40,20,46),fill='#f7ded0');d.ellipse((45,40,55,46),fill='#f7ded0')
 elif key=='yuzupon':
  d.rectangle((25,5,41,14),fill='#e3c535',outline='#5c5523',width=2);d.rectangle((27,14,39,21),fill='#755324');d.rounded_rectangle((18,20,47,58),6,fill='#583621',outline='#2b211c',width=2);d.rectangle((20,29,45,49),fill='#edd96d');d.ellipse((29,24,39,34),fill='#e5cb24');d.ellipse((37,25,43,28),fill='#517c2f');d.text((21,36),'YUZU',font=font,fill='#30402e');d.text((24,44),'PON',font=font,fill='#382a1b')
 elif key=='azuki':
  d.ellipse((6,17,58,58),fill='#dfcaaa',outline='#775f55',width=2);d.ellipse((10,18,54,49),fill='#452c32')
  for x,y in [(14,23),(26,21),(38,24),(20,32),(33,33),(25,41),(43,34)]:d.ellipse((x,y,x+9,y+7),fill='#953f50',outline='#592333');d.line((x+4,y+2,x+5,y+5),fill='#e3b8a2',width=1)
 im.save(RP/f'assets/oa/textures/item/buff_{key}.png')
p=RP/'assets/minecraft/atlases/items.json';a=json.loads(p.read_text());a['sources'] += [{'type':'minecraft:single','resource':'oa:item/buff_'+i[0],'sprite':'oa:item/buff_'+i[0]} for i in items];js(p,a)
# Contact sheet is an internal visual check, not an extra README/deliverable.
preview=Image.new('RGB',(6*192,220),'#263139');dr=ImageDraw.Draw(preview)
for j,(key,*_) in enumerate(items):
 im=Image.open(RP/f'assets/oa/textures/item/buff_{key}.png').resize((192,192),Image.Resampling.NEAREST);preview.paste(im,(j*192,0),im);dr.text((j*192+12,199),key,fill='white')
preview.save(O/'sprite_preview.png')
# Rewrite the existing authoritative documents, no change-history additions.
p=P/'LOOT_JA.md';s=p.read_text();a=s.index('## レッドストーン鉱石からの医療品');b=s.index('## 固有装備',a);s=s[:a]+'''## レッドストーン鉱石からの医療品

登録済みの通常・深層レッドストーン鉱石を採掘すると、以下から1個ドロップします。

| アイテム | 確率 | 効果 |
|---|---:|---|
| 包帯 | 26% | 従来の即時回復 |
| 救急キット | 2% | 従来の回復 |
| ビール | 14% | 再生I・5秒 |
| ミラノ風ドリア | 14% | 耐性I・5秒 |
| サーモン | 14% | 移動速度上昇I・5秒 |
| 非常食 | 2% | 跳躍力上昇I＋攻撃力上昇I・5秒 |
| ゆずぽん | 14% | 移動速度上昇I・5秒 |
| 小豆 | 14% | 体力増強I・5秒 |

6種類のバフ品は右クリックを1秒間続けて使用。満腹でも使用でき、1回1個消費、64個までスタックできます。空き容器は残りません。新バフ品は採掘報酬のみで、通常チェストへは追加していません。体力増強Iは最大体力を増やす効果で、増えた分を即時回復するものではありません。

'''+s[b:];s=s.replace('0〜4分4%、4〜6分5%、6〜8分6%、8分以降8%','0〜4分6%、4〜6分7.5%、6〜8分9%、8分以降12%').replace('開始時4%・6分補充6%','開始時6%・6分補充9%')
s=s.replace('| ゆうあ | 7.6923% | 0.3077% | 0.4615% |','| ゆうあ | 7.6923% | 0.4615% | 0.6923% |').replace('| 11.5385% | 0.4615% | 0.6923% |','| 11.5385% | 0.6923% | 1.0385% |')
a=s.index('地面への出現は');s=s[:a]+'''地面への出現は開始1〜9分の毎分に配置を試行。1〜3分は3回、4〜5分は3回＋37.5%で1回、6〜7分は3回＋75%で1回、8〜9分は4回＋12.5%で1回。各試行は90%で続行し、上表と同じ重みで抽選。従来の各時間帯に対する期待試行回数は1.5倍です。安全位置が取れない／安置が狭い場合は出ません。
鉱石は60秒で再生成し、実物の石炭・レッドストーンは配布しません。開始時はパン2個と採掘用ツルハシ。固有装備の地面期限は2分、yuにはこの専用期限を適用しません。
''';p.write_text(s)
p=P/'README_JA.md';s=p.read_text().replace('パン6個','パン2個');# Remove accumulated historical lobby section and integrate concise current instructions.
a=s.find('## 新ロビー・展示・アスレチック');
if a!=-1:s=s[:a]
s+='''## ロビー
ロビーは81×81、基準Y−3〜Y+44を使用します。庭園・7人のスキン付き展示・ゲーム案内・短い高低差アスレ4本・BR俯瞰図を配置。ゆーとほちきすはMCID未登録のアイテム展示です。立ち／しゃがみのポーズはバニラのマネキンを利用しています。
既存ロビーの再建は、試合停止中にロビー付近で `/function oa:lobby/upgrade`。登録範囲の追加建築も上書きします。装飾池は設置しません。BRマップの再生成は不要です。俯瞰図は固定画像で、プレイヤー位置・後からの建築変更は反映しません。リソースパック完全版が必要です。
ロビー範囲内の試合参加中でないプレイヤーは落下ダメージ倍率0、耐火・水中呼吸、HP・満腹度の自動回復を受けます。PvPは有効。奈落・窒息など任意の環境ダメージすべてを防ぐものではありません。

## 採掘・バフ消耗品
開始時にパン2個と採掘用ツルハシを配布します。石炭鉱石から食料、レッドストーン鉱石から医療品を採取できます。ビール・ドリア・サーモン・非常食・ゆずぽん・小豆は、右クリックを1秒続けると1個消費し、各5秒のバフが付きます。満腹時も使用可・64個までスタック可。各効果・抽選率はLOOT_JA.mdを参照。同種のバフはバニラのルールで更新され、レベルが加算されることはありません。
管理者の入手テスト：`/function oa:give/buffs` で6種類を各1個入手。個別には `/loot give @s loot oa:br/buffs/beer`（末尾はbeer/doria/salmon/paimon/yuzupon/azuki）。採掘による報酬には試合参加と鉱石登録が必要です。
説明書はこのREADME、WEAPONS_JA.md、LOOT_JA.mdの3つです。実サーバー読み込み・能力・描画・複数人対戦は未検証です。
''';p.write_text(s)
p=P/'WEAPONS_JA.md';s=p.read_text();s+='\nバフ消耗品は固有装備の所持制限に含まれません。種類・効果・採掘率はLOOT_JA.mdを参照。\n';p.write_text(s)
p=RP/'README_JA.md';p.write_text('# OAリソースパック完全版\n\nJava 26.3用。ZIPをresourcepacksに入れ、ゲーム内で有効にします。既存OAリソースパックと入れ替え、重ねて適用しないでください。\n全固有装備・通常バット・ロビーマップに加え、ビール、ミラノ風ドリア、サーモン、パイモンをモチーフにした非常食、ゆずぽん、小豆のピクセルアイテムモデルを含みます。標準モデルを全アイテムへ置換するのではなく、OAデータを持つアイテムだけへ適用します。ゲーム内描画は未検証です。\n')
for base in [P,RP]:
 for p in base.rglob('*'):
  if p.is_file() and p.suffix in ['.json','.mcfunction','.mcmeta','.md']:
   try:s=p.read_text()
   except UnicodeError:continue
   if '1.1.1' in s:p.write_text(s.replace('1.1.1','1.2.0'))
p=P/'pack.mcmeta';v=json.loads(p.read_text());v['pack']['description']='OA バトルロワイヤル 1.2.0 / Java26.3';js(p,v)
p=RP/'pack.mcmeta';v=json.loads(p.read_text());v['pack']['description']='OA Visuals 完全版 1.2.0 / Java26.3';js(p,v)
# Keep one current validation report rather than new documentation files.
p=P/'VALIDATION.json';v=json.loads(p.read_text());v.update({'version':'1.2.0','consumable_effect_ticks':100,'ore_medical_total_weight':100,'consumable_stack_size':64,'starting_bread':2,'rare_spawn_multiplier':1.5});js(p,v)
shutil.copyfile(__file__,P/'source/build_items_1_2.py')
for base,name in [(P,'OA_Weapons_26.3_Prototype.zip'),(RP,'OA_Visuals_26.3_Prototype.zip')]:
 with zipfile.ZipFile(O/name,'w',zipfile.ZIP_DEFLATED) as z:
  for p in base.rglob('*'):
   if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(base))
print('Built version1.2.0, ore weights total',sum(e['weight'] for e in entries))
