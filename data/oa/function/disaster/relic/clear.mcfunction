# 1.9.245：封印の宝珠を片付ける（試合の開始時＝disaster/init と、試合の終了・中止＝disaster/clear だけ）。
# 以前は災害が収まるたび（disaster/end → clear_marks）に消えていた。解錠されるまで残す
execute unless data storage oa:br center run return 0
function oa:disaster/relic/clear_dim with storage oa:br center
