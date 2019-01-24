extends Area2D

signal part_collected

func _on_Area2D_area_entered(area):
	if(area.get_parent().name == "Top"):
		queue_free()
		emit_signal("part_collected")
