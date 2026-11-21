#!/usr/bin/env python3
"""OA Battle Royale データパックの静的検査（Minecraft を起動せずにできる範囲）。

使い方: python3 tools/check_release.py [リポジトリのルート=カレント]
  1. data/ と pack.mcmeta のJSONが読めること
  2. `function oa:...`（マクロでないもの）の参照先が data/oa/function/ に存在すること
  3. 版数表示がそろっていること（pack.mcmeta・version.mcfunction・VALIDATION.json・
     docs/spec.md・HANDOFF.md・README_JA.md・docs/changelog.md・docs/discord-update-X.md）
終了コード 0=すべてOK、1=問題あり。これはゲーム内の動作確認の代わりにはならない。
"""
import glob, json, os, re, sys

root = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else '.')
os.chdir(root)
errors = []

def rd(p):
    with open(p, encoding='utf-8') as f:
        return f.read()

# 1. JSON
for p in glob.glob('data/**/*.json', recursive=True) + ['pack.mcmeta']:
    try:
        json.loads(rd(p))
    except Exception as e:
        errors.append(f'JSON: {p}: {e}')

# 1b. 進捗の条件：26.3 のトリガーの player／entity などは条件1つ（オブジェクト）。配列は読み込みに失敗し、
#     サーバーが起動しなくなる（1.9.178 の ach_trig/dqn.json）。複数なら minecraft:all_of で包む。
for p in glob.glob('data/*/advancement/**/*.json', recursive=True):
    try:
        adv = json.loads(rd(p))
    except Exception:
        continue
    for cname, crit in (adv.get('criteria') or {}).items():
        for key, val in ((crit or {}).get('conditions') or {}).items():
            if key in ('player', 'entity', 'parent', 'partner', 'child', 'projectile', 'shooter', 'victim', 'source', 'zombie', 'villager', 'lightning', 'bystander') and isinstance(val, list):
                errors.append(f'進捗の条件が配列: {p}: {cname}.{key}（26.3 は条件1つのオブジェクト）')

# 1c. loot function / item modifier の種類：26.3 に無い種類（minecraft:reference など）があると、
#     loot table の読み込みに失敗してサーバーが起動しなくなる（1.9.211 の作業中に発生）。一覧は 26.3 の LootItemFunctions。
LOOT_FUNCTIONS = {'set_count', 'set_item', 'enchant_with_levels', 'enchant_randomly', 'set_enchantments', 'set_custom_data',
    'set_components', 'furnace_smelt', 'enchanted_count_increase', 'set_damage', 'set_attributes', 'set_name',
    'exploration_map', 'set_stew_effect', 'copy_name', 'set_contents', 'modify_contents', 'filtered', 'limit_count',
    'apply_bonus', 'set_loot_table', 'explosion_decay', 'set_lore', 'fill_player_head', 'copy_custom_data', 'copy_state',
    'set_banner_pattern', 'set_potion', 'set_random_dyes', 'set_random_potion', 'set_instrument', 'sequence',
    'copy_components', 'set_fireworks', 'set_firework_explosion', 'set_book_cover', 'set_written_book_pages',
    'set_writable_book_pages', 'toggle_tooltips', 'set_ominous_bottle_amplifier', 'set_custom_model_data', 'discard'}


def check_loot_functions(node, path, inside):
    """inside=True のとき node は関数のリスト／関数そのもの。"""
    if isinstance(node, list):
        for v in node:
            check_loot_functions(v, path, inside)
        return
    if not isinstance(node, dict):
        return
    if inside:
        t = node.get('type')
        if isinstance(t, str) and t.startswith('minecraft:') and t[10:] not in LOOT_FUNCTIONS:
            errors.append(f'26.3 に無い loot function: {path}: {t}')
    for k, v in node.items():
        if k in ('functions', 'modifier') and isinstance(v, list):
            check_loot_functions(v, path, True)
        elif isinstance(v, (dict, list)) and k not in ('conditions', 'predicate', 'components'):
            check_loot_functions(v, path, False)


for p in glob.glob('data/*/loot_table/**/*.json', recursive=True):
    try:
        check_loot_functions(json.loads(rd(p)), p, False)
    except Exception:
        pass
for p in glob.glob('data/*/item_modifier/**/*.json', recursive=True):
    try:
        j = json.loads(rd(p))
        check_loot_functions(j if isinstance(j, list) else [j], p, True)
    except Exception:
        pass

# 2. function references
funcs = {f[len('data/oa/function/'):-len('.mcfunction')].replace(os.sep, '/')
         for f in glob.glob('data/oa/function/**/*.mcfunction', recursive=True)}
for f in glob.glob('data/oa/function/**/*.mcfunction', recursive=True):
    for n, line in enumerate(rd(f).split('\n'), 1):
        for m in re.finditer(r'function oa:([\w/]+)', line):
            if m.group(1) not in funcs and '$(' not in line:
                errors.append(f'参照先なし: {f}:{n}: oa:{m.group(1)}')

