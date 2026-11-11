execute if score @s oa.i_unlock matches 2 run tellraw @s {"text": "昭心 Ⅱ に強化！ イネファ：洗浄モード・定常周波数 を解放（次の周回から）", "color": "light_purple"}
execute if score @s oa.i_unlock matches 3 run tellraw @s {"text": "昭心 Ⅲ に強化！ ヴァレサ：シャイニングヴェント！ を解放（次の周回から）", "color": "light_purple"}
execute if score @s oa.i_unlock matches 4 run tellraw @s {"text": "昭心 Ⅳ に強化！ シロネン：ヨワル・スクラッチ を解放（次の周回から）", "color": "light_purple"}
execute if score @s oa.i_unlock matches 5 run tellraw @s {"text": "昭心 Ⅴ に強化！ フリンズ：古律・孤灯の秘密 を解放（次の周回から）", "color": "light_purple"}
execute if score @s oa.i_unlock matches 6 run tellraw @s {"text": "昭心 Ⅵ に強化！ マーヴィカ：天を焦がす刻 を解放（次の周回から）", "color": "light_purple"}
playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 0.7 1.2
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 1.0 1.6
particle minecraft:enchant ~ ~1 ~ 0.5 0.7 0.5 0.3 32 normal @s
particle minecraft:end_rod ~ ~0.8 ~ 0.45 0.6 0.45 0.04 18 normal @s
particle minecraft:dust{color:[0.75,0.25,1.0],scale:1.2} ~ ~1 ~ 0.55 0.8 0.55 0 28 normal @s
