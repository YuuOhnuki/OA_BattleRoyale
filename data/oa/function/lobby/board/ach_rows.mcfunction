tag @a remove oa.ba1
tag @a remove oa.ba2
tag @a remove oa.ba3
tag @a remove oa.ba4
tag @a remove oa.ba5
tag @a remove oa.ba6
tag @a remove oa.b_un
tag @a remove oa.b_cand
tag @a[tag=br.lobby_now] add oa.b_un
kill @e[type=minecraft:text_display,tag=oa.board_ach]
summon minecraft:text_display ~6 ~4.9 ~-35.4 {Tags:["oa.lobby_label","oa.board_ach"],Rotation:[0f,0f],billboard:"fixed",text:{text:"実績数（オンライン）",color:"gold",bold:true},background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.1f,1.1f,1.1f]}}
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_ach > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_ach
execute as @a[tag=oa.b_un] if score @s oa.t_ach = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.ba1
summon minecraft:text_display ~6 ~4.2 ~-35.4 {Tags:["oa.lobby_label","oa.board_ach"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"1. ",color:"gold"},{selector:"@a[tag=oa.ba1,limit=1]"},{text:"  ",color:"gray"},{score:{name:"@a[tag=oa.ba1,limit=1]",objective:"oa.t_ach"},color:"green"},{text:" / 38",color:"gray"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_ach > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_ach
execute as @a[tag=oa.b_un] if score @s oa.t_ach = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.ba2
summon minecraft:text_display ~6 ~3.7 ~-35.4 {Tags:["oa.lobby_label","oa.board_ach"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"2. ",color:"gold"},{selector:"@a[tag=oa.ba2,limit=1]"},{text:"  ",color:"gray"},{score:{name:"@a[tag=oa.ba2,limit=1]",objective:"oa.t_ach"},color:"green"},{text:" / 38",color:"gray"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_ach > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_ach
execute as @a[tag=oa.b_un] if score @s oa.t_ach = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.ba3
summon minecraft:text_display ~6 ~3.2 ~-35.4 {Tags:["oa.lobby_label","oa.board_ach"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"3. ",color:"gold"},{selector:"@a[tag=oa.ba3,limit=1]"},{text:"  ",color:"gray"},{score:{name:"@a[tag=oa.ba3,limit=1]",objective:"oa.t_ach"},color:"green"},{text:" / 38",color:"gray"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_ach > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_ach
execute as @a[tag=oa.b_un] if score @s oa.t_ach = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.ba4
summon minecraft:text_display ~6 ~2.7 ~-35.4 {Tags:["oa.lobby_label","oa.board_ach"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"4. ",color:"gold"},{selector:"@a[tag=oa.ba4,limit=1]"},{text:"  ",color:"gray"},{score:{name:"@a[tag=oa.ba4,limit=1]",objective:"oa.t_ach"},color:"green"},{text:" / 38",color:"gray"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_ach > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_ach
execute as @a[tag=oa.b_un] if score @s oa.t_ach = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.ba5
summon minecraft:text_display ~6 ~2.2 ~-35.4 {Tags:["oa.lobby_label","oa.board_ach"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"5. ",color:"gold"},{selector:"@a[tag=oa.ba5,limit=1]"},{text:"  ",color:"gray"},{score:{name:"@a[tag=oa.ba5,limit=1]",objective:"oa.t_ach"},color:"green"},{text:" / 38",color:"gray"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
scoreboard players set #max oa.tmp -1
execute as @a[tag=oa.b_un] if score @s oa.t_ach > #max oa.tmp run scoreboard players operation #max oa.tmp = @s oa.t_ach
execute as @a[tag=oa.b_un] if score @s oa.t_ach = #max oa.tmp run tag @s add oa.b_cand
execute as @a[tag=oa.b_cand,limit=1] run tag @s add oa.ba6
summon minecraft:text_display ~6 ~1.7 ~-35.4 {Tags:["oa.lobby_label","oa.board_ach"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"6. ",color:"gold"},{selector:"@a[tag=oa.ba6,limit=1]"},{text:"  ",color:"gray"},{score:{name:"@a[tag=oa.ba6,limit=1]",objective:"oa.t_ach"},color:"green"},{text:" / 38",color:"gray"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
execute as @a[tag=oa.b_cand,limit=1] run tag @s remove oa.b_un
tag @a remove oa.b_cand
