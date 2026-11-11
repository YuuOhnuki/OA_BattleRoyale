execute if score #state br.state matches 2.. run return run tellraw @a[tag=oa.roster_actor] {text:"終了・演出処理の完了後に操作してください。",color:"yellow"}
execute if entity @s[tag=br.alive] run function oa:br/surrender
execute unless entity @s[tag=br.playing] run function oa:lobby/watch
execute if entity @s[tag=br.playing] run gamemode spectator @s
execute if score #state br.state matches 1 unless entity @s[tag=br.playing] run function oa:admin/players/live_watch
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を観戦へ変更しました。",color:"gray"}]
tellraw @s {text:"管理者により観戦へ変更されました。",color:"gray"}
