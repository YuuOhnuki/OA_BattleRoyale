"""Rough page-fit check for written books (default font).

Page text area: 114 px wide, 14 lines. Widths: CJK / full-width 9 px, ASCII ~6 px (narrow letters 2-4),
space 4 px, bold +1 px per glyph. Words do not matter for Japanese; ASCII words wrap as a unit.
The estimate errs on the wide side so a page that passes here fits in the client.
"""
import unicodedata

WIDTH, LINES = 114, 14
NARROW = {'i': 2, 'l': 3, '!': 2, '.': 2, ',': 2, ':': 2, ';': 2, "'": 2, '|': 2, 't': 4, 'I': 4, ' ': 4, '[': 4, ']': 4, '(': 5, ')': 5, 'f': 5, 'k': 5}

def glyph(ch, bold):
    if unicodedata.east_asian_width(ch) in ('W', 'F', 'A') or ord(ch) > 0x2E80:
        w = 9
    else:
        w = NARROW.get(ch, 6)
    return w + (1 if bold else 0)

def lines_used(parts):
    """parts: list of (text, bold). Returns the number of rendered lines."""
    lines, x = 1, 0
    for text, bold in parts:
        for ch in text:
            if ch == '\n':
                lines += 1; x = 0; continue
            w = glyph(ch, bold)
            if x + w > WIDTH:
                lines += 1; x = 0
            x += w
    return lines

def check_page(extra):
    parts = []
    for e in extra:
        parts.append((e.get('text', ''), bool(e.get('bold'))))
    n = lines_used(parts)
    assert n <= LINES, (n, ''.join(p[0] for p in parts)[:60])
    return n
