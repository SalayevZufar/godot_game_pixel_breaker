class_name MainMenu
extends Control


@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/Start_Button as Button

@onready var exit_button =$MarginContainer/HBoxContainer/VBoxContainer/Exit_Button as Button

@onready var about_us_button = $about_us as Button
@onready var background_music = get_node("/root/BackgroundMusic")
@onready var start_level = "res://Scenes/Control.tscn"
@onready var about_us = "res://Scenes/about_us.tscn"
func _ready():
	start_button.button_down.connect(on_start_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	about_us_button.button_down.connect(on_about_us_pressed)
func on_start_pressed():
	background_music.stop()
	get_tree().change_scene_to_file(start_level)
	

func on_about_us_pressed():
	
	get_tree().change_scene_to_file(about_us)	

func on_exit_pressed():
	background_music.stop()
	get_tree().quit()







