# 解錠完了：周囲の最も近い生存者に報酬。アイテムはその場に出る（チェスト用の戦利品を2回）
playsound minecraft:ui.toast.challenge_complete block @a[distance=..48] ~ ~ ~ 1 1
particle minecraft:totem_of_undying ~ ~1 ~ 0.5 0.8 0.5 0.3 60 force @a[distance=..64]
loot spawn ~ ~1.2 ~ loot oa:br/chest_site
loot spawn ~ ~1.2 ~ loot oa:br/chest_upgraded
execute as @p[tag=br.alive,distance=..5] run function oa:disaster/relic/reward
tellraw @a[tag=br.playing] [{text:"✦ ",color:"light_purple"},{text:"どこかで封印の宝珠が解錠された！",color:"white"}]
kill @e[tag=br.relic,distance=..3]
