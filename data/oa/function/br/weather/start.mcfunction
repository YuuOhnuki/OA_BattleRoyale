
data modify storage oa:weather backup.kind set value 0
execute in oa:br if predicate oa:weather/rain run data modify storage oa:weather backup.kind set value 1
execute in oa:br if predicate oa:weather/thunder run data modify storage oa:weather backup.kind set value 2
scoreboard players set #weather_target br.tmp 0
execute in oa:br run function oa:br/weather/apply
