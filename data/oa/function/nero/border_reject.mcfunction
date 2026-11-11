scoreboard players set @s oa.mark 0
function oa:nero/clear_mark with storage oa:args
playsound minecraft:block.note_block.bass player @s ~ ~ ~ 0.84 0.6
tellraw @s {text:"印がボーダー外、または境界に近すぎるため帰還できません。印を解除しました",color:"red"}
