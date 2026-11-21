# 1.9.210: プラグインが動いていないときの予備（以前と同じ NBT の判定。重いのでプラグインがあれば使わない）
tag @a[tag=!oa.dead,nbt={Health:0.0f}] add oa.dead
tag @a[tag=oa.dead,nbt=!{Health:0.0f}] remove oa.dead
