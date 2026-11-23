data modify storage oa:templates request set value "lobby"
scoreboard players set #busy oa.template 1
tellraw @s {text:"保存したロビーを保存元の座標へ復元します。完了までお待ちください。"}
