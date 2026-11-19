# 1.9.191: 本人のまわり（±6）の空から1個落とす
execute store result storage oa:gacha tnt.dx int 1 run random value -6..6
execute store result storage oa:gacha tnt.dz int 1 run random value -6..6
function oa:tayayuyu/tnt_at with storage oa:gacha tnt
