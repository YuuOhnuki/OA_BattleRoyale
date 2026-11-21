execute if score #active tdm.sys matches 1 run return 0
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
# 1.9.218: 安全地帯はプラグイン。ボスバーは「収縮開始まで」の10秒だけ（#next＝次の収縮までの秒、#shrinking＝収縮中。プラグインが書く）。
# 収縮中はボスバーに出さず、チャットに残り30秒・10秒・完了（プラグイン）
bossbar set oa:zone_timer visible false
execute if score #shrinking br.flag matches 0 if score #next br.tmp matches 1..10 run function oa:br/bars/pre_shrink
