scoreboard players set #busy br.clean 0
scoreboard players set #state br.state 0
tellraw @a[tag=br.admin] {text:"[OA] 落とし物の全区画清掃が完了しました",color:"green"}
execute if score #mode br.clean matches 1 run scoreboard players set #clean_ready br.clean 1
execute if score #mode br.clean matches 1 unless entity @a[tag=br.lobby] run scoreboard players set #clean_ready br.clean 0
execute if score #mode br.clean matches 1 as @a[tag=br.lobby,limit=1] at @s run function oa:br/start
execute if score #mode br.clean matches 2 if score #adv_msg br.flag matches 0 run function oa:internal/gamerule_match {rule:"show_advancement_messages",value:"false"}
execute if score #mode br.clean matches 2 if score #adv_msg br.flag matches 1 run function oa:internal/gamerule_match {rule:"show_advancement_messages",value:"true"}
