execute store result score #weather_roll br.tmp run random value 1..100
execute if score #weather_roll br.tmp matches 1..20 run scoreboard players set #weather_target br.tmp 1
execute if score #weather_roll br.tmp matches 21..90 run scoreboard players set #weather_target br.tmp 0
execute if score #weather_roll br.tmp matches 91..100 run scoreboard players set #weather_target br.tmp 2
execute in oa:br run function oa:br/weather/apply
execute if score #weather_roll br.tmp matches 1..20 run tellraw @a[tag=br.playing] {text:"天候抽選：雨（次の抽選まで3分）",color:"aqua"}
execute if score #weather_roll br.tmp matches 21..90 run tellraw @a[tag=br.playing] {text:"天候抽選：晴れ（次の抽選まで3分）",color:"yellow"}
execute if score #weather_roll br.tmp matches 91..100 run tellraw @a[tag=br.playing] {text:"天候抽選：雷雨（次の抽選まで3分）",color:"dark_aqua"}
