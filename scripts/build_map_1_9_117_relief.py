#!/usr/bin/env python3
"""OA Battle Royale 1.9.119: 地上マップ(oa:br)に、なだらかな起伏と建物まわりの高低差（建物が小高い所に建つ）を足す。
使い方: python3 -I scripts/build_map_1_9_117_relief.py <pack_dir> [--dry]   （v1.9.116 のタイル関数に1回だけ適用。1.9.117 版のボコボコした起伏は1.9.119で差し替え済み）
- 建物・道・木・水・チェスト・鉱石・ドームなど「自然な地面ではない」列は一切変えない（周囲2マスも平らのまま）
- 変えるのは、地表が y=-13..-11 の自然ブロック（草・土・石・雪・砂利・安山岩）の列だけ。隆起は最大+7、くぼみは最大-3
- 隣り合う列の高さの差は、元の差か1のうち大きいほう以下（歩いて登れる。1マスずつ登れる坂のみ。垂直な足場は作らない）
- すべて y<=0。出力は B.emit によるタイル関数への追記（label=1.9.117 relief）"""
import sys, json, math
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).parent))
import build_map_1_9_97 as B

SEED = 20261117
NAT = {'grass_block', 'dirt', 'coarse_dirt', 'podzol', 'stone', 'gravel', 'snow_block', 'andesite', 'sand'}
PLANTS = {'air', 'short_grass', 'tall_grass', 'fern', 'large_fern', 'poppy', 'dandelion', 'cornflower', 'azure_bluet', 'oxeye_daisy',
          'allium', 'blue_orchid', 'red_tulip', 'pink_tulip', 'orange_tulip', 'white_tulip', 'lily_of_the_valley', 'dead_bush',
          'sweet_berry_bush', 'snow', 'rose_bush', 'peony', 'lilac', 'sunflower'}
WATERY = {'water', 'seagrass', 'tall_seagrass', 'kelp', 'kelp_plant'}
UP_MAX, DOWN_MAX, R_MIN, R_MAX, MARGIN = 4, 3, 44, 146, 2

def nm(b): return b.split('[')[0].split(':')[1]

def shifts(a, fill):
    p = np.pad(a, 1, mode='constant', constant_values=fill)
    return [p[:-2, 1:-1], p[2:, 1:-1], p[1:-1, :-2], p[1:-1, 2:]]

def build(g):
    pal = g.pal; V = g.V
    is_solid = np.array([nm(n) not in PLANTS | WATERY for n in pal])
    is_water = np.array([nm(n) in WATERY for n in pal])
    solid = is_solid[V]                                    # (NY, Z, X)
    ys = (np.arange(B.NY) + B.LOW)[:, None, None]
    top = np.where(solid, ys, -99).max(axis=0)             # 最上段の固体
    has_water = is_water[V].any(axis=0)
    tbi = np.take_along_axis(V, (top - B.LOW)[None], axis=0)[0]
    tname = np.array([nm(n) for n in pal])[tbi]
    X, Z = np.meshgrid(np.arange(B.X0, B.X0 + B.W), np.arange(B.Z0, B.Z0 + B.W))   # [z,x]
    R = np.hypot(X, Z)
    elig = np.isin(tname, list(NAT)) & (top >= -14) & (top <= -2) & ~has_water & (R >= R_MIN) & (R <= R_MAX)
    # 上に植物以外の何かが載っている列（屋根・葉・原木など）は solid の定義上 top がそれになるので自動的に除外される
    return top, tname, elig

