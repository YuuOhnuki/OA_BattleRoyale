from pathlib import Path
from collections import deque
import struct,gzip,json,re,zipfile,shutil,itertools
import numpy as np
ROOT=Path(__file__).resolve().parent;P=ROOT/'pack';O=ROOT/'output';F=P/'data/oa_map2/function'
class NBT:
 def __init__(self,b):self.b=b;self.i=0
 def num(self,f):n=struct.calcsize('>'+f);s=self.b[self.i:self.i+n];assert len(s)==n;self.i+=n;return struct.unpack('>'+f,s)[0]
 def txt(self):n=self.num('H');s=self.b[self.i:self.i+n];self.i+=n;return s.decode()
 def val(self,t):
  if t==3:return self.num('i')
  if t==8:return self.txt()
  if t==9:
   st,n=self.num('B'),self.num('i');return [self.val(st) for _ in range(n)]
  if t==10:
   o={}
   while True:
    st=self.num('B')
    if not st:return o
    k=self.txt();o[k]=self.val(st)
  raise ValueError(t)
 def read(self):assert self.num('B')==10;assert self.txt()=='';r=self.val(10);assert self.i==len(self.b);return r
m=json.loads((P/'MAP_MANIFEST.json').read_text());ts=json.loads((ROOT/'tiles.json').read_text());v=np.load(ROOT/'source_voxels.npz')['voxels'];pal=m['palette'];water=next(i for i,b in enumerate(pal) if b['id']=='minecraft:water');chest=next(i for i,b in enumerate(pal) if b['id']=='minecraft:chest');oreids={i for i,b in enumerate(pal) if b['id'] in ['minecraft:coal_ore','minecraft:deepslate_coal_ore','minecraft:redstone_ore','minecraft:deepslate_redstone_ore']}
assert v.shape==(21,305,305) and len(ts)==100
coverage=np.zeros((305,305),dtype='uint8');num=0
for t in ts:
 i=t['tile'];o=NBT(gzip.decompress((P/f'data/oa_map2/structure/tile/{i}.nbt').read_bytes())).read();assert o['DataVersion']==5023;assert o['size']==[t['w'],21,t['d']];assert o['palette']==pal;assert len(o['blocks'])==t['blocks'];num+=len(o['blocks']);seen=set()
 for b in o['blocks']:
  x,y,z=b['pos'];assert 0<=x<t['w'] and 0<=z<t['d'] and 0<=y<21;assert (x,y,z) not in seen;seen.add((x,y,z));state=int(v[y,z+t['z']+152,x+t['x']+152]);assert b['state']==state and state!=water
 assert len(o['blocks'])==int(((v[:,t['z']+152:t['z']+152+t['d'],t['x']+152:t['x']+152+t['w']]!=0)&(v[:,t['z']+152:t['z']+152+t['d'],t['x']+152:t['x']+152+t['w']]!=water)).sum())
 coverage[t['z']+152:t['z']+152+t['d'],t['x']+152:t['x']+152+t['w']]+=1
 apply=(F/f'tiles/apply/{i}.mcfunction').read_text();assert apply.count('run function oa_map2:register/chest')==t['chests'];assert sum(apply.count(f'run function oa_map2:register/ore_{n}') for n in [1,2,3,4])==t['ores']
 for line in apply.splitlines():
  if 'run function oa_map2:register/' not in line:continue
  assert re.match(r'execute positioned ~-?\d+ ~-?\d+ ~-?\d+ if block ',line)
  assert 'align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker' in line
 assert t['w']*t['d']*21<=32768
 # Independently replay direct placement commands and compare every voxel.
 replay=np.zeros((21,t['d'],t['w']),dtype=v.dtype)
 place=(F/f'tiles/place/{i}.mcfunction').read_text()
 assert 'place template' not in place
 for line in place.splitlines():
  if not line.startswith('fill '):continue
  parts=line.split();xyz=[int(s[1:]) for s in parts[1:7]];x0,y0,z0,x1,y1,z1=xyz
  block=parts[7];name=block.split('[')[0];props={}
  if '[' in block:props=dict(p.split('=') for p in block.split('[',1)[1][:-1].split(','))
  state=next(j for j,e in enumerate(pal) if e['id']==name and e.get('properties',{})==props)
  assert x1-x0<32 and z1-z0<32
  replay[y0+20:y1+21,z0-t['z']:z1-t['z']+1,x0-t['x']:x1-t['x']+1]=state
 expected=v[:,t['z']+152:t['z']+152+t['d'],t['x']+152:t['x']+152+t['w']].copy();expected[expected==water]=0
 assert np.array_equal(replay,expected),(i,'direct placement mismatch')
