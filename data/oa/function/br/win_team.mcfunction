execute unless score #state br.state matches 1 run return 0
tag @a[tag=br.winner] remove br.winner
execute as @a[tag=br.alive,limit=1] run scoreboard players operation #winner oa.team = @s oa.team
execute as @a[tag=br.playing] if score @s oa.team = #winner oa.team run tag @s add br.winner
tellraw @a[tag=br.playing] [{text:"★ 優勝チーム：",color:"gold",bold:true},{score:{name:"#winner",objective:"oa.team"}},{text:" ／ "},{selector:"@a[tag=br.winner]"}]
title @a[tag=br.playing] times 10 90 20
title @a[tag=br.playing] subtitle [{text:"チーム "},{score:{name:"#winner",objective:"oa.team"}},{text:"："},{selector:"@a[tag=br.winner]"}]
title @a[tag=br.playing,tag=br.winner] title {text:"チーム優勝！",color:"gold",bold:true}
execute as @a[tag=br.winner] run function oa:ach/give {id:"winner",name:"最後の一人"}
execute as @a[tag=br.winner] run function oa:ach/map_win
function oa:br/result/show
execute as @a[tag=br.playing,tag=!br.winner] run function oa:br/result/placement_title
function oa:br/celebration/start
# 1.9.192: たやゆゆの大当たりで決着したら、優勝のタイトルのあとに「たやゆゆの勝ち」
execute if score #g_jp_win oa.tmp matches 1 run schedule function oa:tayayuyu/jackpot_title 20t replace
scoreboard players set #g_jp_win oa.tmp 0
