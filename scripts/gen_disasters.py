"""災害の定義（1か所）から、抽選・予告・進行・終了・表示の関数を生成する（1.9.212〜）。

正本はこのファイルの DISASTERS。災害を足すときは、ここに1行足し、data/oa/function/disaster/k<N>/ に
start（任意）・second（必須）・end（任意）を書いて、このスクリプトを実行する。
  py -3 scripts/gen_disasters.py
抽選の重み・有効/無効・発生間隔・同時発生の確率・継続ダメージの上限は、ストレージ oa:disaster cfg で変えられる
（初期値は disaster/cfg_defaults。ゲーム内で data modify storage oa:disaster cfg.weight.k7 set value 0 など）。
"""
from pathlib import Path
import json

R = Path(__file__).resolve().parents[1]
F = R / 'data/oa/function/disaster'
STARS = lambda n: '★' * n + '☆' * (5 - n)
MAPS = {0: 'br', 1: 'nether', 2: 'cave', 3: 'sky', 4: 'end'}

# kind, key, 表示名（マップ別に上書き可）, 色, 危険度, 秒, 重み, 出るマップ, 説明（マップ別に上書き可）, 移動系, 敵味方の印
DISASTERS = [
    dict(k=1, key='acid_rain', name='酸性雨', color='green', danger=4, sec=30, weight=10, maps=[0],
         desc='屋根の下か頭の防具で防げる'),
    dict(k=2, key='cold_wave', name='寒波', color='aqua', danger=4, sec=30, weight=10, maps=[0],
         desc='屋根の下か革の胸当てで防げる'),
    dict(k=3, key='meteor', name='隕石群', names={1: '火山弾', 2: '落盤'}, color='red', danger=5, sec=24, weight=10, maps=[0, 1, 2, 3, 4],
         desc='赤い円から離れるか屋根の下へ', descs={2: '赤い円から離れよう'}),
    dict(k=4, key='poison_fog', name='毒霧', names={1: '毒の瘴気'}, color='dark_green', danger=4, sec=40, weight=10, maps=[0, 1, 2, 3, 4],
         desc='中心から広がる。外へ逃げよう'),
    dict(k=5, key='earthquake', name='地震', color='gold', danger=3, sec=10, weight=10, maps=[0, 1, 2, 3, 4],
         desc='動くとダメージ。止まって耐えよう'),
    dict(k=6, key='fog', name='濃霧', names={1: '灰嵐'}, color='gray', danger=2, sec=30, weight=10, maps=[0, 1, 2, 3, 4],
         desc='視界が狭くなる'),
    dict(k=7, key='gravity', name='重力異常', color='light_purple', danger=2, sec=20, weight=7, maps=[0, 1, 2, 3, 4], move=True,
         desc='高く跳べる。落下ダメージなし'),
    dict(k=8, key='chickens', name='ニワトリ大量発生', color='yellow', danger=1, sec=20, weight=7, maps=[0, 1, 2, 3, 4], mobs=True,
         desc='卵に当たると押し飛ばされる'),
    dict(k=9, key='blood_moon', name='血の月', color='dark_red', danger=2, sec=30, weight=7, maps=[0, 1, 2, 3, 4],
         desc='全員が光り、居場所が丸見え'),
    dict(k=10, key='tornado', name='竜巻', color='white', danger=4, sec=30, weight=7, maps=[0, 1], move=True,
         desc='吸い寄せられて打ち上げられる'),
    dict(k=11, key='pig_parade', name='ブタの大行進', color='light_purple', danger=3, sec=15, weight=7, maps=[0, 1, 2, 3, 4], mobs=True,
         desc='ブタが爆発しながら走り回る'),
    dict(k=12, key='tower_barrage', name='塔の砲撃', color='dark_purple', danger=4, sec=45, weight=8, maps=[4],
         desc='紫の線が出たら横へ動くか物陰へ'),
    # 1.9.266：マップ固有の災害（動き・地形の変化はプラグイン disaster/MapDisasters。#dsN の残り秒が合図）。
    # 壊した地形はプラグイン disaster/TerrainLog が記録し、試合の終わりに元へ戻す
    dict(k=13, key='giant_meteor', name='巨大隕石', color='red', danger=5, sec=20, weight=8, maps=[0],
         desc='赤い円の中から逃げよう。地面がえぐれる'),
    dict(k=14, key='eruption', name='噴火', color='gold', danger=4, sec=30, weight=8, maps=[1],
         desc='火口から離れよう。火山弾と溶岩に注意'),
    dict(k=15, key='sculk_wake', name='スカルクの目覚め', color='dark_aqua', danger=3, sec=40, weight=8, maps=[2],
         desc='走る・跳ぶ・戦うと居場所がばれる。しゃがんで静かに'),
    dict(k=16, key='island_collapse', name='島の崩落', color='aqua', danger=4, sec=40, weight=7, maps=[3],
         desc='外側の島から崩れる。中央へ移動しよう'),
    dict(k=17, key='void_erosion', name='虚空の侵食', color='dark_purple', danger=4, sec=40, weight=7, maps=[4],
         desc='紫の渦の場所に穴が開く。渦から離れよう'),
    dict(k=18, key='ender_dragon', name='エンダードラゴン', color='light_purple', danger=3, sec=40, weight=7, maps=[4],
         desc='ドラゴンが地形を壊して飛び回る。足場に注意'),
]
CFG = {'cd_min': 50, 'cd_max': 75, 'first_min': 30, 'first_max': 45, 'multi2': 20, 'multi3': 5,
       'dot_cap': 4, 'mob_cap': 90, 'chicken_cap': 60, 'pig_cap': 30, 'chicken_population_v':240,
       'weight': {f"k{d['k']}": d['weight'] for d in DISASTERS}}
