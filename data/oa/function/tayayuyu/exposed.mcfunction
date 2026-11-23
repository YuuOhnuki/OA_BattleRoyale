tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：完全無防備",color:"#12a88f"}
tellraw @a[tag=br.playing] {"text": " → 使用者は30秒 攻撃不可・被ダメ2倍", "color": "gray"}
function oa:tayayuyu/self_glow
attribute @s minecraft:attack_damage modifier remove oa:gacha_exposed
attribute @s minecraft:entity_interaction_range modifier remove oa:gacha_exposed
attribute @s minecraft:attack_damage modifier add oa:gacha_exposed -1 add_multiplied_total
attribute @s minecraft:entity_interaction_range modifier add oa:gacha_exposed -1 add_multiplied_total
# 1.9.192: 30秒
scoreboard players set @s oa.gexpose 600
scoreboard players add @s oa.ex_taken 0
scoreboard players add @s oa.ex_absorb 0
scoreboard players operation @s oa.ex_prev = @s oa.ex_taken
scoreboard players operation @s oa.ex_aprev = @s oa.ex_absorb
advancement revoke @s only oa:tayayuyu/exposed_hurt
tag @s add oa.gacha_exposed
tag @s add oa.gacha_affected
