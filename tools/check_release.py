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