KINDS = [d['k'] for d in DISASTERS]
dump = lambda x: json.dumps(x, ensure_ascii=False, separators=(',', ':'))


def write(rel, lines):
    p = F / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text('\n'.join(lines) + '\n', encoding='utf-8', newline='\n')


def name_variants(d):
    """[(map条件, 名前, 説明)]。map条件は None（既定）か mapid。"""
    out = []
    for m in (0, 1, 2, 3, 4):
        out.append((m, d.get('names', {}).get(m, d['name']), d.get('descs', {}).get(m, d['desc'])))
    return out


HEAD = '# 生成：scripts/gen_disasters.py（直接編集しない）'

# 初期設定（無ければ入れる。変えた値は残す）
write('cfg_defaults.mcfunction', [HEAD,
    '# 初回は全設定、既存設定には今回変更した間隔だけを移行。重み・安全上限などの個別設定は残す。',
    f'execute unless data storage oa:disaster cfg run data modify storage oa:disaster cfg set value {dump(dict(CFG, v=214))}',
    'execute unless data storage oa:disaster cfg{v:214} run function oa:disaster/cfg_migrate214',
    'execute unless data storage oa:disaster cfg{chicken_population_v:240} run function oa:disaster/cfg_chickens240',
    # 1.9.232: あとから足した災害の重み（既存の設定に無ければ初期値を入れる）
    *[f'execute unless data storage oa:disaster cfg.weight.k{d["k"]} run data modify storage oa:disaster cfg.weight.k{d["k"]} set value {d["weight"]}' for d in DISASTERS],
    f'data modify storage oa:disaster defs set value {dump({"k%d" % d["k"]: {"key": d["key"], "name": d["name"], "danger": d["danger"], "stars": STARS(d["danger"]), "sec": d["sec"], "desc": d["desc"], "maps": d["maps"]} for d in DISASTERS})}'])
write('cfg_migrate214.mcfunction', [HEAD] +
      [f'data modify storage oa:disaster cfg.{key} set value {CFG[key]}' for key in ('cd_min', 'cd_max', 'first_min', 'first_max')] +
      ['data modify storage oa:disaster cfg.v set value 214'])
write('cfg_chickens240.mcfunction',[HEAD,
    'execute if data storage oa:disaster cfg{chicken_cap:40} run data modify storage oa:disaster cfg.chicken_cap set value 60',
    'execute if data storage oa:disaster cfg{mob_cap:60} run data modify storage oa:disaster cfg.mob_cap set value 90',
    'data modify storage oa:disaster cfg.chicken_population_v set value 240'])

