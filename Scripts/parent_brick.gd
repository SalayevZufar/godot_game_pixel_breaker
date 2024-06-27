extends StaticBody2D

var brick_lives:int = 20
var life:int = 1
var add_num:int = 0

#static var life:int = 1
@onready var brick_life := $brick_life
var x = 0



	
func _ready():

	
	life = randi() % brick_lives +1
	
	brick_life.text = str(life)

func take_life():
	life -=1
	brick_life.text = str(life)
	if life < 1:
		
		$break_sound.play()
		queue_free()
		
