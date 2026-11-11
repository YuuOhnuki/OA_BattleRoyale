execute if data storage oa:lobby_events {working:1b} run return 0
execute if data storage oa:lobby origin{ready:1b} run function oa:lobby/events/finish_cached_at with storage oa:lobby origin