# マップごとに出る災害（#avN）
lines = [HEAD, '# 今のマップで起こる災害を #avN br.tmp に1／0で入れる（定義の maps）']
for d in DISASTERS:
    lines.append(f'scoreboard players set #av{d["k"]} br.tmp 0')
    for m in d['maps']:
        lines.append(f'execute if score #map oa.mapid matches {m} run scoreboard players set #av{d["k"]} br.tmp 1')
write('available.mcfunction', lines)

# 災害コンボ：このマップで起こる災害をすべて予定に（今起きている物は除く）
write('combo/plan_all.mcfunction', [HEAD] + [f'execute if score #av{k} br.tmp matches 1 unless score #ds{k} br.tmp matches 1.. run scoreboard players set #p{k} br.tmp 1' for k in KINDS])

# 1つ選ぶ（重み付き・重複なし・今起きている物を除く。#avoid_last=1 なら前回の物も除く）
lines = [HEAD, '# 重み付きで1つ選び #pN=1 にする（cfg.weight.kN。0なら出ない）。選べなければ #picked=0',
         'scoreboard players set #picked br.tmp 0', 'scoreboard players set #wt br.tmp 0']
for k in KINDS:
    lines += [f'scoreboard players set #w{k} br.tmp 0',
              f'execute if score #av{k} br.tmp matches 1 unless score #p{k} br.tmp matches 1 unless score #ds{k} br.tmp matches 1.. store result score #w{k} br.tmp run data get storage oa:disaster cfg.weight.k{k}',
              f'execute if score #avoid_last br.tmp matches 1 if score #last{k} br.tmp matches 1 run scoreboard players set #w{k} br.tmp 0',
              f'execute if score #w{k} br.tmp matches ..-1 run scoreboard players set #w{k} br.tmp 0',
              f'scoreboard players operation #wt br.tmp += #w{k} br.tmp']
lines += ['execute if score #wt br.tmp matches ..0 run return 0',
          'execute store result score #r br.tmp run random value 0..1000000',
          'scoreboard players operation #r br.tmp %= #wt br.tmp',
          'scoreboard players add #r br.tmp 1']
for k in KINDS:
    lines += [f'scoreboard players operation #r br.tmp -= #w{k} br.tmp',
              f'execute if score #r br.tmp matches ..0 run scoreboard players set #p{k} br.tmp 1',
              f'execute if score #r br.tmp matches ..0 run return run scoreboard players set #picked br.tmp 1']
write('pick.mcfunction', lines)

# 予定を空にする
write('plan_clear.mcfunction', [HEAD] + [f'scoreboard players set #p{k} br.tmp 0' for k in KINDS] + ['scoreboard players set #plan_n br.tmp 0'])

# 予告の表示（個数にかかわらず災害ごとの同じチャット形式）
lines = [HEAD, '# 単発・複数・全同時とも同じチャット形式。タイトルは共通の「⚠ 災害発生」だけ（1.9.240）。',
         'scoreboard players set #plan_n br.tmp 0']
lines += [f'execute if score #p{k} br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1' for k in KINDS]
lines += ['execute if score #plan_n br.tmp matches 0 run return 0']
# 1.9.240：タイトルは災害の数・種類によらず同じ「⚠ 災害発生」だけ（中身はチャット）。単発・複数・災害コンボで共通
lines += ['title @a[tag=br.playing] times 10 50 15',
          'title @a[tag=br.playing] subtitle {"text":"内容はチャットを確認","color":"gray"}',
          'title @a[tag=br.playing] title {"text":"⚠ 災害発生","color":"dark_red","bold":true}']
for d in DISASTERS:
    for m, nm, ds in name_variants(d):
        cond = f'execute if score #p{d["k"]} br.tmp matches 1 if score #map oa.mapid matches {m}'
        lines.append(f'{cond} run tellraw @a[tag=br.playing] {dump([{"text":"⚠ ","color":"red","bold":True},{"text":nm,"bold":True},{"text":"  "+STARS(d["danger"])},{"text":"\n    "+ds,"color":"gray"}])}')
write('announce.mcfunction', lines)

