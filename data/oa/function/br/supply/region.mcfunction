execute store result score #cx br.tmp run data get storage oa:br center.x
execute store result score #cz br.tmp run data get storage oa:br center.z
scoreboard players operation #rx br.tmp = #mx br.tmp
scoreboard players operation #rx br.tmp -= #cx br.tmp
scoreboard players operation #rz br.tmp = #mz br.tmp
scoreboard players operation #rz br.tmp -= #cz br.tmp
execute if score #map oa.mapid matches 1 run return run function oa:maps/nether/supply_region
data modify storage oa:supply region set value "南の草原"
execute if score #rz br.tmp matches ..-25 if score #rx br.tmp matches -29..29 run data modify storage oa:supply region set value "北の湖のまわり"
execute if score #rx br.tmp matches 30.. run data modify storage oa:supply region set value "東の森"
execute if score #rx br.tmp matches ..-30 run data modify storage oa:supply region set value "西の住宅街"
execute if score #rz br.tmp matches 65.. run data modify storage oa:supply region set value "南の海辺"
execute if score #rz br.tmp matches ..-95 run data modify storage oa:supply region set value "北の雪原"
execute if score #rx br.tmp matches -25..25 if score #rz br.tmp matches -25..25 run data modify storage oa:supply region set value "中央広場"
