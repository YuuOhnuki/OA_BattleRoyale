scoreboard players set #hfound oa.tmp 0
tag @s add oa.h_event
execute as @a[tag=!oa.h_event,gamemode=!spectator] if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set #hfound oa.tmp 1
execute as @a[tag=!oa.h_event,gamemode=!spectator] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:7}}] run scoreboard players set #hfound oa.tmp 1
tag @s remove oa.h_event