assert np.all(coverage==1) and num==m['blocks'];assert sum(t['chests'] for t in ts)==m['chests'];assert sum(t['ores'] for t in ts)==m['ore_nodes']
# A macro can format an integral double as an integer, causing positioned to
# center X/Z at .5. Block placement floors integer offsets; registration uses
# centered offsets. Align before both paths to eliminate this disagreement.
import math
for phase in ['next','wait','release']:
 assert 'positioned $(x) $(y) $(z) align xyz run function' in (F/f'job/dispatch_{phase}.mcfunction').read_text()
old_mismatch=0
for anchor in [-16.5,-.5,0.,.5,16.5]:
 for x,y,z,*_ in m['chest_locations']+m['ore_locations']:
  old_mismatch+=math.floor(anchor+x)!=math.floor(anchor+x+.5)
  assert math.floor(math.floor(anchor)+x)==math.floor(math.floor(anchor)+x+.5)
  assert math.floor(math.floor(anchor)+z)==math.floor(math.floor(anchor)+z+.5)
assert old_mismatch>0
for x,y,z,k in m['chest_locations']:assert v[y+20,z+152,x+152]==chest and v[y+21,z+152,x+152]==0
for x,y,z,t,reg in m['ore_locations']:assert int(v[y+20,z+152,x+152]) in oreids
assert not np.any(v[:,:,0]==water) and not np.any(v[:,:,-1]==water) and not np.any(v[:,0,:]==water) and not np.any(v[:,-1,:]==water)
# 2-air-block standing grid. Water is excluded as support. Swimming is not modeled.
vp=np.pad(v,((0,3),(0,0),(0,0)));solid=(vp!=0)&(vp!=water);empty=vp==0;stand=solid[:-2]&empty[1:-1]&empty[2:];reach=np.zeros(stand.shape,bool);q=deque([(9,152,152)]);reach[9,152,152]=True
while q:
 y,z,x=q.popleft()
 for dz,dx in [(1,0),(-1,0),(0,1),(0,-1)]:
  nz,nx=z+dz,x+dx
  if not(0<=nz<305 and 0<=nx<305):continue
  for dy in [0,1,-1,-2,-3]:
   ny=y+dy
   if 0<=ny<stand.shape[0] and stand[ny,nz,nx]:
    if not reach[ny,nz,nx]:reach[ny,nz,nx]=True;q.append((ny,nz,nx))
    break
def near(x,y,z):return any(reach[yy+20,z+152+dz,x+152+dx] for dz,dx in [(1,0),(-1,0),(0,1),(0,-1)] for yy in range(y-3,y+1) if 0<=yy+20<reach.shape[0] and 0<=z+152+dz<305 and 0<=x+152+dx<305)
badc=[o for o in m['chest_locations'] if not near(o[0],o[1],o[2])];bado=[o for o in m['ore_locations'] if not near(o[0],o[1],o[2])]
print('Unreachable chests:',badc,'ores:',bado,flush=True)
(ROOT/'reachability.json').write_text(json.dumps({'chests':badc,'ores':bado},indent=2))
assert not badc and not bado
for name,point in m['ship'].items():
 if name=='bounds':continue
 x,feet,z=point;assert reach[feet-1+20,z+152,x+152],('ship access',name,point)
for x,z,y,top in m['solid_buildings']:
 assert top<=0 and top-y>=10
 body=v[y+21:top+21,z+148:z+157,x+148:x+157]
 assert np.all(body!=0) and np.all(body!=water),('building interior',x,z)
# Sample nine distributed shoreline exits: one-block wading depth beside a
# sand step at water level, with two free head blocks. Fluid motion not modeled.
shore_exits=[]
for x in [-140,-110,-60,-30,0,30,80,110,140]:
 rows=[z for z in range(70,112) if v[6,z+152,x+152]==water]
 assert rows,('missing shore',x)
 z=min(rows);assert pal[int(v[5,z+152,x+152])]['id']=='minecraft:sand'
 assert pal[int(v[6,z-1+152,x+152])]['id']=='minecraft:sand'
 assert np.all(v[7:9,z-1+152,x+152]==0)
 shore_exits.append([x,z])
