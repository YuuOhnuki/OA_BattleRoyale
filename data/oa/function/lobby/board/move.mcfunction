# 古い位置のボードの壁を消し、次のtickで現在の原点に作り直す
function oa:lobby/board/clear with storage oa:lobby board_at
data remove storage oa:lobby board_at
data remove storage oa:lobby board_built
