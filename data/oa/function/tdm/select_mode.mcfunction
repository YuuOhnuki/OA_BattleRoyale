execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中はモードを変更できません",color:"red"}
execute unless entity @s[tag=br.admin] unless entity @s[tag=br.host] run return run tellraw @s {text:"ゲームモードの変更はホスト・管理者が行えます",color:"red"}
execute if score @s oa.game matches 1 run scoreboard players set #game oa.game 0
execute if score @s oa.game matches 2 run scoreboard players set #game oa.game 1
execute if score #game oa.game matches 0 run tellraw @a[tag=br.lobby] {text:"ゲームモード：バトルロワイヤル",color:"green"}
execute if score #game oa.game matches 1 run tellraw @a[tag=br.lobby] {text:"ゲームモード：チームデスマッチ（5分）",color:"gold"}
