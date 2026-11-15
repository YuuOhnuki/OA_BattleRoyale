schedule clear oa:br/cleanup/wait
function oa:br/cleanup/release
scoreboard players set #busy br.clean 0
scoreboard players set #state br.state 0
scoreboard players set #clean_ready br.clean 0
tellraw @a {text:"[OA] 清掃を中断しました。追加した強制読込は解除。開始前なら試合は開始していません（読込失敗・強制読込上限も確認）。",color:"red"}
execute if score #mode br.clean matches 2 if score #adv_msg br.flag matches 0 run function oa:internal/gamerule_match {rule:"show_advancement_messages",value:"false"}
execute if score #mode br.clean matches 2 if score #adv_msg br.flag matches 1 run function oa:internal/gamerule_match {rule:"show_advancement_messages",value:"true"}
# 1.9.185: 試合のあと、ロビーで選んでいたチームに入り直す（br.pick を保つ）
execute as @a[tag=br.lobby,tag=!br.playing] run function oa:br/team/sync
