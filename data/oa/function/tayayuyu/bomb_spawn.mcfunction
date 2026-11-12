summon minecraft:block_display ~-0.5 ~ ~-0.5 {Tags:["oa.gacha_bomb","oa.gacha_bomb_new"],block_state:"minecraft:tnt",view_range:1.0}
scoreboard players set @e[tag=oa.gacha_bomb_new] oa.gbomb 20
scoreboard players operation @e[tag=oa.gacha_bomb_new] oa.gby = #gacha_caster oa.tmp
scoreboard players operation @e[tag=oa.gacha_bomb_new] oa.gevent = #gacha_event oa.tmp
scoreboard players operation @e[tag=oa.gacha_bomb_new] br.round = #round br.round
tag @e[tag=oa.gacha_bomb_new] remove oa.gacha_bomb_new
playsound minecraft:entity.tnt.primed player @a[distance=..32] ~ ~ ~ 1 1
