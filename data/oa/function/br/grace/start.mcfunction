team add oa_brgrace
team modify oa_brgrace color dark_aqua
team modify oa_brgrace friendlyFire false
scoreboard objectives setdisplay sidebar.team.dark_aqua br.ui0
execute if score #mode br.mode matches 0 run team join oa_brgrace @a[tag=br.playing]
execute if score #mode br.mode matches 0 run tag @a[tag=br.playing] add br.native_grace
execute if score #mode br.mode matches 1 run team modify oa_br1 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br2 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br3 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br4 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br5 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br6 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br7 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br8 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br9 nametagVisibility never
execute if score #mode br.mode matches 1 run team modify oa_br10 nametagVisibility never
tellraw @a[tag=br.playing] {text:"開始1分間はPvP禁止。試合のチーム分けは保持しています",color:"aqua"}

team modify oa_brgrace nametagVisibility never
