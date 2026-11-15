# 1.9.186: 管理者が対象のチームを未選択に戻す（参加登録はそのまま）
execute unless score #state br.state matches 0 run return run tellraw @a[tag=oa.roster_actor] {text:"試合中はチームを変えられません。",color:"yellow"}
team leave @s
scoreboard players set @s br.pick 0
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" のチームを未選択にしました。",color:"gray"}]
