function oa:map/select {key:"end"}
execute if data storage oa:maps {current:"end"} run function oa:map/rebuild
