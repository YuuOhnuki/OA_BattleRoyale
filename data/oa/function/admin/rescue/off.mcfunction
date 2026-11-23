# 1.9.242：初心者救済モードをオフにする（/function oa:admin/rescue/off）
execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"先にOPで /function oa:admin を実行してください。",color:"red"}
scoreboard players set #rescue br.flag 0
tellraw @a[tag=br.admin] {text:"初心者救済モードをオフにしました。",color:"green"}
