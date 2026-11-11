execute as @a[tag=br.lobby,scores={br.saved=1}] run function oa:br/discard_backup
execute in oa:br run kill @e[distance=0..,tag=br.spawn]
tellraw @s {text:"持ち物保存の検証に失敗したため開始を中止しました。元の持ち物は維持しています",color:"red"}
