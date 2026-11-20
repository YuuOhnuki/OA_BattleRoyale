"""OA 管理ブック（1.9.203）。管理コード（oa.admin）は変えない。

並び：運営ダッシュボード → 目次 → 試合運営 → プレイヤー管理 → 会場管理（地上・ネザー・地下） → ロビー／練習場
      → 記録／実績 → サーバー更新 → 診断／開発 → 旧操作（互換）。
危険な操作（※）は /oamenu confirm:N の確認画面（対象と影響を表示）を経て実行する。
"""
import json, sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
from book_layout import check_page

r = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).resolve().parents[1]
out = r / 'data/oa/function/admin'
danger = {3, 4, 7, 13, 14, 47, 48, 56, 57, 58} | {base + n for base in [60, 80, 100] for n in [1, 2, 3, 9, 10]}

# (label, code) or (label, '/command')
groups = [
    ('試合運営', [('BRの出撃設定', '/oa br_host'), ('TDMの出撃設定', '/oa tdm_host'), ('準備状態を確認', 2), ('BRをソロで開始', 5), ('BRをチーム戦で開始', 6), ('試合を中止して復元', 7)]),
    ('プレイヤー管理', [('対象を選んで管理', 35), ('一覧（メニュー）', '/oamenu roster'), ('自分のゲームモード', 38), ('自分を復活', 39)]),
]
for name, base in [('地上', 60), ('ネザー', 80), ('地下（古代都市）', 100)]:
    labels = ['中心へ移動', '会場を生成', '会場を再生成', '会場を削除', '現在地を中心に', '生成した中心を使う', 'ボーダー自動設定',
              '開始地点を追加', '開始地点を確認', '近くの地点を削除', '全開始地点を削除', 'この会場を選択']
    order = [11, 0, 7, 8, 1, 2, 4, 5, 6, 9, 10, 3]          # よく使う順
    groups.append(('会場：' + name, [(labels[i], base + i) for i in order]))
groups += [
    ('ロビー／練習場', [('ロビー中央へ移動', 32), ('表示・端末を置き直す', 46), ('ロビーを再建', 14), ('練習場を生成', 58), ('現在地にロビー作成', 4)]),
    ('記録／実績', [('記録・実績メニュー', '/oamenu records'), ('自分の戦績', '/stats'), ('全員分の削除', '/oamenu wipe')]),
    ('サーバー更新', [('更新メニュー', '/oamenu updates'), ('版数を表示', '/function oa:version')]),
    ('診断／開発', [('基本設定を補完', 33), ('飛び道具の診断', 34), ('デバッグ開始', 40), ('デバッグ本', 41), ('管理ブックを更新', 16)]),
    ('固有装備（検証）', list(zip(['ゆうあ', 'ぴちぴち', 'lazi', 'ネロ', 'キリング', 'ゆったり', 'ほちきす', 'こまめ', 'たやゆゆ', 'いとり'], [20, 21, 22, 23, 24, 25, 26, 27, 36, 53]))),
    ('消耗品・武器（検証）', [('ゆー', 28), ('ふろボール', 37), ('木のバット', 9), ('ノックバック棒', 10), ('バフ医療品4種', 17), ('包帯', 42), ('応急キット', 43), ('雪玉16個', 44), ('卵16個', 45)]),
    ('旧操作（互換）', [('開始地点を追加', 54), ('開始地点を確認', 55), ('近くの地点を削除', 56), ('全開始地点を削除', 57), ('展示スキン更新', 51)]),
]

def t(s, color='black', **kw): return dict(text=s, color=color, **kw)
def act(label, target):
    if isinstance(target, str):
        return t('▸ ' + label + '\n', 'dark_blue', underlined=True, click_event={'action': 'run_command', 'command': target})
    if target in danger:
        return t('▸ ' + label + ' ※\n', 'dark_red', underlined=True, click_event={'action': 'run_command', 'command': '/oamenu confirm:' + str(target)})
    return t('▸ ' + label + '\n', 'dark_blue', underlined=True, click_event={'action': 'run_command', 'command': '/trigger oa.admin set ' + str(target)})