# 予定の災害を始める（それぞれの残り秒 #dsN を定義の秒に）
lines = [HEAD, '# 予定（#pN=1）の災害を一斉に始める。今起きている同じ災害には重ねない', 'function oa:disaster/last_clear']
for d in DISASTERS:
    k = d['k']
    lines.append(f'execute if score #p{k} br.tmp matches 1 unless score #ds{k} br.tmp matches 1.. run function oa:disaster/go/k{k}')
lines.append('function oa:disaster/plan_clear')
write('start_planned.mcfunction', lines)

for d in DISASTERS:
    k = d['k']
    has_start = (F / f'k{k}/start.mcfunction').exists()
    has_end = (F / f'k{k}/end.mcfunction').exists()
    go = [HEAD, f'# {d["name"]}を始める（{d["sec"]}秒・危険度{d["danger"]}）']
    if has_start:
        go.append(f'function oa:disaster/k{k}/start')
    go += [f'scoreboard players set #ds{k} br.tmp {d["sec"]}', f'scoreboard players set #dmax{k} br.tmp {d["sec"]}',
           f'scoreboard players set #last{k} br.tmp 1']
    write(f'go/k{k}.mcfunction', go)
    write(f'run/k{k}.mcfunction', [HEAD, f'# {d["name"]}の1秒。#dis_left を一時的にこの災害の残り秒にして k{k}/second を呼ぶ',
        f'scoreboard players operation #dis_left br.tmp = #ds{k} br.tmp', 'scoreboard players remove #dis_left br.tmp 1',
        f'function oa:disaster/k{k}/second', f'scoreboard players operation #ds{k} br.tmp = #dis_left br.tmp',
        f'execute if score #ds{k} br.tmp matches ..0 run function oa:disaster/stop/k{k}'])
    stop = [HEAD, f'# {d["name"]}の終わり（ほかの災害の効果には触れない）']
    if has_end:
        stop.append(f'function oa:disaster/k{k}/end')
    stop += [f'scoreboard players set #ds{k} br.tmp 0']
    for m, nm, ds in name_variants(d):
        if m in d['maps']:
            stop.append(f'execute if score #map oa.mapid matches {m} run tellraw @a[tag=br.playing] {dump([{"text":"✔ ","color":"green"},{"text":nm},{"text":" が収まった"}])}')
    write(f'stop/k{k}.mcfunction', stop)
    # 片付け（試合の終わり・中止。予告を出さずに止める）
    write(f'halt/k{k}.mcfunction', [HEAD] + ([f'execute if score #ds{k} br.tmp matches 1.. run function oa:disaster/k{k}/end'] if has_end else []) + [f'scoreboard players set #ds{k} br.tmp 0'])

# 1秒ごとに全部の起きている災害を進める
lines = [HEAD, '# 起きている災害（#dsN≥1）をそれぞれ1秒進める。#dis_active＝数、#dis_kind＝一番小さい番号（互換）',
         'scoreboard players set @a br.ddmg 0']
lines += [f'execute if score #ds{k} br.tmp matches 1.. run function oa:disaster/run/k{k}' for k in KINDS]
lines += ['function oa:disaster/count']
write('run_all.mcfunction', lines)
lines = [HEAD, 'scoreboard players set #dis_active br.tmp 0', 'scoreboard players set #dis_kind br.tmp 0']
lines += [f'execute if score #ds{k} br.tmp matches 1.. run scoreboard players add #dis_active br.tmp 1' for k in KINDS]
lines += [f'execute if score #dis_kind br.tmp matches 0 if score #ds{k} br.tmp matches 1.. run scoreboard players set #dis_kind br.tmp {k}' for k in KINDS]
write('count.mcfunction', lines)
write('halt_all.mcfunction', [HEAD] + [f'function oa:disaster/halt/k{k}' for k in KINDS] + ['function oa:disaster/plan_clear', 'function oa:disaster/count'])
write('last_clear.mcfunction', [HEAD] + [f'scoreboard players set #last{k} br.tmp 0' for k in KINDS])

