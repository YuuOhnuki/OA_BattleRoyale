function oa:map/select {key:"br"}
execute if data storage oa:maps {current:"br"} run function oa:map/rebuild
