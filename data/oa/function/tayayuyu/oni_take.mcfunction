# 1.9.192: 時限爆弾の鬼になる（本人として）。頭にTNT（表示のエンティティ）、鬼だけ発光、移動速度＋200%。押しつけ直後の1秒は押しつけ返せない
tag @s add oa.g_oni
scoreboard players set @s oa.goni_cd 20
attribute @s minecraft:movement_speed modifier remove oa:gacha_oni
attribute @s minecraft:movement_speed modifier add oa:gacha_oni 2.0 add_multiplied_total
effect give @s minecraft:glowing 2 0 true
kill @e[type=minecraft:item_display,tag=oa.g_oni_hat]
function oa:tayayuyu/oni_hat
advancement revoke @s only oa:tayayuyu/oni_pass
title @s times 5 30 10
title @s subtitle {text:"殴って押しつけろ！",color:"yellow"}
title @s title {text:"💣 鬼になった",color:"red",bold:true}
particle minecraft:large_smoke ~ ~2 ~ 0.3 0.3 0.3 0.05 20 normal @a[distance=..32]
particle minecraft:flame ~ ~2 ~ 0.3 0.3 0.3 0.05 20 normal @a[distance=..32]
playsound minecraft:entity.tnt.primed player @a[distance=..32] ~ ~ ~ 1.5 1
playsound minecraft:block.note_block.bell player @s ~ ~ ~ 1 0.6
