extends RigidBody2D


var bricks = [
	preload("res://Scenes/square.tscn"),

]




var ball_speed:int = 1800
var ball_safe_zone = Vector2()
var shoot_direction = Vector2()




func _ready():
	shoot_direction = get_parent().show_direction()
	apply_central_impulse(shoot_direction)
	pass


func _integrate_forces(state):
	if state.linear_velocity.length() < ball_speed:
		state.linear_velocity = state.linear_velocity.normalized() * ball_speed
	var ball_safe_zone = self.position
	if ball_safe_zone.x < -10 or ball_safe_zone.x > 1440 or ball_safe_zone.y < - 10 or ball_safe_zone.y > 2550:
		
		get_parent().remove_ball()
		var created_bricks = get_tree().get_nodes_in_group("brick")
		var created_iron = get_tree().get_nodes_in_group("iron")
		var created_crystal = get_tree().get_nodes_in_group("crystal")
		
		
		
		for i in created_bricks:
			
			i.position.y +=200
			
		for i in created_iron:
			i.position.y +=100	
		for i in created_crystal:
			i.position.y +=100
		queue_free()
#func _on_body_entered(body):
	


func _on_ball_body_entered(body):
	if body.is_in_group("brick"):
		if $brick_sound.playing == false:
			$brick_sound.play()
		body.take_life()
	if body.is_in_group("bottom"):
		
		get_parent().remove_ball()
		
		queue_free()
		
		
	if body.is_in_group("iron"):
		if $iron_sound.playing == false:
			$iron_sound.play()
	if body.is_in_group("crystal"):
		if $crystal_sound.playing == false:
			$crystal_sound.play()
	
	if body.is_in_group("wall"):
		if $wall_sound.playing == false:
			$wall_sound.play()
	var shooted_balls = get_tree().get_nodes_in_group("ball")

	if len(shooted_balls) < 2 and body.is_in_group("bottom"):
		
		var created_iron = get_tree().get_nodes_in_group("iron")
		var created_crystal = get_tree().get_nodes_in_group("crystal")
		
		
		var created_bricks = get_tree().get_nodes_in_group("brick")
		for i in created_bricks:
			if i.position.y > 2000:
				get_tree().change_scene_to_file.bind("res://Scenes/game_over.tscn").call_deferred()
			else:
				i.position.y +=200
		for i in created_iron:
			i.position.y +=100	
		for i in created_crystal:
			i.position.y +=100
	
	pass # Replace with function body.
		
	pass # Replace with function body.
func add_speed(speed_boost):
	ball_speed +=speed_boost
	
