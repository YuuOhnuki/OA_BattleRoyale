execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"先にOPで /function oa:admin を実行してください。",color:"red"}
scoreboard players set #nobeginner br.flag 1
tellraw @s {text:"初心者サポート（試合開始時の回復アイテム）をオフにしました。",color:"green"}
