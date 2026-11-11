execute if score #state br.state matches 2.. run return run tellraw @a[tag=oa.roster_actor] {text:"終了・演出処理の完了後に操作してください。",color:"yellow"}
execute if entity @s[nbt={Health:0.0f}] run return run tellraw @a[tag=oa.roster_actor] {text:"対象のリスポーン完了後に再実行してください。",color:"yellow"}
execute if score #state br.state matches 0 run return run function oa:admin/players/wait_join
execute if entity @s[tag=br.alive] run return run tellraw @a[tag=oa.roster_actor] {text:"すでに生存参加中です。",color:"yellow"}
execute if score #mode br.mode matches 1 unless score @s br.pick matches 1..10 run return run tellraw @a[tag=oa.roster_actor] {text:"チーム未選択です。試合前にチームを選択してください。",color:"yellow"}
scoreboard players set #roster_count oa.tmp 0
execute as @a[tag=br.alive] run scoreboard players add #roster_count oa.tmp 1
execute if score #roster_count oa.tmp matches 10.. run return run tellraw @a[tag=oa.roster_actor] {text:"生存参加者は最大10人です。",color:"yellow"}
execute if score @s br.saved matches 1 unless score @s br.round = #round br.round run return run tellraw @a[tag=oa.roster_actor] {text:"前の試合の所持品復元待ちです。復元完了後に再実行してください。",color:"yellow"}
scoreboard players operation #roster_team oa.tmp = @s br.pick
scoreboard players set #roster_team_count oa.tmp 0
execute if score #mode br.mode matches 1 as @a[tag=br.alive] if score @s oa.team = #roster_team oa.tmp run scoreboard players add #roster_team_count oa.tmp 1
execute if score #mode br.mode matches 1 if score #roster_team_count oa.tmp matches 3.. run return run tellraw @a[tag=oa.roster_actor] {text:"対象のチームはすでに3人生存しています。",color:"yellow"}
function oa:admin/players/live_join
