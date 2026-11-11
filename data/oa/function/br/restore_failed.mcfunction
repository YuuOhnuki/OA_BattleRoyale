scoreboard players set @s br.retry 1
kill @e[tag=br.restore_item]
tellraw @s {text:"保存アイテムの復元準備に失敗。現在の持ち物と保存データは変更していません",color:"red"}