# ボスバー：起きている災害と残り秒（アクションバーの武器・CT表示は消さない）
lines = [HEAD, '# 災害のボスバー（oa:disaster）。起きている災害の名前・危険度・残り秒をまとめて出す',
         'execute if score #dis_active br.tmp matches 0 run return run bossbar set oa:disaster visible false',
         'data modify storage oa:disaster bar set value []']
for d in DISASTERS:
    k = d['k']
    for m, nm, ds in name_variants(d):
        if m not in d['maps']:
            continue
        lines.append(f'execute if score #ds{k} br.tmp matches 1.. if score #map oa.mapid matches {m} run data modify storage oa:disaster bar append value {dump({"text":nm+" "+STARS(d["danger"])+" ","color":d["color"]})}')
        lines.append(f'execute if score #ds{k} br.tmp matches 1.. if score #map oa.mapid matches {m} run data modify storage oa:disaster bar append value {dump({"score":{"name":"#ds"+str(k),"objective":"br.tmp"},"color":"white"})}')
        lines.append(f'execute if score #ds{k} br.tmp matches 1.. if score #map oa.mapid matches {m} run data modify storage oa:disaster bar append value {{"text":"秒　","color":"white"}}')
lines += ['execute if score #dis_active br.tmp matches ..3 run bossbar set oa:disaster name [{"text":"⚠ ","color":"red","bold":true},{"nbt":"bar[]","storage":"oa:disaster","interpret":true,"separator":""}]',
          # 4種類以上（災害コンボなど）は長くなるので数だけ。内容はチャットの予告で確認
          'execute if score #dis_active br.tmp matches 4.. run bossbar set oa:disaster name [{"text":"⚠ 災害が同時に ","color":"red","bold":true},{"score":{"name":"#dis_active","objective":"br.tmp"},"color":"white","bold":true},{"text":" 種類","color":"red","bold":true}]',
          'scoreboard players set #bar_max br.tmp 1', 'scoreboard players set #bar_v br.tmp 0']
for k in KINDS:
    lines.append(f'execute if score #ds{k} br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax{k} br.tmp')
    lines.append(f'execute if score #ds{k} br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds{k} br.tmp')
lines += ['execute store result bossbar oa:disaster max run scoreboard players get #bar_max br.tmp',
          'execute store result bossbar oa:disaster value run scoreboard players get #bar_v br.tmp',
          'bossbar set oa:disaster players @a[tag=br.playing]', 'bossbar set oa:disaster visible true']
write('bar.mcfunction', lines)

# 管理者用：個別・2種・3種・全部
write('admin/start.mcfunction', [HEAD, '# 管理者用：/function oa:disaster/admin/start {k:4}（5秒後に1種類。試合中のみ）',
    'execute unless score #state br.state matches 1 run return run tellraw @s {"text":"試合中だけ使えます","color":"red"}',
    'function oa:disaster/available', 'function oa:disaster/plan_clear', '$scoreboard players set #p$(k) br.tmp 1',
    'function oa:disaster/plan_commit'])
write('admin/multi.mcfunction', [HEAD, '# 管理者用：/function oa:disaster/admin/multi {n:2}（このマップの災害から n 種類を抽選して5秒後に。試合中のみ）',
    'execute unless score #state br.state matches 1 run return run tellraw @s {"text":"試合中だけ使えます","color":"red"}',
    'function oa:disaster/available', 'function oa:disaster/plan_clear', 'scoreboard players set #avoid_last br.tmp 0',
    '$scoreboard players set #want br.tmp $(n)', 'function oa:disaster/pick_n', 'function oa:disaster/plan_commit'])
write('admin/list.mcfunction', [HEAD, '# 管理者用：災害の一覧（番号・危険度・秒・重み）'] +
      [f'tellraw @s [{dump({"text":"k%d "%d["k"],"color":"gray"})},{dump({"text":d["name"],"color":d["color"]})},{dump({"text":" "+STARS(d["danger"])+" "+str(d["sec"])+"秒 重み","color":"white"})},{{"nbt":"cfg.weight.k{d["k"]}","storage":"oa:disaster","color":"white"}},{dump({"text":" マップ "+",".join(MAPS[m] for m in d["maps"]),"color":"gray"})}]' for d in DISASTERS])

print(f'disasters: {len(DISASTERS)}')