# 2b. command names: 各行の先頭と `run` の直後が実在するコマンドであること
#     （1.9.141〜1.9.153: `run return run [{text:…}]` と tellraw が抜け、関数ごと読み込めなかった）
COMMANDS = set('''advancement attribute ban ban-ip banlist bossbar clear clone damage data datapack
debug defaultgamemode deop dialog difficulty effect enchant execute experience fetchprofile fill
fillbiome forceload function gamemode gamerule give help item jfr kick kill list locate loot me msg
op pardon pardon-ip particle perf place playsound publish random recipe reload return ride rotate
save-all save-off save-on say schedule scoreboard seed setblock setidletimeout setworldspawn
spawnpoint spectate spreadplayers stop stopsound stopwatch summon swing tag team teammsg teleport
tell tellraw test tick time title tm tp transfer trigger version w waypoint weather whitelist
worldborder xp'''.split())
for f in glob.glob('data/**/*.mcfunction', recursive=True):
    for n, line in enumerate(rd(f).split('\n'), 1):
        s = line.strip()
        if not s or s.startswith('#'):
            continue
        if s.startswith('$'):
            s = s[1:].lstrip()
        heads = [s.split()[0]] + re.findall(r'\brun\s+(\S+)', s)
        for h in heads:
            if h not in COMMANDS:
                errors.append(f'コマンド名: {f}:{n}: {h[:40]}')
        # 26.3 のブロック状態は {id:"…",properties:{…}}。旧形式 Name/Properties と "id[prop=…]" の文字列は
        # 実体の読み込みで Serialization errors になる（1.9.122〜1.9.153 の補給の樽・鎖）
        if re.search(r'\bName:"minecraft:|\bProperties:\{|(block_state|BlockState):"[^"]*\[', s):
            errors.append(f'ブロック状態の旧形式: {f}:{n}')
        # 26.3（1.21.9 以降）で改名されたブロック。旧名は関数ごと読み込みに失敗する（1.9.203 の作業中に chain→iron_chain で発生）
        if re.match(r'(fill|setblock|clone)\b', s.split(' run ')[-1]) and re.search(r'minecraft:chain\b(?!_)', s):
            errors.append(f'改名済みのブロック（chain→iron_chain）: {f}:{n}')
        # data modify の対象のあとにパスがない（1.9.157: `data modify storage oa:ach_info set value {}` で関数ごと読み込めなかった）
        if re.search(r'\bdata modify (storage \S+|block \S+ \S+ \S+|entity \S+) (set|merge|append|prepend|insert)\b', s):
            errors.append(f'data modify のパスがない: {f}:{n}')

# Every custom dimension must be represented in the shared coordinate snapshot.
# Otherwise skill return positions silently fall back to the overworld (TDM 1.9.195).
for dim_file in glob.glob('data/oa/dimension/*.json'):
    dim = 'oa:' + os.path.splitext(os.path.basename(dim_file))[0]
    if 'if dimension ' + dim + ' run data modify storage oa:position value.dim' not in rd('data/oa/function/nero/save.mcfunction'):
        errors.append(f'座標保存のディメンションが未対応: {dim}')

# A fresh medical drop must stack with the same item after inventory refresh.
# Include custom_data migration flags in this comparison (1.9.208 regression).
medical_components = {}
for path in glob.glob('data/oa/item_modifier/medical/*.json'):
    item = json.loads(rd(path))
    actions = item.get('functions', [])
    if len(actions) != 1 or actions[0].get('type') != 'minecraft:set_components':
        errors.append(f'医療品の更新処理が共通コンポーネント以外を変更する: {path}')
        continue
    medical_components[os.path.basename(path)[:-5]] = actions[0]['components']

def check_medical_loot(node, path):
    if isinstance(node, list):
        for child in node:
            check_medical_loot(child, path)
    elif isinstance(node, dict):
        comp = node.get('components', {})
        tag = comp.get('minecraft:custom_data', {})
        kind = tag.get('oa_buff') or {1: 'heal1', 2: 'heal2'}.get(tag.get('br_heal_kind'))
        if kind in medical_components and json.dumps(comp, sort_keys=True) != json.dumps(medical_components[kind], sort_keys=True):
            errors.append(f'医療品が更新後の所持品とスタックできない: {path}: {kind}')
        for child in node.values():
            check_medical_loot(child, path)

for path in glob.glob('data/oa/loot_table/**/*.json', recursive=True):
    check_medical_loot(json.loads(rd(path)), path)

# 2c. マクロの行（先頭が $）は $(名前) を1つ以上含むこと。含まないと関数ごと読み込みに失敗する（1.9.213 の作業中、br/countdown/show で発生）
for f in glob.glob('data/*/function/**/*.mcfunction', recursive=True):
    for n, line in enumerate(rd(f).splitlines(), 1):
        if line.startswith('$') and '$(' not in line:
            errors.append(f'変数のないマクロ行: {f}:{n}')

# 3. versions
ver = None
m = re.search(r'OA バトルロワイヤル (\d+\.\d+\.\d+)', rd('pack.mcmeta'))
if m:
    ver = m.group(1)
else:
    errors.append('pack.mcmeta に版数がない')
if ver:
    def need(path, pattern, what):
        try:
            if not re.search(pattern, rd(path)):
                errors.append(f'版数: {path}: {what} が {ver} ではない')
        except FileNotFoundError:
            errors.append(f'版数: {path} がない')
    v = re.escape(ver)
    need('VALIDATION.json', r'"version":\s*"%s"' % v, 'version')
    need('docs/spec.md', r'^# .*%s' % v, '1行目')
    need('HANDOFF.md', r'^# .*%s' % v, '1行目')
    need('docs/changelog.md', r'## v%s' % v, '最新の節')
    need('README_JA.md', r'\*\*v%s' % v, '先頭の版')
    need(f'docs/discord-update-{ver}.md', r'v%s' % v, '告知文')
    vf = rd('data/oa/function/br/ui/version.mcfunction')
    for key in ['br.ui0'] + [f'br.ui{i}' for i in range(1, 11)]:
        if not re.search(r'OA_version %s \{text:"v%s"' % (re.escape(key), v), vf):
            errors.append(f'版数: version.mcfunction の {key} が v{ver} ではない')
    if f'value "v{ver}"' not in vf:
        errors.append('版数: version.mcfunction の storage oa:meta が違う')

print(f'版数 {ver} / 関数 {len(funcs)} 個')
if errors:
    print('NG')
    for e in errors:
        print(' -', e)
    sys.exit(1)
print('OK')
