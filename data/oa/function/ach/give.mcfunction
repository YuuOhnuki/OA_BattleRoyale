$execute if entity @s[advancements={oa:ach/$(id)=true}] run return 0
execute unless entity @s[type=minecraft:player] run return 0
$advancement grant @s only oa:ach/$(id)
$tellraw @a[tag=br.playing] [{text:"◆ ",color:"gold"},{selector:"@s"},{text:" が実績『$(name)』を解除！",color:"yellow"}]
$tellraw @s[tag=!br.playing] [{text:"◆ 実績『$(name)』を解除！",color:"yellow"}]
playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 1 1
