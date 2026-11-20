# 1.9.203: バトルロワイヤル受付のチーム選択（n=0 で解除、1〜10）。プラグインのメニュー・本・受付から本人として呼ぶ。
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中はチームを変更できません。",color:"yellow"}
execute if entity @s[tag=oa.practice] run return run tellraw @s {text:"練習場を出てからチームを選んでください。",color:"yellow"}
execute if score #game oa.game matches 1 run return run tellraw @s {text:"現在はチームデスマッチの準備中です。BRのチームは、ホストがバトルロワイヤルに切り替えると選べます。",color:"yellow"}
$scoreboard players set #bt oa.tmp $(n)
execute if score #bt oa.tmp matches 0 run scoreboard players set @s br.pick 0
execute if score #bt oa.tmp matches 0 run function oa:br/team/sync
execute if score #bt oa.tmp matches 0 run tellraw @s {text:"BRのチーム希望を解除しました（自動で振り分け）。",color:"aqua"}
execute if score #bt oa.tmp matches 0 run return run playsound minecraft:ui.button.click player @s ~ ~ ~ 0.6 1.0
execute unless entity @s[tag=br.lobby] run function oa:br/join
$function oa:br/team/$(n)
