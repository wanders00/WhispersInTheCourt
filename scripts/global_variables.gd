extends Node

# 0 = have not interacted
# 1 = first option
# 2 = second option
var map = {
	"first" : 0
}

func update(key, value):
	map[key] = value

func get_value(key):
	return map[key]
	
