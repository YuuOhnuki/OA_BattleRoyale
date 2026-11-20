"""Preview images of the generated lobby (work/lobby-terminal-blocks.json).

top.png      : top-down view of the highest block in each column (roofs cut above y=cut)
plan.png     : plan view below the roofs (y <= 6), the walking level
light.png    : block light at feet level on walkable cells (red < 9, yellow 9-11, green >= 12)
iso.png      : simple isometric view from the arrival point side (south-west of the hall)
These are reconstructions from generated data, not client screenshots.
"""
import json, sys, math
from pathlib import Path
from PIL import Image, ImageDraw

ROOT = Path(__file__).resolve().parents[1]
W = ROOT / 'work'
OUTD = Path(sys.argv[1]) if len(sys.argv) > 1 else W / 'lobby-preview'
OUTD.mkdir(parents=True, exist_ok=True)
blocks = {(x, y, z): b for x, y, z, b in json.loads((W / 'lobby-terminal-blocks.json').read_text(encoding='utf-8'))}
light = json.loads((W / 'lobby-terminal-light.json').read_text(encoding='utf-8'))
report = json.loads((W / 'lobby-terminal-report.json').read_text(encoding='utf-8'))

PAL = [
    ('sea_lantern', (170, 230, 255)), ('shroomlight', (255, 170, 80)), ('lantern', (255, 210, 120)), ('froglight', (255, 230, 160)),
    ('copper_bulb', (255, 180, 100)), ('water', (60, 120, 220)), ('light_blue_concrete', (90, 170, 230)), ('cyan_concrete', (30, 140, 160)),
    ('orange_concrete', (230, 110, 30)), ('red_concrete', (170, 40, 40)), ('blue_concrete', (50, 60, 170)), ('red_', (190, 50, 50)), ('blue_', (60, 80, 200)),
    ('light_blue_stained', (150, 200, 240)), ('cyan_stained', (90, 180, 200)), ('glass', (180, 220, 240)),
    ('gold', (240, 200, 60)), ('iron_block', (210, 210, 210)), ('copper', (190, 110, 80)),
    ('leaves', (70, 140, 60)), ('azalea', (90, 150, 70)), ('moss', (90, 130, 50)), ('grass_block', (100, 160, 70)),
    ('dark_oak', (70, 50, 35)), ('spruce', (110, 80, 50)), ('oak', (170, 130, 80)), ('stripped_dark_oak', (90, 65, 45)),
    ('calcite', (225, 225, 220)), ('quartz', (240, 238, 232)), ('diorite', (205, 205, 205)), ('granite', (170, 130, 115)),
    ('andesite', (150, 152, 152)), ('black', (25, 25, 28)), ('blackstone', (40, 38, 45)), ('deepslate', (75, 75, 80)),
    ('prismarine', (90, 160, 150)), ('stone_bricks', (120, 120, 120)), ('target', (220, 120, 120)), ('lodestone', (140, 140, 150)), ('sculk', (20, 50, 60)),
    ('wool', (200, 200, 200)), ('chain', (60, 60, 70)), ('banner', (200, 60, 60)),
]
def col(b):
    n = b.split('[')[0]
    for k, c in PAL:
        if k in n: return c
    return (255, 0, 255)

S = 8
def grid(fn, name, ymax=44):
    img = Image.new('RGB', (81 * S, 81 * S), (20, 20, 20))
    d = ImageDraw.Draw(img)
    for x in range(-40, 41):
        for z in range(-40, 41):
            top = None
            for y in range(ymax, -4, -1):
                b = blocks.get((x, y, z))
                if b and b != 'air': top = (y, b); break
            if not top: continue
            c = col(top[1])
            shade = 0.75 + 0.25 * min(1, max(0, (top[0] + 1) / 12))
            c = tuple(int(v * shade) for v in c)
            # map: +x to the right, +z (front) to the top
            px, pz = (x + 40) * S, (40 - z) * S
            d.rectangle([px, pz, px + S - 1, pz + S - 1], fill=c)
    fn(d)
    img.save(OUTD / name)

def marks(d):
    for it in report['interactions']:
        cx, cz = (it['x0'] + it['x1']) / 2, (it['z0'] + it['z1']) / 2
        px, pz = (cx + 40) * S, (40 - cz + 1) * S
        d.ellipse([px - 3, pz - 3 - S, px + 3, pz + 3 - S], outline=(255, 0, 0), width=2)
    px, pz = (0.5 + 40) * S, (40 - 5.5 + 1) * S - S
    d.polygon([(px, pz - 6), (px - 5, pz + 5), (px + 5, pz + 5)], fill=(255, 40, 40))

grid(marks, 'top.png')
grid(marks, 'plan.png', ymax=6)

img = Image.new('RGB', (81 * S, 81 * S), (15, 15, 15))
d = ImageDraw.Draw(img)
for k, v in light.items():
    x, z = map(int, k.split(','))
    c = (200, 40, 40) if v < 9 else (220, 200, 40) if v < 12 else (40, 180, 70)
    c = tuple(int(a * (0.55 + 0.45 * v / 15)) for a in c)
    px, pz = (x + 40) * S, (40 - z) * S
    d.rectangle([px, pz, px + S - 1, pz + S - 1], fill=c)
img.save(OUTD / 'light.png')

# isometric from the arrival side (camera at -x,-z, above): far blocks first
def iso(name, ycut):
    T = 7
    im = Image.new('RGB', (1400, 1000), (190, 215, 235))
    d = ImageDraw.Draw(im)
    def P(x, y, z):
        return (700 + (x - z) * T * 0.87, 520 - (x + z) * T * 0.5 - y * T)
    def empty(x, y, z):
        b = blocks.get((x, y, z))
        return b is None or y > ycut or any(k in b for k in ('glass', 'pane', 'slab', 'fence', 'wall', 'lantern', 'chain', 'banner', 'carpet', 'leaves', 'azalea'))
    items = [kv for kv in blocks.items() if kv[0][1] <= ycut and kv[0][1] >= -1]
    items.sort(key=lambda kv: (-(kv[0][0] + kv[0][2]), kv[0][1]))
    for (x, y, z), b in items:
        top, wx, wz = empty(x, y + 1, z), empty(x - 1, y, z), empty(x, y, z - 1)
        if not (top or wx or wz): continue
        c = col(b)
        if wx: d.polygon([P(x, y, z), P(x, y + 1, z), P(x, y + 1, z + 1), P(x, y, z + 1)], fill=tuple(int(v * 0.66) for v in c))
        if wz: d.polygon([P(x, y, z), P(x, y + 1, z), P(x + 1, y + 1, z), P(x + 1, y, z)], fill=tuple(int(v * 0.82) for v in c))
        if top: d.polygon([P(x, y + 1, z), P(x + 1, y + 1, z), P(x + 1, y + 1, z + 1), P(x, y + 1, z + 1)], fill=c)
    im.save(OUTD / name)
iso('iso.png', 44)
iso('iso_cut.png', 7)
print('preview written to', OUTD)
