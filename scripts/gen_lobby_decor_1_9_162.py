"""1.9.162: ロビーの外装・飾りを華やかにする（lobby/decor_v162 を生成）。lobby/build の最後から呼ぶ。
機能のある場所（チーム選択の羊毛 z21〜31、開始パッド、中央の噴水、戦績ボード z-37、展示 x22〜23）には置かない。
外周の壁の柱と灯り、梁の旗（壁掛けの旗）と吊りランタン、柱の持ち送り、柱の上の光、四隅の木の花壇、生け垣の花、土台の外装。
使い方: py -3 scripts/gen_lobby_decor_1_9_162.py <repo>
"""
import sys
R = sys.argv[1]
L = ["# 生成: scripts/gen_lobby_decor_1_9_162.py（直接編集しない）。lobby/build の最後から呼ぶ"]
add = L.append

# 土台の外装（外から見える側面）：黒石レンガの帯と、ふちの石英レンガ
for a, b in [("~-40 ~-3 ~-40", "~40 ~-2 ~-40"), ("~-40 ~-3 ~40", "~40 ~-2 ~40"),
             ("~-40 ~-3 ~-40", "~-40 ~-2 ~40"), ("~40 ~-3 ~-40", "~40 ~-2 ~40")]:
    add(f"fill {a} {b} minecraft:polished_blackstone_bricks")
for a, b in [("~-40 ~-1 ~-40", "~40 ~-1 ~-40"), ("~-40 ~-1 ~40", "~40 ~-1 ~40"),
             ("~-40 ~-1 ~-40", "~-40 ~-1 ~40"), ("~40 ~-1 ~-40", "~40 ~-1 ~40")]:
    add(f"fill {a} {b} minecraft:quartz_bricks")

# 外周の壁の柱（4ブロックごと）：黒石レンガ2段＋模様入り石英＋ランタン
posts = set()
for t in range(-36, 37, 4):
    posts |= {(-39, t), (39, t), (t, -39), (t, 39)}
posts |= {(-39, -39), (-39, 39), (39, -39), (39, 39)}
for x, z in sorted(posts):
    add(f"fill ~{x} ~0 ~{z} ~{x} ~1 ~{z} minecraft:polished_blackstone_bricks")
    add(f"setblock ~{x} ~2 ~{z} minecraft:chiseled_quartz_block")
    add(f"setblock ~{x} ~3 ~{z} minecraft:lantern")

# 生け垣（x/z=±38 のツツジの葉）を3つに1つ花の咲いたツツジに
for t in range(-37, 38):
    if t % 3 == 0:
        for x, z in [(-38, t), (38, t), (t, -38), (t, 38)]:
            add(f"execute if block ~{x} ~0 ~{z} minecraft:azalea_leaves run setblock ~{x} ~0 ~{z} minecraft:flowering_azalea_leaves[persistent=true]")

# 梁（y12、外周の柱をつなぐ）の内側に壁掛けの旗（2ブロックごと、色を順に）。柱の上の石英の笠（3×3）の範囲は避ける
caps = [-37, -36, -35, -21, -20, -19, 19, 20, 21, 35, 36, 37]
colors = ["magenta", "light_blue", "yellow", "lime", "orange", "pink"]
i = 0
for t in range(-34, 35, 2):
    if t in caps:
        continue
    c = colors[i % len(colors)]; i += 1
    add(f"setblock ~{t} ~12 ~-35 minecraft:{c}_wall_banner[facing=south]")
    add(f"setblock ~{t} ~12 ~35 minecraft:{c}_wall_banner[facing=north]")
    add(f"setblock ~-35 ~12 ~{t} minecraft:{c}_wall_banner[facing=east]")
    add(f"setblock ~35 ~12 ~{t} minecraft:{c}_wall_banner[facing=west]")

# 梁の下の吊りランタン（旗の間、柱の近くは避ける）
pil = [-36, -20, 20, 36]
for t in range(-33, 34, 4):
    if any(abs(t - p) <= 1 for p in pil):
        continue
    for x, z in [(t, -36), (t, 36), (-36, t), (36, t)]:
        add(f"setblock ~{x} ~11 ~{z} minecraft:lantern[hanging=true]")

# 外周の柱の持ち送り（梁の下、柱の両脇に逆さの石英の階段）
for p in pil:
    for s in (-36, 36):
        # 梁の外へはみ出す側（角の柱の外側）には置かない
        if p - 1 >= -36:
            add(f"setblock ~{p-1} ~11 ~{s} minecraft:quartz_stairs[facing=east,half=top]")   # 南北の梁（z=±36）沿い：柱 (p, s)
            add(f"setblock ~{s} ~11 ~{p-1} minecraft:quartz_stairs[facing=south,half=top]")  # 東西の梁（x=±36）沿い：柱 (s, p)
        if p + 1 <= 36:
            add(f"setblock ~{p+1} ~11 ~{s} minecraft:quartz_stairs[facing=west,half=top]")
            add(f"setblock ~{s} ~11 ~{p+1} minecraft:quartz_stairs[facing=north,half=top]")

# 柱の上の光（シーランタンの上にエンドロッド）
for x in pil:
    for z in pil:
        add(f"setblock ~{x} ~14 ~{z} minecraft:end_rod[facing=up]")

# 四隅の木の花壇（草の地面 ±24〜±32 のうち、葉のない外側2列に花）
flowers = ["minecraft:pink_petals[flower_amount=4,facing=north]", "minecraft:allium", "minecraft:cornflower",
           "minecraft:oxeye_daisy", "minecraft:pink_petals[flower_amount=3,facing=east]", "minecraft:lily_of_the_valley"]
k = 0
for sx in (-1, 1):
    for sz in (-1, 1):
        for a in range(24, 33):
            for b in range(24, 33):
                if 26 <= a <= 30 and 26 <= b <= 30:
                    continue
                if (a + b) % 2:
                    continue
                x, z = sx * a, sz * b
                add(f"execute if block ~{x} ~-1 ~{z} minecraft:grass_block if block ~{x} ~0 ~{z} minecraft:air run setblock ~{x} ~0 ~{z} {flowers[k % len(flowers)]}")
                k += 1

open(f"{R}/data/oa/function/lobby/decor_v162.mcfunction", "w", encoding="utf-8").write("\n".join(L) + "\n")
print(len(L), "lines")