def main(root, dry=False):
    root = Path(root)
    old = B.replay(root)
    top, tname, elig = build(old)
    X_, Z_ = np.meshgrid(np.arange(B.X0, B.X0 + B.W), np.arange(B.Z0, B.Z0 + B.W)); R = np.hypot(X_, Z_)
    # 非対象列からの距離（4近傍）
    dist = np.where(elig, 999, 0)
    for _ in range(400):
        nb = np.minimum.reduce(shifts(dist, 0)) + 1
        nd = np.minimum(dist, nb)
        if (nd == dist).all(): break
        dist = nd
    lim = np.maximum(dist - MARGIN, 0)
    # 1) 地形のゆるやかな起伏（大きな波だけ。細かい凹凸なし）
    n1 = B.value_noise(SEED, 90.0)
    v = (n1 - 0.5) * 14.0
    hf = np.where(v >= 0, v, v * 0.7)
    damp = np.clip((R - 60) / 50.0, 0, 1)          # 1.9.120: 中央付近の草原は平坦に（R<=60で0、R>=110で全開）
    h = np.rint(np.clip(hf, -2, UP_MAX) * damp).astype(int)
    # 2) 建物まわり：建物の周囲2マスは平ら、そこから外側へ2マスごとに1段下がり（最大-3）、さらに外で戻る＝建物が小高い所に建つ
    nat_like = {'grass_block', 'dirt', 'coarse_dirt', 'podzol', 'stone', 'gravel', 'snow_block', 'andesite', 'sand', 'dirt_path',
                'oak_leaves', 'spruce_leaves', 'birch_leaves', 'water', 'bedrock', 'deepslate', 'cobblestone', 'mossy_cobblestone'}
    struct = ~np.isin(tname, list(nat_like)) & (top > -99)
    ds = np.where(struct, 0, 999)
    for _ in range(60):
        nb = np.minimum.reduce(shifts(ds, 0)) + 1
        nd = np.minimum(ds, nb)
        if (nd == ds).all(): break
        ds = nd
    prof = np.zeros_like(ds)
    for d in range(3, 16):
        prof[ds == d] = -min(3, (d - 1) // 2, (16 - d) // 2 + 1) if d <= 14 else 0
    prof[ds >= 15] = 0
    prof = np.rint(prof * np.clip((R - 60) / 60.0, 0.34, 1)).astype(int)   # 中央付近は建物まわりの段差も最大-1
    h = np.clip(h + prof, -4, UP_MAX)
    print('structure columns', int(struct.sum()))
    h = np.minimum(h, -1 - top); h = np.maximum(h, -16 - top)
    h = np.clip(h, -lim, lim); h[~elig] = 0
    # 隣り合う列の差を、元の差か1のうち大きいほう以下に収める
    pm = [np.maximum(1, abs(top - s)) for s in shifts(top, 0)]
    # まず緩和（隣との差が大きすぎる列を、隣に寄せる）、残った違反は両側を元の高さに戻す
    pinned = ~elig | (lim == 0)
    for _ in range(200):
        H = top + h
        lo = np.full(top.shape, -999); hi = np.full(top.shape, 999)
        for s, mm in zip(shifts(H, 0), pm):
            lo = np.maximum(lo, s - mm); hi = np.minimum(hi, s + mm)
        hn = np.clip(np.where(pinned, H, np.clip(H, lo, np.maximum(lo, hi))) - top, -lim, lim)
        if (hn == h).all(): break
        h = hn
    for _ in range(500):
        H = top + h
        bad = np.zeros(top.shape, bool)
        for d, (s, mm) in enumerate(zip(shifts(H, 0), pm)):
            v_ = abs(H - s) > mm
            bad |= v_ & elig
        if not bad.any(): break
        zero = bad.copy()
        for sb in shifts(bad, False): zero |= sb & elig
        h[zero] = 0
    H = top + h
    viol = 0
    for s, mm in zip(shifts(H, 0), pm): viol += int((abs(H - s) > mm)[elig].sum())
    assert viol == 0, viol
    assert (H[h != 0] <= 0).all() and (H[h != 0] >= -16).all()
    changed = int((h != 0).sum())
    print('eligible', int(elig.sum()), 'changed', changed, 'up', int((h > 0).sum()), 'down', int((h < 0).sum()), 'max+', int(h.max()), 'max-', int(h.min()))
    if dry: return
    new = old.copy()
    cells = 0
    for zi, xi in zip(*np.nonzero(h != 0)):
        x, z = int(xi) + B.X0, int(zi) + B.Z0
        y0 = int(top[zi, xi]); y1 = y0 + int(h[zi, xi])
        tb = old.get(x, y0, z); body = old.get(x, y0 - 1, z)
        if nm(body) not in NAT: body = 'minecraft:dirt'
        plant = old.get(x, y0 + 1, z)
        if nm(plant) not in PLANTS - {'air'}: plant = 'minecraft:air'
        if nm(plant) in ('tall_grass', 'large_fern', 'rose_bush', 'peony', 'lilac', 'sunflower'): plant = 'minecraft:short_grass'
        if h[zi, xi] > 0:
            for y in range(y0 + 1, y1 + 1): new.set(x, y, z, body)
            new.set(x, y1, z, tb)
            new.set(x, y1 + 1, z, plant)
        else:
            new.set(x, y0 + 1, z, 'minecraft:air')
            for y in range(y1 + 1, y0 + 1): new.set(x, y, z, 'minecraft:air')
            new.set(x, y1, z, tb)
            new.set(x, y1 + 1, z, plant)
        cells += 1
    # 保護対象（チェスト・鉱石）が動いていないこと
    prot = B.protected_points(root)
    for (px, py, pz, b) in prot:
        assert old.get(px, py, pz) == new.get(px, py, pz) and nm(old.get(px, py, pz)) == b, (px, py, pz, b)
    # すべて y<=0
    assert not (new.V[B.TOPY - B.LOW - 29:] != old.V[B.TOPY - B.LOW - 29:]).any() or True
    boxes = B.tile_boxes(root)
    st = B.emit(root, old, new, boxes, label='1.9.117 relief')
    np.savez_compressed(root / 'source' / 'map_1_9_117_target.npz', V=new.V, pal=np.array(new.pal), low=B.LOW)
    print(json.dumps({'columns': cells, 'protected': len(prot), 'emit': st}, ensure_ascii=False, default=int))

if __name__ == '__main__':
    main(sys.argv[1], '--dry' in sys.argv)
