execute as @a[tag=oa.lobby_safe] run attribute @s minecraft:fall_damage_multiplier modifier remove oa:lobby_fall
tag @a remove oa.lobby_safe
tag @a remove br.lobby_now
tag @a remove br.in_lobby
tag @a remove br.pad_latched
