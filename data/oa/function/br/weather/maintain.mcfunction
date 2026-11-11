scoreboard players set #weather_actual br.tmp 0
execute if predicate oa:weather/rain run scoreboard players set #weather_actual br.tmp 1
execute if predicate oa:weather/thunder run scoreboard players set #weather_actual br.tmp 2
execute unless score #weather_actual br.tmp = #weather_target br.tmp run function oa:br/weather/apply
