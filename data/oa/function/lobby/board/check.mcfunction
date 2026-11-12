# 戦績ボードの壁が、ロビーの現在の原点とずれていないか確認する（ロビーを別の場所に作り直した後の置き去り対策）
data modify storage oa:lobby board_cmp set from storage oa:lobby board_at
execute store success score #bdiff oa.tmp run data modify storage oa:lobby board_cmp set from storage oa:lobby origin
execute if score #bdiff oa.tmp matches 1 run function oa:lobby/board/move
