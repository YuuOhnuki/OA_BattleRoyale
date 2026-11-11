schedule clear oa:br/cleanup/wait
function oa:br/cleanup/release
scoreboard players set #busy br.clean 0
scoreboard players set #state br.state 0
scoreboard players set #clean_ready br.clean 0
tellraw @a {text:"[OA] 清掃を中断しました。追加した強制読込は解除。開始前なら試合は開始していません（読込失敗・強制読込上限も確認）。",color:"red"}
execute if score #mode br.clean matches 2 if score #adv_msg br.flag matches 0 run gamerule minecraft:show_advancement_messages false
execute if score #mode br.clean matches 2 if score #adv_msg br.flag matches 1 run gamerule minecraft:show_advancement_messages true
