# 1.9.242：初心者救済モードをオンにする（/function oa:admin/rescue/on。oa.admin 160 は切り替え）
execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"先にOPで /function oa:admin を実行してください。",color:"red"}
scoreboard players set #rescue br.flag 1
tellraw @a[tag=br.admin] [{text:"初心者救済モードをオンにしました。",color:"green"},{text:"チェスト補充（試合開始から6分）より前に倒れた人は、補充のときに復活します。",color:"gray"}]
