execute if score @s br.opened matches 1 run return 0
scoreboard players set @s br.opened 1
scoreboard players set #open_reward br.flag 1
# 1.9.159: 通常チェストの札は、再補充までの残り時間つき（br/loot/open_label が毎秒書き換える）。
# 1.9.255: 以前「開封済み」と出ていた行は、中身が空のときだけ「空」（br/loot/open_label_one）。特別チェストは「★ 特別チェスト」の下に、空のときだけ「空」
execute if entity @s[tag=br.rich] run summon minecraft:text_display ~ ~1.2 ~ {Tags:["br.open_label","br.open_rich"],text:{text:"★ 特別チェスト",color:"gold"},billboard:"center",view_range:0.5,background:0,shadow:1b,see_through:1b}
execute if entity @s[tag=!br.rich] run summon minecraft:text_display ~ ~1.2 ~ {Tags:["br.open_label"],text:"",billboard:"center",view_range:0.5,background:0,shadow:1b,see_through:1b}
execute positioned ~ ~1.2 ~ as @e[type=minecraft:text_display,tag=br.open_label,distance=..0.15] at @s run function oa:br/loot/open_label_one
