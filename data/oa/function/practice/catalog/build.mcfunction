# Generated practice pickup migration; controls and saved player inventory are preserved.
kill @e[tag=oa.practice_pick]
kill @e[tag=oa.practice_catalog]
setblock ~-13 ~1 ~14 minecraft:air
setblock ~-14 ~1 ~15 minecraft:air
setblock ~-12 ~1 ~15 minecraft:air
setblock ~-13 ~1 ~16 minecraft:air
setblock ~-9 ~1 ~14 minecraft:air
setblock ~-10 ~1 ~15 minecraft:air
setblock ~-8 ~1 ~15 minecraft:air
setblock ~-9 ~1 ~16 minecraft:air
setblock ~-5 ~1 ~14 minecraft:air
setblock ~-6 ~1 ~15 minecraft:air
setblock ~-4 ~1 ~15 minecraft:air
setblock ~-5 ~1 ~16 minecraft:air
setblock ~5 ~1 ~14 minecraft:air
setblock ~4 ~1 ~15 minecraft:air
setblock ~6 ~1 ~15 minecraft:air
setblock ~5 ~1 ~16 minecraft:air
setblock ~9 ~1 ~14 minecraft:air
setblock ~8 ~1 ~15 minecraft:air
setblock ~10 ~1 ~15 minecraft:air
setblock ~9 ~1 ~16 minecraft:air
setblock ~13 ~1 ~14 minecraft:air
setblock ~12 ~1 ~15 minecraft:air
setblock ~14 ~1 ~15 minecraft:air
setblock ~13 ~1 ~16 minecraft:air
setblock ~-13 ~1 ~18 minecraft:air
setblock ~-14 ~1 ~19 minecraft:air
setblock ~-12 ~1 ~19 minecraft:air
setblock ~-13 ~1 ~20 minecraft:air
setblock ~-9 ~1 ~18 minecraft:air
setblock ~-10 ~1 ~19 minecraft:air
setblock ~-8 ~1 ~19 minecraft:air
setblock ~-9 ~1 ~20 minecraft:air
setblock ~-5 ~1 ~18 minecraft:air
setblock ~-6 ~1 ~19 minecraft:air
setblock ~-4 ~1 ~19 minecraft:air
setblock ~-5 ~1 ~20 minecraft:air
setblock ~5 ~1 ~18 minecraft:air
setblock ~4 ~1 ~19 minecraft:air
setblock ~6 ~1 ~19 minecraft:air
setblock ~5 ~1 ~20 minecraft:air
setblock ~9 ~1 ~18 minecraft:air
setblock ~8 ~1 ~19 minecraft:air
setblock ~10 ~1 ~19 minecraft:air
setblock ~9 ~1 ~20 minecraft:air
setblock ~13 ~1 ~18 minecraft:air
setblock ~12 ~1 ~19 minecraft:air
setblock ~14 ~1 ~19 minecraft:air
setblock ~13 ~1 ~20 minecraft:air
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_1"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_2"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_3"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_4"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_5"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_6"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_7"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_8"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_9"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_10"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_11"}}]
kill @e[type=minecraft:marker,tag=oa.button_practice,nbt={data:{action:"practice/click/weapon_12"}}]
summon minecraft:interaction ~-12.5 ~1 ~15.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.1"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~-8.5 ~1 ~15.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.2"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~-4.5 ~1 ~15.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.3"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~5.5 ~1 ~15.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.4"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~9.5 ~1 ~15.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.5"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~13.5 ~1 ~15.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.6"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~-12.5 ~1 ~19.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.7"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~-8.5 ~1 ~19.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.8"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~-4.5 ~1 ~19.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.9"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~5.5 ~1 ~19.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.10"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~9.5 ~1 ~19.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.11"],"width":1.2,"height":2.0,"response":true}
summon minecraft:interaction ~13.5 ~1 ~19.5 {"Tags":["oa.practice_pick","oa.practice.pick.weapon.12"],"width":1.2,"height":2.0,"response":true}
setblock ~-30 ~1 ~26 minecraft:chiseled_quartz_block
setblock ~-30 ~0 ~26 minecraft:sea_lantern
summon minecraft:item_display ~-29.5 ~2.35 ~26.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:arrow","count":1,"components":{"minecraft:max_stack_size":64}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-29.5 ~1 ~26.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.0"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-29.5 ~3.15 ~26.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.arrow"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-26 ~1 ~26 minecraft:chiseled_quartz_block
setblock ~-26 ~0 ~26 minecraft:sea_lantern
summon minecraft:item_display ~-25.5 ~2.35 ~26.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:bow","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-25.5 ~1 ~26.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.1"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-25.5 ~3.15 ~26.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.bow"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-22 ~1 ~26 minecraft:chiseled_quartz_block
setblock ~-22 ~0 ~26 minecraft:sea_lantern
summon minecraft:item_display ~-21.5 ~2.35 ~26.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:crossbow","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-21.5 ~1 ~26.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.2"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-21.5 ~3.15 ~26.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.crossbow"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-18 ~1 ~26 minecraft:chiseled_quartz_block
setblock ~-18 ~0 ~26 minecraft:sea_lantern
summon minecraft:item_display ~-17.5 ~2.35 ~26.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:diamond_sword","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-17.5 ~1 ~26.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.3"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-17.5 ~3.15 ~26.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.diamond_sword"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~18 ~1 ~26 minecraft:chiseled_quartz_block
setblock ~18 ~0 ~26 minecraft:sea_lantern
summon minecraft:item_display ~18.5 ~2.35 ~26.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:iron_axe","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~18.5 ~1 ~26.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.4"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~18.5 ~3.15 ~26.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.iron_axe"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~22 ~1 ~26 minecraft:chiseled_quartz_block
setblock ~22 ~0 ~26 minecraft:sea_lantern
summon minecraft:item_display ~22.5 ~2.35 ~26.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:iron_spear","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~22.5 ~1 ~26.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.5"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~22.5 ~3.15 ~26.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.iron_spear"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~26 ~1 ~26 minecraft:chiseled_quartz_block
setblock ~26 ~0 ~26 minecraft:sea_lantern
summon minecraft:item_display ~26.5 ~2.35 ~26.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:iron_sword","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~26.5 ~1 ~26.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.6"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~26.5 ~3.15 ~26.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.iron_sword"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~30 ~1 ~26 minecraft:chiseled_quartz_block
setblock ~30 ~0 ~26 minecraft:sea_lantern
summon minecraft:item_display ~30.5 ~2.35 ~26.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:shield","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~30.5 ~1 ~26.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.7"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~30.5 ~3.15 ~26.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.shield"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-30 ~1 ~30 minecraft:chiseled_quartz_block
setblock ~-30 ~0 ~30 minecraft:sea_lantern
summon minecraft:item_display ~-29.5 ~2.35 ~30.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:stick","count":1,"components":{"minecraft:custom_name":{"text":"木のノックバック棒","color":"yellow","italic":false},"minecraft:enchantments":{"minecraft:knockback":2},"minecraft:custom_data":{"oa_normal":"kb_stick"},"minecraft:lore":[{"text":"通常武器／固有装備の所持制限対象外","color":"gray","italic":false}],"minecraft:max_stack_size":1}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-29.5 ~1 ~30.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.8"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-29.5 ~3.15 ~30.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"text":"木のノックバック棒","color":"yellow","italic":false},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-26 ~1 ~30 minecraft:chiseled_quartz_block
setblock ~-26 ~0 ~30 minecraft:sea_lantern
summon minecraft:item_display ~-25.5 ~2.35 ~30.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:stick","count":1,"components":{"minecraft:custom_name":{"text":"木のバット","color":"gold","italic":false},"minecraft:enchantments":{"oa:bat":1},"minecraft:custom_data":{"oa_normal":"bat"},"minecraft:lore":[{"text":"通常武器／固有装備の所持制限対象外","color":"gray","italic":false}],"minecraft:item_model":"oa:wooden_bat","minecraft:max_stack_size":1}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-25.5 ~1 ~30.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.9"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-25.5 ~3.15 ~30.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"text":"木のバット","color":"gold","italic":false},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-22 ~1 ~30 minecraft:chiseled_quartz_block
setblock ~-22 ~0 ~30 minecraft:sea_lantern
summon minecraft:item_display ~-21.5 ~2.35 ~30.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:stone_axe","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-21.5 ~1 ~30.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.10"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-21.5 ~3.15 ~30.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.stone_axe"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-18 ~1 ~30 minecraft:chiseled_quartz_block
setblock ~-18 ~0 ~30 minecraft:sea_lantern
summon minecraft:item_display ~-17.5 ~2.35 ~30.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:stone_sword","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-17.5 ~1 ~30.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.11"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-17.5 ~3.15 ~30.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.stone_sword"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~18 ~1 ~30 minecraft:chiseled_quartz_block
setblock ~18 ~0 ~30 minecraft:sea_lantern
summon minecraft:item_display ~18.5 ~2.35 ~30.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:wooden_axe","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~18.5 ~1 ~30.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.12"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~18.5 ~3.15 ~30.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.wooden_axe"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~22 ~1 ~30 minecraft:chiseled_quartz_block
setblock ~22 ~0 ~30 minecraft:sea_lantern
summon minecraft:item_display ~22.5 ~2.35 ~30.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:wooden_sword","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~22.5 ~1 ~30.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.13"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~22.5 ~3.15 ~30.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.wooden_sword"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~26 ~1 ~30 minecraft:chiseled_quartz_block
setblock ~26 ~0 ~30 minecraft:sea_lantern
summon minecraft:item_display ~26.5 ~2.35 ~30.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:chainmail_boots","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~26.5 ~1 ~30.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.14"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~26.5 ~3.15 ~30.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.chainmail_boots"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~30 ~1 ~30 minecraft:chiseled_quartz_block
setblock ~30 ~0 ~30 minecraft:sea_lantern
summon minecraft:item_display ~30.5 ~2.35 ~30.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:chainmail_chestplate","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~30.5 ~1 ~30.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.15"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~30.5 ~3.15 ~30.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.chainmail_chestplate"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-30 ~1 ~34 minecraft:chiseled_quartz_block
setblock ~-30 ~0 ~34 minecraft:sea_lantern
summon minecraft:item_display ~-29.5 ~2.35 ~34.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:chainmail_helmet","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-29.5 ~1 ~34.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.16"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-29.5 ~3.15 ~34.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.chainmail_helmet"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-26 ~1 ~34 minecraft:chiseled_quartz_block
setblock ~-26 ~0 ~34 minecraft:sea_lantern
summon minecraft:item_display ~-25.5 ~2.35 ~34.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:chainmail_leggings","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-25.5 ~1 ~34.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.17"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-25.5 ~3.15 ~34.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.chainmail_leggings"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-22 ~1 ~34 minecraft:chiseled_quartz_block
setblock ~-22 ~0 ~34 minecraft:sea_lantern
summon minecraft:item_display ~-21.5 ~2.35 ~34.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:diamond_boots","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-21.5 ~1 ~34.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.18"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-21.5 ~3.15 ~34.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.diamond_boots"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-18 ~1 ~34 minecraft:chiseled_quartz_block
setblock ~-18 ~0 ~34 minecraft:sea_lantern
summon minecraft:item_display ~-17.5 ~2.35 ~34.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:diamond_chestplate","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-17.5 ~1 ~34.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.19"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-17.5 ~3.15 ~34.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.diamond_chestplate"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~18 ~1 ~34 minecraft:chiseled_quartz_block
setblock ~18 ~0 ~34 minecraft:sea_lantern
summon minecraft:item_display ~18.5 ~2.35 ~34.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:diamond_helmet","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~18.5 ~1 ~34.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.20"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~18.5 ~3.15 ~34.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.diamond_helmet"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~22 ~1 ~34 minecraft:chiseled_quartz_block
setblock ~22 ~0 ~34 minecraft:sea_lantern
summon minecraft:item_display ~22.5 ~2.35 ~34.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:diamond_leggings","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~22.5 ~1 ~34.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.21"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~22.5 ~3.15 ~34.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.diamond_leggings"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~26 ~1 ~34 minecraft:chiseled_quartz_block
setblock ~26 ~0 ~34 minecraft:sea_lantern
summon minecraft:item_display ~26.5 ~2.35 ~34.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:iron_boots","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~26.5 ~1 ~34.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.22"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~26.5 ~3.15 ~34.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.iron_boots"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~30 ~1 ~34 minecraft:chiseled_quartz_block
setblock ~30 ~0 ~34 minecraft:sea_lantern
summon minecraft:item_display ~30.5 ~2.35 ~34.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:iron_chestplate","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~30.5 ~1 ~34.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.23"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~30.5 ~3.15 ~34.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.iron_chestplate"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-30 ~1 ~38 minecraft:chiseled_quartz_block
setblock ~-30 ~0 ~38 minecraft:sea_lantern
summon minecraft:item_display ~-29.5 ~2.35 ~38.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:iron_helmet","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-29.5 ~1 ~38.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.24"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-29.5 ~3.15 ~38.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.iron_helmet"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-26 ~1 ~38 minecraft:chiseled_quartz_block
setblock ~-26 ~0 ~38 minecraft:sea_lantern
summon minecraft:item_display ~-25.5 ~2.35 ~38.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:iron_leggings","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-25.5 ~1 ~38.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.25"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-25.5 ~3.15 ~38.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.iron_leggings"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-22 ~1 ~38 minecraft:chiseled_quartz_block
setblock ~-22 ~0 ~38 minecraft:sea_lantern
summon minecraft:item_display ~-21.5 ~2.35 ~38.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:leather_boots","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-21.5 ~1 ~38.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.26"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-21.5 ~3.15 ~38.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.leather_boots"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~-18 ~1 ~38 minecraft:chiseled_quartz_block
setblock ~-18 ~0 ~38 minecraft:sea_lantern
summon minecraft:item_display ~-17.5 ~2.35 ~38.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:leather_chestplate","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~-17.5 ~1 ~38.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.27"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~-17.5 ~3.15 ~38.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.leather_chestplate"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~18 ~1 ~38 minecraft:chiseled_quartz_block
setblock ~18 ~0 ~38 minecraft:sea_lantern
summon minecraft:item_display ~18.5 ~2.35 ~38.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:leather_helmet","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~18.5 ~1 ~38.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.28"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~18.5 ~3.15 ~38.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.leather_helmet"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
setblock ~22 ~1 ~38 minecraft:chiseled_quartz_block
setblock ~22 ~0 ~38 minecraft:sea_lantern
summon minecraft:item_display ~22.5 ~2.35 ~38.5 {"Tags":["oa.practice_catalog"],"item":{"id":"minecraft:leather_leggings","count":1,"components":{}},"item_display":"fixed","billboard":"center","brightness":{"block":15,"sky":15},"transformation":{"scale":[0.65,0.65,0.65]},"view_range":0.6}
summon minecraft:interaction ~22.5 ~1 ~38.5 {"Tags":["oa.practice_pick","oa.practice.pick.normal.29"],"width":1.2,"height":2.0,"response":true}
summon minecraft:text_display ~22.5 ~3.15 ~38.5 {"Tags":["oa.practice_catalog"],"text":{"text":"","extra":[{"translate":"item.minecraft.leather_leggings"},{"text":"\n右クリックで受け取る","color":"gray"}]},"billboard":"center","line_width":140,"view_range":0.5,"transformation":{"scale":[0.65,0.65,0.65]}}
data modify storage oa:practice catalog set value 209
