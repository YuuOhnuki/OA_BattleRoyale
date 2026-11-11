execute if entity @s[advancements={oa:ach/pichi_20s=true}] run return 0
advancement grant @s only oa:ach/pichi_20s
tellraw @a[tag=br.playing] [{text:"◆ ",color:"gold"},{selector:"@s"},{text:" が実績『魚のまま20秒』を解除！",color:"yellow"}]
playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 1 1
