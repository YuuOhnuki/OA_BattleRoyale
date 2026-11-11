kill @e[tag=oa.practice_entry,distance=..40]
setblock ~0 ~0 ~15 minecraft:chiseled_stone_bricks
setblock ~0 ~1 ~15 minecraft:stone_button[face=floor,facing=north,powered=false]
scoreboard players set #practice_gate oa.tmp 0
summon minecraft:marker ~0.5 ~1 ~15.5 {Tags:["oa.physical_button","oa.practice_entry","oa.gallery"],data:{action:"practice/enter"}}
summon minecraft:text_display ~0.5 ~2.25 ~15.5 {"Tags": ["oa.practice_entry", "oa.lobby_label", "oa.gallery"], "text": {"text": "武器練習場　［ボタン］", "color": "gold", "bold": true}, "billboard": "center", "shadow": true, "view_range": 0.5}

setblock ~-1 ~0 ~15 minecraft:chiseled_stone_bricks
setblock ~1 ~0 ~15 minecraft:chiseled_stone_bricks
setblock ~-1 ~1 ~15 minecraft:lantern
setblock ~1 ~1 ~15 minecraft:lantern
