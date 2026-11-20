"""Visual bounds of item models as an item_display shows them (display context "fixed").

Used by the lobby generator to centre weapons on pedestals: the transformation
translation is chosen so that the visible bounding box is centred on the entity
position in X/Z and its lowest point sits on the pedestal.
"""
import json, math
from pathlib import Path

RP = Path(__file__).resolve().parents[2] / 'oa_battleroyale_resourcepack' / 'assets'

def _res(ns_path, kind, ext):
    ns, _, p = ns_path.partition(':') if ':' in ns_path else ('minecraft', '', ns_path)
    return RP / ns / kind / (p + ext)

def _rot(v, axis, deg, origin=(0, 0, 0)):
    a = math.radians(deg); c, s = math.cos(a), math.sin(a)
    x, y, z = (v[i] - origin[i] for i in range(3))
    if axis == 'x': y, z = y * c - z * s, y * s + z * c
    elif axis == 'y': x, z = x * c + z * s, -x * s + z * c
    else: x, y = x * c - y * s, x * s + y * c
    return (x + origin[0], y + origin[1], z + origin[2])

def load_model(name):
    """Resolve parents. Returns (vertices in 0..16 model units, fixed display transform)."""
    display = {}
    path = name
    elements = None
    textures = {}
    generated = False
    while path:
        f = _res(path, 'models', '.json')
        if not f.is_file():
            # vanilla parents we cannot read
            if path.endswith('item/generated') or path.endswith('item/handheld'):
                generated = True
                display.setdefault('fixed', {'rotation': [0, 180, 0], 'scale': [1, 1, 1]})
            break
        d = json.loads(f.read_text(encoding='utf-8'))
        for k, v in d.get('display', {}).items():
            display.setdefault(k, v)
        for k, v in d.get('textures', {}).items():
            textures.setdefault(k, v)
        if elements is None and 'elements' in d:
            elements = d['elements']
        path = d.get('parent')
        if path and (path.endswith('item/generated') or path.endswith('item/handheld')):
            generated = True
            display.setdefault('fixed', {'rotation': [0, 180, 0], 'scale': [1, 1, 1]})
            break
    verts = []
    if elements:
        for e in elements:
            a, b = e['from'], e['to']
            corners = [(x, y, z) for x in (a[0], b[0]) for y in (a[1], b[1]) for z in (a[2], b[2])]
            r = e.get('rotation')
            if r and r.get('angle'):
                corners = [_rot(c, r['axis'], r['angle'], r['origin']) for c in corners]
            verts += corners
    elif generated:
        tex = textures.get('layer0')
        x0, y0, x1, y1 = 0, 0, 16, 16
        if tex:
            from PIL import Image
            img = Image.open(_res(tex, 'textures', '.png')).convert('RGBA')
            w, h = img.size
            h = w  # animated strips: first frame
            box = img.crop((0, 0, w, h)).getchannel('A').point(lambda v: 255 if v > 16 else 0).getbbox()
            if box:
                k = 16 / w
                x0, x1 = box[0] * k, box[2] * k
                y0, y1 = 16 - box[3] * k, 16 - box[1] * k
        verts = [(x, y, z) for x in (x0, x1) for y in (y0, y1) for z in (7.5, 8.5)]
    else:
        verts = [(x, y, z) for x in (0, 16) for y in (0, 16) for z in (0, 16)]
    return verts, display.get('fixed', {})

def fixed_vertices(name, block_item=False):
    """Vertices in block units after the "fixed" display transform and the display renderer's 180° turn."""
    if block_item:
        verts = [(x, y, z) for x in (0, 16) for y in (0, 16) for z in (0, 16)]
        fx = {'scale': [0.5, 0.5, 0.5]}
    else:
        verts, fx = load_model(name)
    t = [v / 16 for v in fx.get('translation', [0, 0, 0])]
    r = fx.get('rotation', [0, 0, 0])
    s = fx.get('scale', [1, 1, 1])
    out = []
    for v in verts:
        q = [(v[i] / 16 - 0.5) * s[i] for i in range(3)]
        # rotationXYZ: applied to the vector as Rx*Ry*Rz*q
        q = _rot(q, 'z', r[2]); q = _rot(q, 'y', r[1]); q = _rot(q, 'x', r[0])
        q = [q[i] + t[i] for i in range(3)]
        q = _rot(q, 'y', 180)
        out.append(q)
    return out

def placement(name, target=0.9, tilt=0.0, block_item=False, smin=0.35, smax=2.2):
    """Scale and translation so the model is centred in X/Z with its lowest point at y=0 (entity origin).

    tilt: extra yaw (degrees) inside the transformation, for a 3/4 view.
    Returns dict(scale, translation, left_rotation, size=(w,h,d) after scaling, top).
    """
    v = fixed_vertices(name, block_item)
    xs, ys, zs = zip(*v)
    big = max(max(xs) - min(xs), max(ys) - min(ys), max(zs) - min(zs))
    sc = max(smin, min(smax, target / big)) if big > 0 else 1.0
    pts = [_rot((p[0] * sc, p[1] * sc, p[2] * sc), 'y', tilt) for p in v]
    xs, ys, zs = zip(*pts)
    cx, cz = (max(xs) + min(xs)) / 2, (max(zs) + min(zs)) / 2
    half = math.radians(tilt) / 2
    q = [0.0, math.sin(half), 0.0, math.cos(half)]
    return {
        'scale': sc,
        'translation': [round(-cx, 4), round(-min(ys) + 0.02, 4), round(-cz, 4)],
        'left_rotation': [round(x, 6) for x in q],
        'size': (round(max(xs) - min(xs), 3), round(max(ys) - min(ys), 3), round(max(zs) - min(zs), 3)),
        'top': round(max(ys) - min(ys) + 0.02, 3),
        'raw_offset': (round(cx, 3), round(min(ys), 3), round(cz, 3)),
    }

if __name__ == '__main__':
    for m in ['yuua', 'pichipichi', 'raji', 'nero', 'killing', 'yuttari', 'hotchikisu', 'komame', 'tayayuyu', 'itori', 'yu']:
        print(m, placement('oa:item/' + m))
