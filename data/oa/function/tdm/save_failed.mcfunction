execute as @a[tag=br.lobby,scores={br.saved=1}] at @s run function oa:br/recover
tellraw @a[tag=br.lobby] {text:"保存に失敗したため開始を中止しました",color:"red"}
