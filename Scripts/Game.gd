extends Node

onready var part = preload("res://Scenes/Part.tscn")

func _ready():
	add_part()
#	$Top/Area2D.position = Vector2( get_viewport().size.x / 2, get_viewport().size.y / 2)
	pass
	
func add_part():
	var instance = part.instance()
	instance.get_child(0).position = Vector2(generate_random_position(924, 0), generate_random_position(500, 0))
	instance.get_child(0).connect("part_collected", self, "control_spawnning")
	add_child(instance)
	
func control_spawnning():
	add_part()
	get_node("Top").add_bottom()

func generate_random_position(maxPos, minPos):
	randomize()
	var num =  randi() % maxPos + minPos
	return num