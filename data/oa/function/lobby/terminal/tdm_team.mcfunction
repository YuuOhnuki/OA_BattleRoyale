# 1.9.203: チームデスマッチ受付の赤／青（n=1 赤、2 青、0 解除）。人数は開始時に均等化する。
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中はチームを変更できません。",color:"yellow"}
execute if entity @s[tag=oa.practice] run return run tellraw @s {text:"練習場を出てからチームを選んでください。",color:"yellow"}
execute if score #game oa.game matches 0 run return run tellraw @s {text:"現在はバトルロワイヤルの準備中です。赤・青は、ホストがチームデスマッチに切り替えると選べます。",color:"yellow"}
$scoreboard players set #tt oa.tmp $(n)
execute unless entity @s[tag=br.lobby] unless score #tt oa.tmp matches 0 run function oa:br/join
scoreboard players operation @s tdm.team = #tt oa.tmp
execute if score #tt oa.tmp matches 1 run tellraw @s [{text:"チームデスマッチ：",color:"white"},{text:"赤チーム",color:"red",bold:true},{text:"を希望しました。人数は開始時に均等化します。",color:"white"}]
execute if score #tt oa.tmp matches 2 run tellraw @s [{text:"チームデスマッチ：",color:"white"},{text:"青チーム",color:"blue",bold:true},{text:"を希望しました。人数は開始時に均等化します。",color:"white"}]
execute if score #tt oa.tmp matches 0 run tellraw @s {text:"チームデスマッチのチーム希望を解除しました（自動で振り分け）。",color:"aqua"}
playsound minecraft:block.note_block.chime player @s ~ ~ ~ 0.7 1.3
