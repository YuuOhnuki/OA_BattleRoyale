tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：足が棒",color:"red"}
tellraw @a[tag=br.playing] {"text": " → 使用者だけ：移動速度−80%・ジャンプ不可（10秒）", "color": "gray"}
function oa:tayayuyu/self_glow
attribute @s minecraft:movement_speed modifier remove oa:gacha_stiff
attribute @s minecraft:jump_strength modifier remove oa:gacha_stiff
attribute @s minecraft:movement_speed modifier add oa:gacha_stiff -0.8 add_multiplied_total
attribute @s minecraft:jump_strength modifier add oa:gacha_stiff -1 add_multiplied_total
scoreboard players set @s oa.gstiff 200
tag @s add oa.gacha_stiff
tag @s add oa.gacha_affected