def nav(label, p): return t(label + '\n', 'dark_purple', underlined=True, click_event={'action': 'change_page', 'page': p})
def page(title, parts, check=True):
    extra = [t(title + '\n\n', 'dark_purple', bold=True)] + parts
    if check: check_page(extra)
    return {'raw': {'text': '', 'extra': extra}}

PER = 6
dash = page('運営ダッシュボード', [t('$(mode) / $(map)\n$(state)\n\n'), act('管理メニュー', '/oamenu'), act('BRの出撃設定', '/oa br_host'),
                                    act('TDMの出撃設定', '/oa tdm_host'), act('更新の確認・反映', '/oamenu updates'), nav('目次へ', 2),
                                    t('\n※は確認画面で対象と影響を表示してから実行', 'dark_gray')], check=False)
pages = [dash, None, None]
starts = []
for name, items in groups:
    starts.append((name, len(pages) + 1))
    for s0 in range(0, len(items), PER):
        parts = [act(label, target) for label, target in items[s0:s0 + PER]]
        if s0 + PER < len(items): parts.append(nav('次の項目 ›', len(pages) + 2))
        parts.append(nav('‹ 目次', 2))
        pages.append(page(name + ('' if s0 == 0 else '（続き）'), parts))
half = 7
pages[1] = page('目次 1/2', [nav(n, p) for n, p in starts[:half]] + [nav('次の目次 ›', 3)])
pages[2] = page('目次 2/2', [nav(n, p) for n, p in starts[half:]] + [nav('‹ 前の目次', 2)])
book = {'title': {'raw': 'OA 管理ブック'}, 'author': 'OA', 'generation': 0, 'resolved': False, 'pages': pages}
(out / 'book_content.mcfunction').write_text('$give @s minecraft:written_book[minecraft:written_book_content=' + json.dumps(book, ensure_ascii=False, separators=(',', ':'))
                                             + ',minecraft:custom_name={text:"OA 管理ブック",color:"gold",italic:false},minecraft:custom_data={oa_admin_book:1b,book_v203:1b},minecraft:max_stack_size=1] 1\n', encoding='utf-8')
lines = ['execute unless entity @s[tag=br.admin] run return 0', 'clear @s *[minecraft:custom_data~{oa_admin_book:1b}]', 'scoreboard players set #admin_free oa.tmp 0']
for slot in [f'hotbar.{n}' for n in range(9)] + [f'inventory.{n}' for n in range(27)]:
    lines.append(f'execute unless items entity @s {slot} * run scoreboard players set #admin_free oa.tmp 1')
lines += ['execute if score #admin_free oa.tmp matches 0 run return run tellraw @s {text:"本を受け取るため持ち物に空きを作ってください",color:"yellow"}',
          'data modify storage oa:admin_book mode set value "バトルロワイヤル"',
          'execute if score #game oa.game matches 1 run data modify storage oa:admin_book mode set value "チームデスマッチ"',
          'data modify storage oa:admin_book map set value "地上"',
          'execute if score #map oa.mapid matches 1 run data modify storage oa:admin_book map set value "ネザー"',
          'execute if score #map oa.mapid matches 2 run data modify storage oa:admin_book map set value "地下（古代都市）"',
          'execute if score #game oa.game matches 1 run data modify storage oa:admin_book map set value "立体工廠"',
          'data modify storage oa:admin_book state set value "待機中（取得時点）"',
          'execute if score #state br.state matches 1.. run data modify storage oa:admin_book state set value "試合進行中（取得時点）"',
          'function oa:admin/book_content with storage oa:admin_book',
          'tellraw @s {text:"管理ブックを更新しました。最新の状態は /oamenu で確認できます",color:"gold"}']
(out / 'book.mcfunction').write_text('\n'.join(lines) + '\n', encoding='utf-8')
print('Admin book:', len(pages), 'pages; at most', PER, 'actions per page; groups:', [g[0] for g in groups])
