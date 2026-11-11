scoreboard players remove @a[scores={oa.hcool=1..}] oa.hcool 1
execute as @a[tag=oa.player,gamemode=!spectator,scores={oa.jump=1..}] at @s if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:2}}] run function oa:hotchikisu/fish_jump
execute as @a[tag=oa.player,gamemode=!spectator,scores={oa.jump=1..}] at @s unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:2}}] if items entity @s weapon.offhand *[minecraft:custom_data~{oa:{kind:2}}] run function oa:hotchikisu/fish_jump
scoreboard players set @a oa.jump 0
