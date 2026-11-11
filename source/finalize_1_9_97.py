#!/usr/bin/env python3
"""Release bookkeeping for 1.9.97: version strings, map manifest, overview image. Usage: finalize_1_9_97.py <pack_dir>"""
import sys, json, re
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).parent))
import build_map_1_9_97 as B
from PIL import Image, ImageDraw, ImageFont
root = Path(sys.argv[1]); OLD, NEW = '1.9.96', '1.9.97'

# ---- version strings
p = root / 'pack.mcmeta'; p.write_text(p.read_text().replace(f'OA バトルロワイヤル {OLD} / Java26.3', f'OA バトルロワイヤル {NEW} / Java26.3'))
p = root / 'data/oa/function/br/ui/version.mcfunction'; s = p.read_text(); assert s.count(OLD) == 11; p.write_text(s.replace(OLD, NEW))
p = root / 'README_JA.md'; s = p.read_text()
s = s.replace('# ディメンション分離（v1.9.96 / Java 26.3）', f'# ディメンション分離（v{NEW} / Java 26.3）\n\n**v1.9.97（マップ更新）**：中央広場に空中ドーム骨組みを追加し、北の雪原・草地・海底を仕上げました。反映にはBR会場の再生成（`/function oa:map/rebuild`）が必要です。サーバー再起動・リソースパック交換・ロビーと練習場の更新は不要です。詳細は UPDATE_1_9_97_JA.md と docs/spec.md。', 1)
# stale map statements found while checking the docs against the implementation
s = s.replace('生成は基準X/Z−152〜+152、Y−20〜Y。', '生成は基準X/Z−152〜+152、Y−20〜Y（中央広場のドーム骨組みのみY+29まで）。')
s = s.replace('登録成功（チェスト48／鉱石108）', '登録成功（チェスト59／鉱石108）')
s = s.replace('ジャンプパッド18か所があります', 'ジャンプパッド27か所があります')
s = s.replace('中央地面は基準Y−11、立つ位置はY−10です。', '中央地面は基準Y−11、立つ位置はY−10です。BR専用ディメンションでは基準Y=80、中央地面Y=69です。')
p.write_text(s)

# ---- manifest
man = json.loads((root / 'MAP_MANIFEST.json').read_text())
g = B.replay(root, kinds=('place',))
dome, pyl = B.build_dome()
man['version'] = NEW; man['y_range'] = [-20, B.DOME_MAX_Y]
man['blocks'] = int((g.V > 0).sum())
man['plaza_dome'] = {'center': [0, 0], 'floor_y': B.GROUND, 'piers': [[x0, z0] for a, x0, z0 in pyl], 'pier_size': [2, 2], 'pier_top_y': B.Yk(B.K_BASE - 1),
                     'frame_bottom_y': B.Yk(B.K_BASE), 'frame_top_y': B.DOME_MAX_Y, 'rings_radius': [B.R_BASE, B.R_MID, B.R_TOP], 'oculus_radius': B.R_TOP, 'frame_blocks': len(dome),
                     'lowest_standable_height_above_floor': B.K_BASE, 'air_clear_to_y': B.CLEAR_TOP, 'tiles_with_upper_clear': [34, 43, 44, 45, 54, 55]}
for n in ('minecraft:waxed_exposed_cut_copper', 'minecraft:waxed_weathered_cut_copper', 'minecraft:waxed_oxidized_cut_copper', 'minecraft:waxed_chiseled_copper', 'minecraft:tall_grass', 'minecraft:fern',
          'minecraft:cornflower', 'minecraft:oxeye_daisy', 'minecraft:allium', 'minecraft:red_tulip', 'minecraft:orange_tulip', 'minecraft:white_tulip', 'minecraft:pink_tulip', 'minecraft:seagrass', 'minecraft:tall_seagrass', 'minecraft:kelp', 'minecraft:kelp_plant'):
    if not any(e.get('id') == n for e in man['palette']): man['palette'].append({'id': n})
(root / 'MAP_MANIFEST.json').write_text(json.dumps(man, ensure_ascii=False, indent=2) + '\n')

