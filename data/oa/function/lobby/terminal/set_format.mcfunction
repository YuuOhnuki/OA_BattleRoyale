# 1.9.203: バトルロワイヤルの形式（f=0 ソロ、1 チーム戦）。開始時は #pref br.mode に従う（br.mode の #mode は開始時に決まる）。
execute unless entity @s[tag=br.admin] unless entity @s[tag=br.host] run return run tellraw @s {text:"形式の変更はホスト・管理者が行えます。",color:"yellow"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中は変更できません。",color:"yellow"}
execute if score #game oa.game matches 1 run return run tellraw @s {text:"先にバトルロワイヤルへ切り替えてください。",color:"yellow"}
$scoreboard players set #pref br.mode $(f)
execute if score #pref br.mode matches 0 run tellraw @a[tag=br.lobby] [{text:"バトルロワイヤルの形式：",color:"white"},{text:"ソロ（個人戦）",color:"aqua",bold:true}]
execute if score #pref br.mode matches 1 run tellraw @a[tag=br.lobby] [{text:"バトルロワイヤルの形式：",color:"white"},{text:"チーム戦（1チーム最大3人）",color:"aqua",bold:true}]
playsound minecraft:ui.button.click player @s ~ ~ ~ 0.6 1.2
