function oa:map/select {key:"sky"}
execute if data storage oa:maps {current:"sky"} run function oa:map/rebuild
