# 地上マップの終盤演出（標準の演出に、虹色の花火を足す）
function oa:finale/default
execute if score #fstep br.tmp matches 1 run function oa:br/finale/burst_dispatch
