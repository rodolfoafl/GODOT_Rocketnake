extends Area2D

export (int) var speed = 5

var directions = []
var pos_array = []
var current_direction = Vector2()


var end_texture = preload("res://Assets/PNG/Sprites/Rocket parts/spaceRocketParts_031.png")
var middle_texture = preload("res://Assets/PNG/Sprites/Rocket parts/spaceRocketParts_017.png")

func _process(delta):
	if(directions.size() > 0):
		if(position == pos_array[0]):
			current_direction = directions[0]
			remove_from_bottom()
	position += (current_direction * speed)/2	
	handle_sprite_direction(current_direction)
	
func remove_from_bottom():
	directions.pop_front()
	pos_array.pop_front()
	
func handle_sprite_direction(direction):
	if(direction == Vector2(0, -1)):
		$Sprite.rotation = 0
	if(direction == Vector2(0, 1)):
		$Sprite.rotation = 3.14159
	if(direction == Vector2(1, 0)):
		$Sprite.rotation = 1.5708
	if(direction == Vector2(-1, 0)):
		$Sprite.rotation = -1.5708
	
func add_to_bottom(top_position, direction):
	pos_array.append(top_position)
	directions.append(direction)
	pass


func _on_Area2D_area_entered(area):
	if(area.get_parent().name == "Top"):
		get_tree().reload_current_scene()