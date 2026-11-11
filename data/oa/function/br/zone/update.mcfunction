function oa:br/zone/shrink
execute if score #sec br.sec matches 601.. run function oa:br/zone/overtime
scoreboard players operation #minx br.x = #cx br.x
scoreboard players operation #maxx br.x = #cx br.x
scoreboard players operation #minz br.z = #cz br.z
scoreboard players operation #maxz br.z = #cz br.z
scoreboard players operation #minx br.x -= #half br.tmp
scoreboard players operation #maxx br.x += #half br.tmp
scoreboard players operation #minz br.z -= #half br.tmp
scoreboard players operation #maxz br.z += #half br.tmp
scoreboard players operation #width br.tmp = #half br.tmp
scoreboard players add #width br.tmp 0
scoreboard players operation #width br.tmp *= #two br.tmp
scoreboard players operation #width br.tmp /= #1000 br.tmp
execute store result storage oa:br_zone minx double 0.001 run scoreboard players get #minx br.x
execute store result storage oa:br_zone maxx double 0.001 run scoreboard players get #maxx br.x
execute store result storage oa:br_zone minz double 0.001 run scoreboard players get #minz br.z
execute store result storage oa:br_zone maxz double 0.001 run scoreboard players get #maxz br.z
data modify storage oa:br_zone damage set value 2
execute if score #sec br.sec matches 360.. run data modify storage oa:br_zone damage set value 4
execute if score #sec br.sec matches 480.. run data modify storage oa:br_zone damage set value 6
execute if score #sec br.sec matches 600.. run data modify storage oa:br_zone damage set value 10
