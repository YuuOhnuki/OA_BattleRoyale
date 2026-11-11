tag @a remove oa.b_un
tag @a remove oa.b_cand
tag @a[tag=br.lobby_now] add oa.b_un
kill @e[type=minecraft:text_display,tag=oa.board_stats]
summon minecraft:text_display ~22.4 ~4.9 ~-6 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[90f,0f],billboard:"fixed",text:{text:"戦績（オンライン）",color:"gold",bold:true},background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.1f,1.1f,1.1f]}}
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_rank > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run summon minecraft:text_display ~22.4 ~4.2 ~-6 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[90f,0f],billboard:"fixed",text:[{text:"1. ",color:"gold"},{selector:"@s"},{text:"  勝",color:"gray"},{score:{name:"@s",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@s",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@s",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_rank > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run summon minecraft:text_display ~22.4 ~3.7 ~-6 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[90f,0f],billboard:"fixed",text:[{text:"2. ",color:"gold"},{selector:"@s"},{text:"  勝",color:"gray"},{score:{name:"@s",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@s",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@s",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_rank > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run summon minecraft:text_display ~22.4 ~3.2 ~-6 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[90f,0f],billboard:"fixed",text:[{text:"3. ",color:"gold"},{selector:"@s"},{text:"  勝",color:"gray"},{score:{name:"@s",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@s",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@s",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_rank > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run summon minecraft:text_display ~22.4 ~2.7 ~-6 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[90f,0f],billboard:"fixed",text:[{text:"4. ",color:"gold"},{selector:"@s"},{text:"  勝",color:"gray"},{score:{name:"@s",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@s",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@s",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_rank > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run summon minecraft:text_display ~22.4 ~2.2 ~-6 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[90f,0f],billboard:"fixed",text:[{text:"5. ",color:"gold"},{selector:"@s"},{text:"  勝",color:"gray"},{score:{name:"@s",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@s",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@s",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_rank > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_rank
execute as @a[tag=oa.b_un] if score @s oa.t_rank = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run summon minecraft:text_display ~22.4 ~1.7 ~-6 {Tags:["oa.lobby_label","oa.board_stats"],Rotation:[90f,0f],billboard:"fixed",text:[{text:"6. ",color:"gold"},{selector:"@s"},{text:"  勝",color:"gray"},{score:{name:"@s",objective:"oa.t_win"},color:"yellow"},{text:" キル",color:"gray"},{score:{name:"@s",objective:"oa.t_kill"},color:"red"},{text:" 試合",color:"gray"},{score:{name:"@s",objective:"oa.t_games"},color:"white"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
