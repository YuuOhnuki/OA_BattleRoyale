function oa:map/select {key:"cave"}
execute if data storage oa:maps {current:"cave"} run function oa:map/create
