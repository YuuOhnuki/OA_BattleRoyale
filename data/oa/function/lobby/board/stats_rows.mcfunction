# 1.9.162: 順位の行は、該当する人がいるときだけ出す（以前は人数に関係なく全行を出していた）
tag @a remove oa.bs1
tag @a remove oa.bs2
tag @a remove oa.bs3
tag @a remove oa.bs4
tag @a remove oa.bs5
tag @a remove oa.bs6
tag @a remove oa.b_un
tag @a remove oa.b_cand
tag @a[tag=br.lobby_now] add oa.b_un
kill @e[type=minecraft:text_display,tag=oa.board_stats]
summon minecraft:text_display ~-6 ~4.9 ~-35.4 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[0f,0f],billboard:"fixed",text:{text:"戦績（オンライン）",color:"gold",bold:true},background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.1f,1.1f,1.1f]}}
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] run scoreboard players operation #max oa.tmp > @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.bs1
execute if entity @a[tag=oa.bs1,limit=1] run summon minecraft:text_display ~-6 ~4.2 ~-35.4 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"1. ",color:"gold"},{selector:"@a[tag=oa.bs1,limit=1]"},{text:"  勝",color:"gray"},{score:{name:"@a[tag=oa.bs1,limit=1]",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@a[tag=oa.bs1,limit=1]",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@a[tag=oa.bs1,limit=1]",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] run scoreboard players operation #max oa.tmp > @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.bs2
execute if entity @a[tag=oa.bs2,limit=1] run summon minecraft:text_display ~-6 ~3.7 ~-35.4 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"2. ",color:"gold"},{selector:"@a[tag=oa.bs2,limit=1]"},{text:"  勝",color:"gray"},{score:{name:"@a[tag=oa.bs2,limit=1]",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@a[tag=oa.bs2,limit=1]",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@a[tag=oa.bs2,limit=1]",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] run scoreboard players operation #max oa.tmp > @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.bs3
execute if entity @a[tag=oa.bs3,limit=1] run summon minecraft:text_display ~-6 ~3.2 ~-35.4 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"3. ",color:"gold"},{selector:"@a[tag=oa.bs3,limit=1]"},{text:"  勝",color:"gray"},{score:{name:"@a[tag=oa.bs3,limit=1]",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@a[tag=oa.bs3,limit=1]",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@a[tag=oa.bs3,limit=1]",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] run scoreboard players operation #max oa.tmp > @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.bs4
execute if entity @a[tag=oa.bs4,limit=1] run summon minecraft:text_display ~-6 ~2.7 ~-35.4 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"4. ",color:"gold"},{selector:"@a[tag=oa.bs4,limit=1]"},{text:"  勝",color:"gray"},{score:{name:"@a[tag=oa.bs4,limit=1]",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@a[tag=oa.bs4,limit=1]",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@a[tag=oa.bs4,limit=1]",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] run scoreboard players operation #max oa.tmp > @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.bs5
execute if entity @a[tag=oa.bs5,limit=1] run summon minecraft:text_display ~-6 ~2.2 ~-35.4 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"5. ",color:"gold"},{selector:"@a[tag=oa.bs5,limit=1]"},{text:"  勝",color:"gray"},{score:{name:"@a[tag=oa.bs5,limit=1]",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@a[tag=oa.bs5,limit=1]",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@a[tag=oa.bs5,limit=1]",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] run scoreboard players operation #max oa.tmp > @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.bs6
execute if entity @a[tag=oa.bs6,limit=1] run summon minecraft:text_display ~-6 ~1.7 ~-35.4 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"6. ",color:"gold"},{selector:"@a[tag=oa.bs6,limit=1]"},{text:"  勝",color:"gray"},{score:{name:"@a[tag=oa.bs6,limit=1]",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@a[tag=oa.bs6,limit=1]",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@a[tag=oa.bs6,limit=1]",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
