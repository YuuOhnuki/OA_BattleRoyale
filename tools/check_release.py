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
        # data modify の対象のあとにパスがない（1.9.157: `data modify storage oa:ach_info set value {}` で関数ごと読み込めなかった）
        if re.search(r'\bdata modify (storage \S+|block \S+ \S+ \S+|entity \S+) (set|merge|append|prepend|insert)\b', s):
            errors.append(f'data modify のパスがない: {f}:{n}')

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
