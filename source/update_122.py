from pathlib import Path
from PIL import Image
import json,shutil,zipfile,re
R=Path('/workspace/scratch/221a7bbb4169');P=R/'revision/pack';O=R/'release_1_2_2';RP=O/'resourcepack';shutil.copytree(R/'release_1_2_1/resourcepack',RP,dirs_exist_ok=True)
p=RP/'assets/oa/textures/item/br_map.png';Image.open(p).transpose(Image.Transpose.FLIP_TOP_BOTTOM).save(p)
# Rotate item presentation only; leave model UVs and equipped player heads intact.
for name in ['raji','killing']:
 p=RP/f'assets/oa/models/item/{name}.json';v=json.loads(p.read_text())
 for k,d in v['display'].items():
  if k=='head':continue
  rot=d.setdefault('rotation',[0,0,0]);rot[1]=(rot[1]+180)%360
 p.write_text(json.dumps(v,indent=2))
p=P/'data/oa/function/lobby/build.mcfunction';s=p.read_text().replace('BR MAP｜北：山岳・雪／東：森\\n西：市街地／南：海・港','BR MAP｜上：南・海／下：北・山岳\\n左：西・市街地／右：東・森');p.write_text(s)
# A display-only update avoids rebuilding the lobby for this release.
(P/'data/oa/function/lobby/refresh_displays.mcfunction').write_text('execute unless data storage oa:lobby origin{ready:1b} run return run tellraw @s {text:"ロビー未登録です。",color:"red"}\nexecute as @e[type=minecraft:text_display,tag=oa.lobby_label] if data entity @s text{text:"BR MAP｜北：山岳・雪／東：森\\n西：市街地／南：海・港"} run data merge entity @s {text:{text:"BR MAP｜上：南・海／下：北・山岳\\n左：西・市街地／右：東・森",color:"gold"}}\n')
# Name precedence: equipped unique gear > held unique gear > normal held/armor names.
p=P/'data/oa/function/br/ui/item_name.mcfunction';s=p.read_text();prefix=[]
for slot in ['armor.head','armor.chest','armor.legs','armor.feet','weapon.mainhand','weapon.offhand']:
 prefix.append(f'execute if items entity @s {slot} *[minecraft:custom_data~{{oa:{{unique:1b}}}}] run return run function oa:br/ui/read_item {{slot:"{slot}"}}')
p.write_text('\n'.join(prefix)+'\n'+s)
# Trigger exactly once at the same tick that the protection is removed.
p=P/'data/oa/function/br/tick.mcfunction';s=p.read_text();needle='execute if score #time br.time matches 1200 run tag @a[tag=br.playing] remove br.spawn_protection';s=s.replace(needle,needle+'\nexecute if score #time br.time matches 1200 run function oa:br/protection_end');p.write_text(s)
(P/'data/oa/function/br/protection_end.mcfunction').write_text('title @a[tag=br.playing] times 10 50 15\ntitle @a[tag=br.playing] subtitle {text:"ここから戦闘開始！",color:"yellow"}\ntitle @a[tag=br.playing] title {text:"保護期間終了",color:"red",bold:true}\nexecute as @a[tag=br.playing] at @s run playsound minecraft:entity.ender_dragon.growl player @s ~ ~ ~ 0.6 1.2\n')
# Keep the existing shrink-completion bar; warn only in the last ten seconds of waits.
p=P/'data/oa/function/br/bars/tick.mcfunction';s=p.read_text();s+='\n'
for lo,hi in [(2200,2399),(4600,4799),(7000,7199),(10600,10799)]:
 s+=f'execute if score #time br.time matches {lo}..{hi} run function oa:br/bars/pre_shrink\n'
p.write_text(s)
(P/'data/oa/function/br/bars/pre_shrink.mcfunction').write_text('bossbar set oa:zone_timer max 10\nbossbar set oa:zone_timer color yellow\nbossbar set oa:zone_timer visible true\nexecute store result bossbar oa:zone_timer value run scoreboard players get #bar_left br.tmp\nbossbar set oa:zone_timer name [{text:"安置収縮開始まで： ",color:"yellow"},{score:{name:"#bar_left",objective:"br.tmp"}},{text:"秒"}]\n')
# Killing's radar remains available while taking the same actual equipment name.
for fn in ['nearest','render']:
 p=P/f'data/oa/function/curse/radar/{fn}.mcfunction'
 if p.exists():
  s=p.read_text().replace('{text:"キリング | 最寄り：対象なし",color:"light_purple"}','[{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | 最寄り：対象なし",color:"light_purple"}]')
  s=s.replace('{text:"キリング | CT ",color:"light_purple"}','{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | CT ",color:"light_purple"}')
  p.write_text(s)
p=P/'README_JA.md';s=p.read_text().replace('手持ち名・CT・境界距離','固有装備を優先したアイテム名・CT・境界距離').replace('本体のボスバーは保護終了まで／安置収縮完了までを表示。','本体のボスバーは保護終了まで／安置収縮完了までを表示し、待機フェーズの最後の10秒間だけ安置収縮開始までの残り秒数を表示します。保護終了時はタイトルと効果音で通知します。').replace('俯瞰図は固定画像で','俯瞰図は上が南・下が北の固定画像で');s=s.replace('登録範囲の追加建築も上書きします。','登録範囲の追加建築も上書きします。マップ案内の方位文字だけを直す場合は、ロビー付近で `/function oa:lobby/refresh_displays` を実行できます。');p.write_text(s)
for base in [P,RP]:
 for p in base.rglob('*'):
  if p.is_file() and p.suffix in ['.json','.mcmeta','.mcfunction','.md']:
   try:s=p.read_text()
   except UnicodeError:continue
   if '1.2.1' in s:p.write_text(s.replace('1.2.1','1.2.2'))
shutil.copyfile(__file__,P/'source/update_122.py')
# Static boundary simulation of the exact phase windows.
for start in [2400,4800,7200,10800]:
 for t in [start-201,start-200,start-1,start]:
  warning=start-200<=t<start
  if warning:assert 1<=(start-t+19)//20<=10
assert [int((2400-t+19)//20) for t in [2200,2220,2380,2399]]==[10,9,1,1]
for p in P.rglob('*.mcfunction'):
 for l in p.read_text().splitlines():
  if '$(' in l:assert l.startswith('$'),(p,l)
  for ref in re.findall(r'\bfunction (oa:[a-z0-9_/]+)',l):assert (P/'data/oa/function'/(ref.split(':')[1]+'.mcfunction')).exists(),(p,ref)
for base,name in [(P,'OA_Weapons_26.3_Prototype.zip'),(RP,'OA_Visuals_26.3_Prototype.zip')]:
 for p in base.rglob('*.json'):json.loads(p.read_text())
 with zipfile.ZipFile(O/name,'w',zipfile.ZIP_DEFLATED) as z:
  for p in base.rglob('*'):
   if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(base))
 with zipfile.ZipFile(O/name) as z:assert z.testzip() is None
print('Static pass: JSON/macros/function refs, timer boundary cases10..1s, ZIP CRC. No runtime test.')
