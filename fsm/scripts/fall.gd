extends State

class_name Fall

@export var sprite: AnimatedSprite2D
var player: CharacterBody2D

func enter():
	player = sprite.get_parent()
	sprite.play("fall")
	
func update(delta: float):
	if player.is_on_floor():
		transition.emit(self, "walk")
	elif Input.is_action_just_pressed("ui_up"):
		transition.emit(self, "double_jump") 
	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = direction * player.SPEED
		sprite.flip_h = direction < 0

func exit():
	pass
