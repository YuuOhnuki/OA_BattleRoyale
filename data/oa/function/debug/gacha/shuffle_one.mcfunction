data modify storage oa:db_shuffle args.x set from storage oa:db_shuffle positions[-1][0]
data modify storage oa:db_shuffle args.y set from storage oa:db_shuffle positions[-1][1]
data modify storage oa:db_shuffle args.z set from storage oa:db_shuffle positions[-1][2]
function oa:debug/gacha/tp_list with storage oa:db_shuffle args
data remove storage oa:db_shuffle positions[-1]
