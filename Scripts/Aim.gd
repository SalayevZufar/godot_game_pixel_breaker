extends Sprite2D


var smooth_pos: Vector2

func _process(delta:float) -> void:
	smooth_pos = lerp(smooth_pos, get_global_mouse_position(), 0.3)
	look_at(smooth_pos)
