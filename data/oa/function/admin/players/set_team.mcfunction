# 1.9.186: 管理者が対象のチームを決める（引数 n = 1〜10。待機中だけ。未登録なら参加させる）
execute unless score #state br.state matches 0 run return run tellraw @a[tag=oa.roster_actor] {text:"試合中はチームを変えられません。",color:"yellow"}
execute if entity @s[tag=br.watch] run function oa:lobby/return
execute unless entity @s[tag=br.lobby] run function oa:br/join
$function oa:br/team/$(n)
$tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" をチーム$(n)にしました。",color:"green"}]
