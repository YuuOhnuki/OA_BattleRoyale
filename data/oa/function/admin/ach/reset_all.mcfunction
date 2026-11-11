execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"先にOPで /function oa:admin を実行してください。",color:"red"}
execute as @a run function oa:ach/revoke_all
execute as @a run function oa:ach/reset
tellraw @s {text:"オンラインの全プレイヤーの実績をリセットしました。",color:"green"}
