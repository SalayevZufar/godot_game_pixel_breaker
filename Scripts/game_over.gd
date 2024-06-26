extends Control


class_name GameOver



@onready var restart_button = $MarginContainer/HBoxContainer/VBoxContainer/Restart_Button as Button

@onready var exit_button =$MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button

@onready var restart_game = "res://Scenes/Control.tscn"
@onready var main_menu_game = "res://Scenes/main_menu.tscn"
@onready var background_music = get_node("/root/BackgroundMusic")

func _ready():
	restart_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
func on_start_pressed():
	get_tree().change_scene_to_file(restart_game)
func on_exit_pressed():
	background_music.play()
	get_tree().change_scene_to_file(main_menu_game)
