execute unless score #state br.state matches 1 run return run function oa:br/bars/hide
bossbar set oa:pvp_grace players @a[tag=br.playing]
bossbar set oa:zone_timer players @a[tag=br.playing]
scoreboard players set #bar20 br.tmp 20
scoreboard players set #bar_grace br.tmp 1200
scoreboard players operation #bar_grace br.tmp -= #time br.time
execute if score #bar_grace br.tmp matches 1.. run scoreboard players add #bar_grace br.tmp 19
execute if score #bar_grace br.tmp matches 1.. run scoreboard players operation #bar_grace br.tmp /= #bar20 br.tmp
execute if score #time br.time matches ..1199 run bossbar set oa:pvp_grace visible true
execute if score #time br.time matches 1200.. run bossbar set oa:pvp_grace visible false
execute if score #time br.time matches ..1199 store result bossbar oa:pvp_grace value run scoreboard players get #bar_grace br.tmp
bossbar set oa:pvp_grace name [{text:"保護期間終了まで： ",color:"green"},{score:{name:"#bar_grace",objective:"br.tmp"}},{text:"秒"}]
execute if score #time br.time matches 13200.. run bossbar set oa:zone_timer visible false
execute if score #time br.time matches 13200.. run return 0
bossbar set oa:zone_timer visible false
execute if score #time br.time matches 2400..3599 run bossbar set oa:zone_timer visible true
execute if score #time br.time matches 4800..5999 run bossbar set oa:zone_timer visible true
execute if score #time br.time matches 7200..8399 run bossbar set oa:zone_timer visible true
execute if score #time br.time matches 10800..13199 run bossbar set oa:zone_timer visible true
execute if score #time br.time matches 0..2399 run scoreboard players set #bar_end br.tmp 2400
execute if score #time br.time matches 0..2399 run bossbar set oa:zone_timer max 120
execute if score #time br.time matches 0..2399 run bossbar set oa:zone_timer color blue
execute if score #time br.time matches 2400..3599 run scoreboard players set #bar_end br.tmp 3600
execute if score #time br.time matches 2400..3599 run bossbar set oa:zone_timer max 60
execute if score #time br.time matches 2400..3599 run bossbar set oa:zone_timer color red
execute if score #time br.time matches 3600..4799 run scoreboard players set #bar_end br.tmp 4800
execute if score #time br.time matches 3600..4799 run bossbar set oa:zone_timer max 60
execute if score #time br.time matches 3600..4799 run bossbar set oa:zone_timer color blue
execute if score #time br.time matches 4800..5999 run scoreboard players set #bar_end br.tmp 6000
execute if score #time br.time matches 4800..5999 run bossbar set oa:zone_timer max 60
execute if score #time br.time matches 4800..5999 run bossbar set oa:zone_timer color red
execute if score #time br.time matches 6000..7199 run scoreboard players set #bar_end br.tmp 7200
execute if score #time br.time matches 6000..7199 run bossbar set oa:zone_timer max 60
execute if score #time br.time matches 6000..7199 run bossbar set oa:zone_timer color blue
execute if score #time br.time matches 7200..8399 run scoreboard players set #bar_end br.tmp 8400
execute if score #time br.time matches 7200..8399 run bossbar set oa:zone_timer max 60
execute if score #time br.time matches 7200..8399 run bossbar set oa:zone_timer color red
execute if score #time br.time matches 8400..10799 run scoreboard players set #bar_end br.tmp 10800
execute if score #time br.time matches 8400..10799 run bossbar set oa:zone_timer max 120
execute if score #time br.time matches 8400..10799 run bossbar set oa:zone_timer color blue
execute if score #time br.time matches 10800..11999 run scoreboard players set #bar_end br.tmp 12000
execute if score #time br.time matches 10800..11999 run bossbar set oa:zone_timer max 60
execute if score #time br.time matches 10800..11999 run bossbar set oa:zone_timer color red
execute if score #time br.time matches 12000..13199 run scoreboard players set #bar_end br.tmp 13200
execute if score #time br.time matches 12000..13199 run bossbar set oa:zone_timer max 60
execute if score #time br.time matches 12000..13199 run bossbar set oa:zone_timer color red
scoreboard players operation #bar_left br.tmp = #bar_end br.tmp
scoreboard players operation #bar_left br.tmp -= #time br.time
scoreboard players add #bar_left br.tmp 19
scoreboard players operation #bar_left br.tmp /= #bar20 br.tmp
execute store result bossbar oa:zone_timer value run scoreboard players get #bar_left br.tmp
execute if score #time br.time matches 2400..3599 run bossbar set oa:zone_timer name [{text:"安置収縮完了まで： ",color:"red"},{score:{name:"#bar_left",objective:"br.tmp"}},{text:"秒"}]
execute if score #time br.time matches 4800..5999 run bossbar set oa:zone_timer name [{text:"安置収縮完了まで： ",color:"red"},{score:{name:"#bar_left",objective:"br.tmp"}},{text:"秒"}]
execute if score #time br.time matches 7200..8399 run bossbar set oa:zone_timer name [{text:"安置収縮完了まで： ",color:"red"},{score:{name:"#bar_left",objective:"br.tmp"}},{text:"秒"}]
execute if score #time br.time matches 10800..11999 run bossbar set oa:zone_timer name [{text:"安置収縮完了まで： ",color:"red"},{score:{name:"#bar_left",objective:"br.tmp"}},{text:"秒"}]
execute if score #time br.time matches 12000..13199 run bossbar set oa:zone_timer name [{text:"安置収縮完了まで： ",color:"red"},{score:{name:"#bar_left",objective:"br.tmp"}},{text:"秒"}]

execute if score #time br.time matches 2200..2399 run function oa:br/bars/pre_shrink
execute if score #time br.time matches 4600..4799 run function oa:br/bars/pre_shrink
execute if score #time br.time matches 7000..7199 run function oa:br/bars/pre_shrink
execute if score #time br.time matches 10600..10799 run function oa:br/bars/pre_shrink
