execute if entity @s[advancements={oa:ach/killing_guard=true}] run return 0
advancement grant @s only oa:ach/killing_guard
tellraw @a[tag=br.playing] [{text:"◆ ",color:"gold"},{selector:"@s"},{text:" が実績『25%の奇跡』を解除！",color:"yellow"}]
playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 1 1
