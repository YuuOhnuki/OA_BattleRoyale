
$data modify storage oa:br center set value {dim:"$(dim)",yaw:0.0f,pitch:0.0f}
$data modify storage oa:br center.x set value $(x)
$data modify storage oa:br center.z set value $(z)
$data modify storage oa:br center.y set value $(center_y)
execute store result score #cx br.x run data get storage oa:br center.x 1000
execute store result score #cz br.z run data get storage oa:br center.z 1000
function oa:br/border/auto