oak=next(i for i,b in enumerate(pal) if b['id']=='minecraft:oak_log')
tall_oak_columns=int(((v[:,63:230,194:295]==oak).sum(axis=0)>=7).sum())
assert tall_oak_columns>=100,tall_oak_columns
# Force-load acquisition preserves existing chunks, including interior chunks of 32-block tiles.
for ax,az in itertools.product(range(16),repeat=2):
 for t in [ts[0],ts[-1]]:
  pts=[((ax+x)//16,(az+z)//16) for x,z in t['force_points']];touched=set(pts);expected={(x,z) for x in range((ax+t['x'])//16,(ax+t['x']+t['w']-1)//16+1) for z in range((az+t['z'])//16,(az+t['z']+t['d']-1)//16+1)};assert touched==expected
  existing={next(iter(touched))};flags=[p in existing for p in pts];held=touched|existing
  for point,had in zip(pts,flags):
   if not had:held.discard(point)
  assert held==existing and len(touched)<=9
for q in P.rglob('*.json'):json.loads(q.read_text())
for q in (P/'data').rglob('*.mcfunction'):
 for l in q.read_text().splitlines():
  if '$(' in l:assert l.startswith('$'),q
  if 'tellraw' in l:continue
  assert ' aligned ' not in l
  for a in re.finditer(r'\bfunction (oa_map2?:[^\s]+)',l):
   ns,ref=a.group(1).split(':',1)
   if '$(' not in ref:assert (P/f'data/{ns}/function/{ref}.mcfunction').exists(),(q,ref)
for n in [1,2,3,4]:assert f'if score @s br.ore matches {n}' in (F/f'register/ore_{n}.mcfunction').read_text()
water_tiles=sum(t['water_commands']>0 for t in ts)
readme=f'''# OA BR 305×305 四地方マップ v2.2.0 / Java26.3

## v2.2.0 変更
西の空き区画に入れない高層の建物を追加し、平地にも短い遮蔽物を追加。東の木は幹8〜10ブロックを基準に上端Yまで伸ばし、低木を追加。海岸は岸側3ブロック程度を浅瀬とし、砂地へ1段ずつ上がる地形に変更。桟橋の東に幅15・長さ37ブロックの船を追加。船内は下層客室・貨物と上部船室、甲板、帆、乗船用通路と下層への階段があり、チェストを2個配置（全体48個は維持）。
旧マップからは `/function oa_map:rebuild` で全体再生成。上端Yの制限は維持しています。以前の建物・チェスト内容は上書きされます。

## v2.1.0 変更
民家21軒、チェスト48個へ削減。中央は8本の柱と曲線の骨組みで開放ドームに変更。床にシーランタンのOA文字。既存マップへ反映する場合は試合停止後、観戦モードで `/function oa_map:rebuild`。保存済み中心・Yを使用して全域を上書きします。停止中の旧版からもrebuildを使って区画0から再作成してください。register_allだけでは建物・チェスト数は変更しません。

## v2.0.2 修正
配置・読み込み・解除の実行基準にalign xyzを追加。マクロにより整数表記された座標がX/Zの中央（+0.5）として解釈される場合に、半ブロック中心の登録座標が隣のブロックを参照する問題を修正。正負の原点と全登録地点を使った座標計算の回帰検証を追加。

## v2.0.1 修正
区画0での停止報告に対応し、ゲーム内配置を構造物テンプレートから水平列をまとめたfill命令へ変更。停止時は処理段階とチェスト・鉱石の登録数/予定数を表示します。旧版で停止中ならZIP交換→reload→oa_map:resumeで同じ区画を再試行します。startで新規生成し直す必要はありません。ログだけでは旧版の内部失敗理由は確定できていません。

## 導入ファイル
- OA_Weapons_26.3_Prototype.zip：BR本体v0.13.5。開始ボーダー305、初期配置±130、縮小305→230→160→90→20。武器・6分補充などは維持。
- OA_BR_Map_305x305_26.3.zip：この生成パック。旧500版は外してから入れてください。
MOD・プラグイン・追加リソースパック不要。2つとも同じワールドのdatapacksへ入れます。

## 座標・Y範囲
「中心地点からY−20以内」は、本版では**指定した足元Yを上端とし、建物・木・海底も含めてY−20〜Yに収める**方式です。X/Zは中心から−152〜+149の305×305。中央地面は指定Y−11、BR中心の足元は指定Y−10。北の高い地面は最大で指定Y−1、塔の上端は指定Yです。
例：中心をX0/Z0、上端Y80にしたい場合は、観戦モードで `/tp @s 0 80 0` してstart。中央地面Y69、立つ位置Y70、海面Y66、海底は最深Y61、基礎はY60です。ブロックを作成・削除する範囲はY60〜80に限定します。バイオーム設定だけは雪の判定がジャンプ中も続くよう、指定Y−20〜Y+8に設定します（バイオームは4ブロック単位）。

## 生成手順（OP／チートON）
1. **新規スーパーフラットワールドを推奨。生成範囲の既存ブロックは上書きされ、元には戻せません。** 通常ワールドや旧500版の建物を消す場合、上記Y範囲より上・下は残ります。旧マップを丸ごと消す処理はありません。
2. 旧500版生成ZIPと旧BR本体ZIPを外し、本版の2つへ交換して `/reload`。
3. `/function oa:br/stop` で試合停止を確認。
4. `/gamemode spectator` → `/tp @s 0 80 0` → `/function oa_map:start`。
5. 「完了！登録成功 チェスト{m['chests']}個 / 鉱石{m['ore_nodes']}個」まで待ちます。地形100区画の後、必要な{water_tiles}区画だけ海水・井戸の水を入れます。
6. この座標例では `/tp @s 0 70 0` で中央へ戻り、必要なら `/gamemode creative`。
導入・reloadだけでは地形やモードを変更しません。startで明示的に生成を開始します。地形の自動バックアップはありません。

## 停止・再開・登録
- `/function oa_map:status`：状態、区画数、登録成功件数。
- `/function oa_map:pause`：一時停止。`/function oa_map:resume`：停止地点から再開。
- `/function oa_map:register_all`：完成済みマップのチェスト・鉱石の登録だけを全区画で再構築。地形・水・チェスト内容は上書きしません。
登録は実際のchest／鉱石ブロックを確認し、`execute summon`で作成したマーカー本人へタグとスコアを設定します。既存マーカーを区画内で除いてから登録するので重複を防止。鉱石の種類スコア・再生成タイマー、チェストの試合スコアも確認してから成功数を加算します。区画の予定件数と一致しない場合は停止し、成功扱いにしません。
register_allでは、本マップの範囲内にあるbr.chest/br.oreマーカーを設計データに従って作り直します。手動で追加した鉱石・チェストの登録は再度行ってください。ブロックを別のものに編集している場合は予定数と合わず停止します。
生成時には通常の前半ルートテーブルでチェストにも中身を入れます。試合開始時はBR本体が改めて全廃棄・補充し、6分で強化補充します。採掘の専用報酬・60秒再生成は**試合中に支給ツルハシで**確認してください。待機中には動きません。
生成・登録途中はBR本体の試合開始を拒否します。再起動・reload時の状態保持に対応した制御ですが、実サーバーでの中断再開テストは未実施です。

## 地域と配置
| 方角 | 内容 |
|---|---|
| 北 | 岩山・尾根・採掘跡。さらに北は雪原バイオーム、雪・氷の地面。北の露出鉱石72個 |
| 南 | 海・波形の砂浜・桟橋・木造の小船・港の集落。小さな沿道鉱石4個だけ |
| 東 | 木が多い森林と小遺跡3か所。石の壁や柱、探索チェスト |
| 西 | 家の多い町・市場・井戸・街路・港の集落 |
| 中央 | 環状石畳・花壇・街灯・8本柱の開放ドーム・床のOA文字 |
民家は計21軒に加えて内部へ入れないビル{len(m['solid_buildings'])}棟、木{m['trees']}本、チェスト{m['chests']}個（旧80個）。鉱石は計{m['ore_nodes']}個。地方別件数はMAP_MANIFEST.jsonに記載。鉱石の隆起物ごとに石炭系かレッドストーン系のどちらか一種類だけを配置しています。北西寄りは石炭、北東寄りは赤石が中心です。
中央ドームは8本の柱・曲線の梁・外周リングのみで、面としての屋根や壁はありません。床のOA文字はシーランタン製です。
北端では降水時に雪になります。天候が晴れでも、試合参加者には雪原バイオーム内で雪の粒子を少量表示します。世界全体の天気は変更しません。粒子演出を使う場合は生成パックも有効にしておきます。実際の天候・バイオーム境界はゲーム内で要確認です。

## 高速化と負荷
本体配置100区画＋水を含む区画だけの仕上げ。旧版の1024区画に比べ、区画数と作成範囲を削減し、待機を短縮しました。1区画32×32×21（最大21504ブロック）で標準のfill制限内。一度に全マップを強制読み込みせず、必要な最大9チャンクだけを読み込みます。既に他の目的で強制読み込みされているチャンクは解除しない設計です。
水は全地形の後に入れ、海の外縁に砂の保持壁を置きます。途中で水が未生成の外側や基礎より下へ流れ出すのを避けます。所要時間・TPSは未計測で、速度の倍率は保証していません。重い場合はpauseし、他の処理を止めてからresumeしてください。

## BR開始
完成時に中心を自動設定します。新規ワールドの標準ボーダーなら `/function oa:br/border/setup {{x:0,z:0,damage:0.2}}` を初回に実行。各自 `/function oa:br/join`、管理者 `/function oa:br/start_solo` または `/function oa:br/start_team`。チーム羊毛・ロビーの自動設置はありません。
開始305×305を2分維持、2〜3分305→230、4〜5分230→160、6〜7分160→90、9〜10分90→20。サイドバー・距離表示・エリアダメージ・初期ランダム配置も305版です。6分のチェスト更新は維持。

## 検証
全JSON・100個のNBTを独立した読込処理で検証。500版の旧形式を流用せず、26.3のDataVersion5023とid/propertiesパレットを使用。全90000列が1回ずつ生成範囲に入ること、全ブロックが指定Y−20〜Y内、各ブロック状態と元データの一致、チェスト{m['chests']}・鉱石{m['ore_nodes']}の配置／登録コード／成功数検査を確認。水の外縁・基礎、強制読み込み所有権、内部関数参照・マクロ、ZIP CRCを静的確認。
中央からチェスト・鉱石の隣への到達を、頭上2ブロック・1段上昇/3段下降の簡易格子モデルで確認。泳ぎ・プレイヤーの当たり判定等は含まない、実機とは別の確認です。
**サーバー読み込み：未実施。プレイヤー操作・登録実動作・通行・着火・対戦・雪・負荷：未検証。** サーバーデバッグをユーザー側で行う方針のため起動していません。まず新規テストワールドで生成してください。

## ソースと制約
data配下にmcfunction・構造物、source配下にbuild.py、validate.py、元ボクセルデータを同梱。再生成はPython3とnumpy/Pillowが必要（ゲーム内では不要）。MAP_MANIFEST.jsonに全位置一覧、MAP_OVERVIEW.pngは実データからの俯瞰図で、実機スクリーンショットではありません。
元の500版の外側や指定Y範囲外、既存エンティティは消しません。バイオームはブロックの作成範囲とは別に4ブロック解像度で設定されます。火災・自然な積雪・プレイヤーによる後の変更の自動修復はありません。
形式確認元：https://www.minecraft.net/en-us/article/minecraft-java-edition-26-3 および公式26.3のversion.json・構造物形式。海や雪の表現はバニラのブロックとバイオーム、軽量な雪粒子で作成しています。
'''
(P/'README_JA.md').write_text(readme);shutil.copyfile(P/'README_JA.md',O/'OA_BR_Map_README_JA.md')
src=P/'source';src.mkdir(exist_ok=True)
for name in ['build.py','validate.py','source_voxels.npz','tiles.json']:shutil.copyfile(ROOT/name,src/name)
report={'version':'1.6.0','size':[305,305],'y_range':[-20,0],'nbt_readback':100,'direct_fill_replay':'all 100 tiles match source voxels','registration_alignment_regression':'pass for 5 anchors and all locations; old mismatch reproduced','solid_block_records_checked':num,'water_tiles':water_tiles,'solid_buildings':len(m['solid_buildings']),'ship_access_model':'boarding/lower deck/cabin reachable','shoreline_exit_samples':shore_exits,'oak_columns_with_7_or_more_logs':tall_oak_columns,'exact_coverage':'pass','force_load_ownership':'pass for 16x16 possible origin alignments','registered_records':{'chests':m['chests'],'ores':m['ore_nodes'],'conditional_self_initialization':'static checked; runtime not tested'},'ore_regions':m['ore_by_region'],'chests_unreachable_in_model':badc,'ores_unreachable_in_model':bado,'json_refs_macros':'pass','server_load':'not tested','player_tests':'not tested','multiplayer_tests':'not tested'}
(P/'VALIDATION.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n');(O/'OA_BR_Map_VALIDATION.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
with zipfile.ZipFile(O/'OA_BR_Map_305x305_26.3.zip','w',zipfile.ZIP_DEFLATED) as z:
 for q in sorted(P.rglob('*')):
  if q.is_file():z.write(q,q.relative_to(P))
with zipfile.ZipFile(O/'OA_BR_Map_305x305_26.3.zip') as z:assert z.testzip() is None
# Repack the revised BR source including its guard against starting during map generation.
base=ROOT.parent/'revision/pack';dest=ROOT.parent/'revision/update_0130_output'
with zipfile.ZipFile(dest/'OA_Weapons_26.3_Prototype.zip','w',zipfile.ZIP_DEFLATED) as z:
 for q in sorted(base.rglob('*')):
  if q.is_file():z.write(q,q.relative_to(base))
with zipfile.ZipFile(dest/'OA_Weapons_26.3_Prototype.zip') as z:assert z.testzip() is None
print(json.dumps(report,ensure_ascii=False),flush=True)
