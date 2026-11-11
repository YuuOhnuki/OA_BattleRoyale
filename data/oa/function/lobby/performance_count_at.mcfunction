scoreboard players set #l_models oa.tmp 0
execute positioned ~-40 ~-3 ~-40 as @e[type=minecraft:mannequin,dx=80,dy=47,dz=80] run scoreboard players add #l_models oa.tmp 1
scoreboard players set #l_text oa.tmp 0
execute positioned ~-40 ~-3 ~-40 as @e[type=minecraft:text_display,dx=80,dy=47,dz=80] run scoreboard players add #l_text oa.tmp 1
scoreboard players set #l_items oa.tmp 0
execute positioned ~-40 ~-3 ~-40 as @e[type=minecraft:item_display,dx=80,dy=47,dz=80] run scoreboard players add #l_items oa.tmp 1
scoreboard players set #l_buttons oa.tmp 0
execute positioned ~-40 ~-3 ~-40 as @e[type=minecraft:interaction,dx=80,dy=47,dz=80] run scoreboard players add #l_buttons oa.tmp 1
tellraw @a[tag=br.admin] [{"text": "ロビー内：", "color": "gold"}, {"text": "展示人形 "}, {"score": {"name": "#l_models", "objective": "oa.tmp"}}, {"text": " / 文字 "}, {"score": {"name": "#l_text", "objective": "oa.tmp"}}, {"text": " / アイテム表示 "}, {"score": {"name": "#l_items", "objective": "oa.tmp"}}, {"text": " / 操作判定 "}, {"score": {"name": "#l_buttons", "objective": "oa.tmp"}}]
