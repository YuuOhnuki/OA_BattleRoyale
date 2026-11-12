function oa:map/select {key:"nether"}
execute if data storage oa:maps {current:"nether"} run function oa:map/rebuild