# ---- overview image (top-down, topmost block incl. the dome frame; water from the water pass)
full = B.replay(root)
sys.path.insert(0, str(Path(__file__).parent))
COL = {'grass_block': (98, 150, 64), 'dirt': (120, 85, 55), 'stone': (125, 125, 125), 'snow_block': (240, 245, 250), 'packed_ice': (160, 190, 240), 'dirt_path': (150, 125, 70), 'gravel': (135, 130, 130), 'sand': (222, 208, 150),
       'bricks': (150, 85, 70), 'stone_bricks': (120, 120, 120), 'mossy_stone_bricks': (100, 125, 90), 'cracked_stone_bricks': (110, 110, 110), 'cobblestone': (110, 110, 110), 'mossy_cobblestone': (95, 115, 90),
       'sea_lantern': (250, 240, 200), 'polished_blackstone': (45, 42, 50), 'waxed_cut_copper': (205, 120, 80), 'waxed_exposed_cut_copper': (190, 140, 110), 'waxed_weathered_cut_copper': (110, 160, 120), 'waxed_oxidized_cut_copper': (60, 175, 160),
       'waxed_chiseled_copper': (225, 140, 95), 'waxed_oxidized_copper': (70, 150, 130), 'smooth_quartz': (235, 230, 225), 'oak_planks': (170, 130, 80), 'spruce_planks': (110, 80, 50), 'dark_oak_planks': (70, 50, 30), 'oak_leaves': (50, 120, 40),
       'spruce_leaves': (40, 90, 50), 'oak_log': (105, 80, 45), 'spruce_log': (70, 50, 30), 'chest': (240, 200, 40), 'glass': (190, 220, 230), 'glass_pane': (190, 220, 230), 'andesite': (135, 135, 135), 'deepslate': (80, 80, 85),
       'coal_ore': (60, 60, 60), 'deepslate_coal_ore': (50, 50, 55), 'redstone_ore': (150, 60, 60), 'deepslate_redstone_ore': (140, 50, 50), 'bedrock': (30, 30, 30), 'poppy': (210, 40, 40), 'dandelion': (240, 220, 60), 'azure_bluet': (230, 230, 240),
       'short_grass': (90, 160, 60), 'fern': (70, 140, 60), 'tall_grass': (80, 155, 60), 'cornflower': (90, 110, 220), 'oxeye_daisy': (240, 240, 235), 'allium': (190, 120, 220), 'red_tulip': (210, 50, 40), 'orange_tulip': (235, 140, 40),
       'white_tulip': (240, 240, 240), 'pink_tulip': (240, 150, 190), 'seagrass': (40, 130, 90), 'tall_seagrass': (40, 130, 90), 'kelp': (60, 140, 70), 'kelp_plant': (60, 140, 70), 'water': (50, 100, 200), 'bookshelf': (120, 90, 55), 'barrel': (130, 95, 55), 'crafting_table': (150, 105, 60), 'furnace': (110, 110, 110), 'smoker': (110, 100, 95), 'hay_block': (210, 180, 50), 'pumpkin': (215, 130, 30), 'cartography_table': (120, 90, 70), 'lantern': (240, 190, 90), 'anvil': (60, 60, 65), 'vine': (60, 130, 50), 'ladder': (140, 105, 60)}
def color(b):
    n = b.split(':')[1].split('[')[0]
    if n in COL: return COL[n]
    for k, v in COL.items():
        if k in n: return v
    if 'wool' in n or 'carpet' in n:
        return {'white': (230, 230, 230), 'cyan': (30, 140, 150), 'red': (170, 40, 40), 'blue': (50, 60, 160), 'light_blue': (100, 160, 220), 'yellow': (230, 200, 50), 'orange': (220, 120, 30)}.get(n.split('_wool')[0].split('_carpet')[0], (180, 180, 180))
    if any(k in n for k in ('stairs', 'slab', 'fence', 'planks')): return (150, 115, 70)
    return (200, 0, 200)
s = 3; Wd = 305 * s
cols = [color(p) if p != 'minecraft:air' else None for p in full.pal]
V = full.V
top = np.full((305, 305), -1, dtype=int); topy = np.zeros((305, 305), dtype=int)
for yi in range(B.NY - 1, -1, -1):
    m = (V[yi] > 0) & (top < 0); top[m] = V[yi][m]; topy[m] = yi
im = Image.new('RGB', (Wd, Wd)); px = im.load()
for z in range(305):
    for x in range(305):
        t = top[z, x]
        c = cols[t] if t >= 0 else (0, 0, 0)
        d = int(topy[z, x] - topy[z - 1, x]) if z else 0
        f = 1 + 0.06 * max(-3, min(3, d)); c = tuple(int(max(0, min(255, v * f))) for v in c)
        for dx in range(s):
            for dz in range(s): px[x * s + dx, z * s + dz] = c
panel = Image.new('RGB', (1330, 1030), (22, 30, 34)); panel.paste(im, (28, 90))
dr = ImageDraw.Draw(panel)
try: font = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', 26); sm = ImageFont.truetype('/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf', 17)
except Exception: font = sm = ImageFont.load_default()
dr.text((28, 24), f'OA BATTLE ROYALE  /  305 x 305  /  v{NEW}', font=font, fill=(240, 232, 215))
dr.text((28, 62), 'Actual block data (top view, frame included) | North: mountains / South: coast / East: forest / West: town', font=sm, fill=(190, 205, 195))
lines = ['NORTH', 'Rocky hills + ore pockets', 'Snow field with rock outcrops', '', 'SOUTH', 'Sea (seagrass + kelp), beach, pier', 'Large ship + interior', '', 'EAST', 'Dense forest, 3 small ruins', '', 'WEST', 'Large town + market', 'Harbor homes', '', 'CENTER',
         'Sky dome frame over the plaza', '8 piers + copper-patina lattice', 'Open oculus above the OA floor', '', 'Houses: 21', 'Chests: 59', 'Ore nodes: 108', 'Jump pads: 27', 'Trees: 246', '', 'Blocks: Y-20 .. Y (frame to Y+29)', '100 staged placement tiles']
for i, l in enumerate(lines): dr.text((975, 100 + i * 33), l, font=sm, fill=(217, 226, 208))
panel.save(root / 'MAP_OVERVIEW.png')
print('finalized', NEW, 'blocks', man['blocks'])
