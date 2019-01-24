extends Node

export (int) var speed = 5

onready var bottom = preload("res://Scenes/Bottom.tscn")

var direction = Vector2(1, 0)
const GAP = -45
var next_tail_direction = Vector2(1, 0)
var previous_direction = Vector2(1,0)
var parts_array = []

func _ready():
	add_bottom()
	$Area2D/Sprite.rotation = 1.57

func _process(delta):
	if(Input.is_action_pressed("ui_up")):
		direction = Vector2(0, -1)
		$Area2D/Sprite.rotation = 0
	if(Input.is_action_pressed("ui_down")):
		direction = Vector2(0, 1)
		$Area2D/Sprite.rotation = 3.14159
	if(Input.is_action_pressed("ui_right")):
		direction = Vector2(1, 0)
		$Area2D/Sprite.rotation = 1.5708
	if(Input.is_action_pressed("ui_left")):
		direction = Vector2(-1, 0)
		$Area2D/Sprite.rotation = -1.5708
		
	move_rocket()

func move_rocket():
	var direction_change = false
	if(previous_direction != direction):
		previous_direction = direction
		direction_change = true
	var top_position = $Area2D.position
	
	$Area2D.position += (direction * speed) / 2
	
	if(direction_change):
		for i in range(1, get_child_count()):
			get_child(i).get_child(0).add_to_bottom(top_position, direction)
			
	
func add_bottom():
	var instance = bottom.instance()
	var previous_tail = get_child(get_child_count() - 1).get_child(0)

	if(previous_tail.name != "Top" && previous_tail.name != "Sprite"):
		instance.get_child(0).current_direction = previous_tail.current_direction	

		for i in range (0, previous_tail.pos_array.size()):
			instance.get_child(0).pos_array.append(previous_tail.pos_array[i])
			instance.get_child(0).directions.append(previous_tail.directions[i])
		instance.get_child(0).position = previous_tail.position + previous_tail.current_direction * GAP
		
	else:
		instance.get_child(0).current_direction = direction
		instance.get_child(0).position = previous_tail.position + direction  * GAP
	add_child(instance)
	parts_array.append(instance)
	
	var sprite = instance.get_node("Area2D/Sprite")
	handle_parts_sprite(instance, previous_tail)
	sprite.rotation = $Area2D/Sprite.rotation
	
func handle_parts_sprite(instance, tail):
	var last = parts_array.size() - 1
	if(last < 1):
		parts_array[last].get_child(0).get_node("Sprite").set_texture(instance.get_child(0).end_texture)
	else:
		for i in range(0, last):
			parts_array[i].get_child(0).get_node("Sprite").set_texture(instance.get_child(0).middle_texture)

		