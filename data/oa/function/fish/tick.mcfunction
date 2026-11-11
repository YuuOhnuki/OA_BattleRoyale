execute unless entity @s[tag=oa.fish1911] run function oa:fish/speed_upgrade
# Holder jumps only through normal player input; no automatic ground or water jump.
execute if score #clock oa.beat matches 5.. run particle minecraft:snowflake ~ ~0.8 ~ 0.3 0.4 0.3 0.015 3 normal @a[distance=..32]

function oa:fish/riptide_tick
