execute if score #mode br.mode matches 1 if entity @s[tag=br.alive,gamemode=!spectator] run return run function oa:br/locator/killing
execute if entity @s[tag=br.alive,gamemode=!spectator] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return run function oa:br/locator/killing
execute if entity @s[tag=br.loc_shown] run attribute @s minecraft:waypoint_receive_range modifier remove oa:br_receive
tag @s remove br.loc_shown
execute unless entity @s[tag=br.loc_hidden] run function oa:br/locator/hide
