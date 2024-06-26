extends Node2D

@onready var visibility_notifier := $VisibleOnScreenNotifier2D

@onready var pause_menu = $Pause
var paused = false
@onready var pause_button = $pause_button
var bricks = [
	preload("res://Scenes/square.tscn"),
	preload("res://Scenes/square_2.tscn"),
	preload("res://Scenes/square_3.tscn"),
	preload("res://Scenes/square_4.tscn"),
	preload("res://Scenes/square_5.tscn"),
	preload("res://Scenes/square_6.tscn")


]

var mouse_pos = get_global_mouse_position()
var iron = preload("res://Scenes/iron.tscn")
var crystal = preload("res://Scenes/crystal.tscn")

var brick_life:int = 100


var balls = preload("res://Scenes/ball.tscn")

var brick_location = Vector2(60, 200)
var brick_location_2 = Vector2(120, 200)
var cannon_location = Vector2(719,2445)
var new_shoot_direction = Vector2()


var balls_available:int = 1
var can_shoot = true
var ball_count:int = 0


@onready var shoot_delay := $shoot_delay
@onready var boost_speed := $boost_speed



@onready var background_music = get_node("/root/BackgroundMusic")
func _ready():
	#randomize()
	Engine.max_fps = 120
	$ball_count.text = str(balls_available)	
	pause_menu.hide()
	create_row_blocks()
	



		
	

func _on_pause_button_pressed():
	
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused

func _on_resume_pressed():
	Engine.time_scale = 1
	pause_menu.hide()
	
	
func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Scenes/Control.tscn")
	Engine.time_scale = 1
	
func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	background_music.play()
	Engine.time_scale = 1
func _input(event):
	
			
	if event is InputEventMouseButton:
		
		if	event.position.y < 2412 and event.position.y > 100:
			
			if Input.is_action_just_released("shoot") and can_shoot:
				

				
				shoot_balls(get_global_mouse_position())
				

func create_row_blocks():
	var block_id = [0,1]

	
	for i in range(7):
			var block = block_id[randi() % block_id.size()]
			var select_brick = randi() % bricks.size()
			var new_brick = bricks[select_brick].instantiate()
			
			if block == 1:
				
				
				new_brick.position = brick_location_2
					
				add_child(new_brick)
				brick_location_2.x +=200
			else:
				brick_location_2.x +=200
	brick_location_2 = Vector2(120, 0)
	
	
	

func create_field():
	
	var level = [
		[1,1,1,1,1]
	]
	for i in level:
		
		for x in i:
			if x == 1:
				var select_brick = randi() % bricks.size()
				var new_brick = bricks[select_brick].instantiate()
				
				new_brick.position = brick_location
				
				add_child(new_brick)
				
				
				
				brick_location.x +=200
			if x == 0:
				brick_location.x +=200
			if x == 3:
				var new_iron = iron.instantiate()
				new_iron.position = brick_location
				add_child(new_iron)
				brick_location.x +=55
			if x == 4:
				var new_crystal = crystal.instantiate()
				new_crystal.position = brick_location
				add_child(new_crystal)
				brick_location.x +=55
		brick_location.x =55
		brick_location.y +=100
	
	#for i in range(8):
		#
		#for x in range(8):
			#var select_brick = randi() % bricks.size()
			#var new_brick = bricks[select_brick].instantiate()
			#
			#new_brick.position = brick_location
			#add_child(new_brick)
			#remained_bricks.append(new_brick)
			#
			#brick_location.x +=60
		#brick_location.x =75
		#brick_location.y +=60

func shoot_balls(shoot_direction):
	

	new_shoot_direction = shoot_direction - cannon_location
	can_shoot = false
	boost_speed.start()
	for i in range(balls_available):
		var new_ball = balls.instantiate()
		
		new_ball.position = cannon_location
		
		add_child(new_ball)
		
		
		if ball_count <= balls_available:
			ball_count +=1
		
		shoot_delay.start()
		await shoot_delay.timeout
	
	
		
	if balls_available < 20:
		balls_available +=1


func remove_ball():
	ball_count -=1

	if ball_count <=0:
		create_row_blocks() 
		$ball_count.text = str(balls_available)	
		can_shoot = true

func show_direction():
	return(new_shoot_direction)


func _on_boost_speed_timeout():
	boost_speed.start()
	
	for balls in get_tree().get_nodes_in_group("ball"):
		balls.add_speed(1000)
	












