# 1.9.162: 順位の行は、該当する人がいるときだけ出す（以前は人数に関係なく全行を出していた）
tag @a remove oa.bl1
tag @a remove oa.bl2
tag @a remove oa.bl3
tag @a remove oa.bl4
tag @a remove oa.bl5
tag @a remove oa.bl6
tag @a remove oa.bl7
tag @a remove oa.bl8
tag @a remove oa.b_done
kill @e[type=minecraft:text_display,tag=oa.board_last]
summon minecraft:text_display ~0 ~4.9 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:{text:"前回の試合結果",color:"gold",bold:true},background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[1.1f,1.1f,1.1f]}}
scoreboard players set #lmax oa.tmp -1
execute as @a[tag=oa.last_result,tag=!oa.b_done] run scoreboard players operation #lmax oa.tmp > @s br.lkey
execute as @a[tag=oa.last_result,tag=!oa.b_done] if score @s br.lkey = #lmax oa.tmp run tag @s add oa.b_cand
tag @a[tag=oa.b_cand,limit=1] add oa.bl1
tag @a[tag=oa.b_cand,limit=1] add oa.b_done
tag @a remove oa.b_cand
execute if entity @a[tag=oa.bl1,limit=1] run summon minecraft:text_display ~0 ~4.2 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"1. ",color:"gold"},{selector:"@a[tag=oa.bl1,limit=1]"},{text:"  キル",color:"gray"},{score:{name:"@a[tag=oa.bl1,limit=1]",objective:"br.st_kill"},color:"red"},{text:" ダメ",color:"gray"},{score:{name:"@a[tag=oa.bl1,limit=1]",objective:"br.st_tmp"},color:"gold"},{text:" 開封",color:"gray"},{score:{name:"@a[tag=oa.bl1,limit=1]",objective:"br.st_open"},color:"green"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
scoreboard players set #lmax oa.tmp -1
execute as @a[tag=oa.last_result,tag=!oa.b_done] run scoreboard players operation #lmax oa.tmp > @s br.lkey
execute as @a[tag=oa.last_result,tag=!oa.b_done] if score @s br.lkey = #lmax oa.tmp run tag @s add oa.b_cand
tag @a[tag=oa.b_cand,limit=1] add oa.bl2
tag @a[tag=oa.b_cand,limit=1] add oa.b_done
tag @a remove oa.b_cand
execute if entity @a[tag=oa.bl2,limit=1] run summon minecraft:text_display ~0 ~3.75 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"2. ",color:"gold"},{selector:"@a[tag=oa.bl2,limit=1]"},{text:"  キル",color:"gray"},{score:{name:"@a[tag=oa.bl2,limit=1]",objective:"br.st_kill"},color:"red"},{text:" ダメ",color:"gray"},{score:{name:"@a[tag=oa.bl2,limit=1]",objective:"br.st_tmp"},color:"gold"},{text:" 開封",color:"gray"},{score:{name:"@a[tag=oa.bl2,limit=1]",objective:"br.st_open"},color:"green"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
scoreboard players set #lmax oa.tmp -1
execute as @a[tag=oa.last_result,tag=!oa.b_done] run scoreboard players operation #lmax oa.tmp > @s br.lkey
execute as @a[tag=oa.last_result,tag=!oa.b_done] if score @s br.lkey = #lmax oa.tmp run tag @s add oa.b_cand
tag @a[tag=oa.b_cand,limit=1] add oa.bl3
tag @a[tag=oa.b_cand,limit=1] add oa.b_done
tag @a remove oa.b_cand
execute if entity @a[tag=oa.bl3,limit=1] run summon minecraft:text_display ~0 ~3.3 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"3. ",color:"gold"},{selector:"@a[tag=oa.bl3,limit=1]"},{text:"  キル",color:"gray"},{score:{name:"@a[tag=oa.bl3,limit=1]",objective:"br.st_kill"},color:"red"},{text:" ダメ",color:"gray"},{score:{name:"@a[tag=oa.bl3,limit=1]",objective:"br.st_tmp"},color:"gold"},{text:" 開封",color:"gray"},{score:{name:"@a[tag=oa.bl3,limit=1]",objective:"br.st_open"},color:"green"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
scoreboard players set #lmax oa.tmp -1
execute as @a[tag=oa.last_result,tag=!oa.b_done] run scoreboard players operation #lmax oa.tmp > @s br.lkey
execute as @a[tag=oa.last_result,tag=!oa.b_done] if score @s br.lkey = #lmax oa.tmp run tag @s add oa.b_cand
tag @a[tag=oa.b_cand,limit=1] add oa.bl4
tag @a[tag=oa.b_cand,limit=1] add oa.b_done
tag @a remove oa.b_cand
execute if entity @a[tag=oa.bl4,limit=1] run summon minecraft:text_display ~0 ~2.85 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"4. ",color:"gold"},{selector:"@a[tag=oa.bl4,limit=1]"},{text:"  キル",color:"gray"},{score:{name:"@a[tag=oa.bl4,limit=1]",objective:"br.st_kill"},color:"red"},{text:" ダメ",color:"gray"},{score:{name:"@a[tag=oa.bl4,limit=1]",objective:"br.st_tmp"},color:"gold"},{text:" 開封",color:"gray"},{score:{name:"@a[tag=oa.bl4,limit=1]",objective:"br.st_open"},color:"green"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
scoreboard players set #lmax oa.tmp -1
execute as @a[tag=oa.last_result,tag=!oa.b_done] run scoreboard players operation #lmax oa.tmp > @s br.lkey
execute as @a[tag=oa.last_result,tag=!oa.b_done] if score @s br.lkey = #lmax oa.tmp run tag @s add oa.b_cand
tag @a[tag=oa.b_cand,limit=1] add oa.bl5
tag @a[tag=oa.b_cand,limit=1] add oa.b_done
tag @a remove oa.b_cand
execute if entity @a[tag=oa.bl5,limit=1] run summon minecraft:text_display ~0 ~2.4 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"5. ",color:"gold"},{selector:"@a[tag=oa.bl5,limit=1]"},{text:"  キル",color:"gray"},{score:{name:"@a[tag=oa.bl5,limit=1]",objective:"br.st_kill"},color:"red"},{text:" ダメ",color:"gray"},{score:{name:"@a[tag=oa.bl5,limit=1]",objective:"br.st_tmp"},color:"gold"},{text:" 開封",color:"gray"},{score:{name:"@a[tag=oa.bl5,limit=1]",objective:"br.st_open"},color:"green"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
scoreboard players set #lmax oa.tmp -1
execute as @a[tag=oa.last_result,tag=!oa.b_done] run scoreboard players operation #lmax oa.tmp > @s br.lkey
execute as @a[tag=oa.last_result,tag=!oa.b_done] if score @s br.lkey = #lmax oa.tmp run tag @s add oa.b_cand
tag @a[tag=oa.b_cand,limit=1] add oa.bl6
tag @a[tag=oa.b_cand,limit=1] add oa.b_done
tag @a remove oa.b_cand
execute if entity @a[tag=oa.bl6,limit=1] run summon minecraft:text_display ~0 ~1.95 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"6. ",color:"gold"},{selector:"@a[tag=oa.bl6,limit=1]"},{text:"  キル",color:"gray"},{score:{name:"@a[tag=oa.bl6,limit=1]",objective:"br.st_kill"},color:"red"},{text:" ダメ",color:"gray"},{score:{name:"@a[tag=oa.bl6,limit=1]",objective:"br.st_tmp"},color:"gold"},{text:" 開封",color:"gray"},{score:{name:"@a[tag=oa.bl6,limit=1]",objective:"br.st_open"},color:"green"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
scoreboard players set #lmax oa.tmp -1
execute as @a[tag=oa.last_result,tag=!oa.b_done] run scoreboard players operation #lmax oa.tmp > @s br.lkey
execute as @a[tag=oa.last_result,tag=!oa.b_done] if score @s br.lkey = #lmax oa.tmp run tag @s add oa.b_cand
tag @a[tag=oa.b_cand,limit=1] add oa.bl7
tag @a[tag=oa.b_cand,limit=1] add oa.b_done
tag @a remove oa.b_cand
execute if entity @a[tag=oa.bl7,limit=1] run summon minecraft:text_display ~0 ~1.5 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"7. ",color:"gold"},{selector:"@a[tag=oa.bl7,limit=1]"},{text:"  キル",color:"gray"},{score:{name:"@a[tag=oa.bl7,limit=1]",objective:"br.st_kill"},color:"red"},{text:" ダメ",color:"gray"},{score:{name:"@a[tag=oa.bl7,limit=1]",objective:"br.st_tmp"},color:"gold"},{text:" 開封",color:"gray"},{score:{name:"@a[tag=oa.bl7,limit=1]",objective:"br.st_open"},color:"green"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
scoreboard players set #lmax oa.tmp -1
execute as @a[tag=oa.last_result,tag=!oa.b_done] run scoreboard players operation #lmax oa.tmp > @s br.lkey
execute as @a[tag=oa.last_result,tag=!oa.b_done] if score @s br.lkey = #lmax oa.tmp run tag @s add oa.b_cand
tag @a[tag=oa.b_cand,limit=1] add oa.bl8
tag @a[tag=oa.b_cand,limit=1] add oa.b_done
tag @a remove oa.b_cand
execute if entity @a[tag=oa.bl8,limit=1] run summon minecraft:text_display ~0 ~1.05 ~-35.4 {Tags:["oa.lobby_label","oa.board_last"],Rotation:[0f,0f],billboard:"fixed",text:[{text:"8. ",color:"gold"},{selector:"@a[tag=oa.bl8,limit=1]"},{text:"  キル",color:"gray"},{score:{name:"@a[tag=oa.bl8,limit=1]",objective:"br.st_kill"},color:"red"},{text:" ダメ",color:"gray"},{score:{name:"@a[tag=oa.bl8,limit=1]",objective:"br.st_tmp"},color:"gold"},{text:" 開封",color:"gray"},{score:{name:"@a[tag=oa.bl8,limit=1]",objective:"br.st_open"},color:"green"}],background:0,shadow:1b,view_range:1.0,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.8f,0.8f,0.8f]}}
