extends State

class_name Double_jump

@export var sprite: AnimatedSprite2D
var player: CharacterBody2D

func enter():
	player = sprite.get_parent()
	sprite.play("double_jump")
	player.velocity.y = player.JUMP_VELOCITY
	
func update(delta: float):
	if player.velocity.y > 0:
		transition.emit(self, "fall")
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player.velocity.x = direction * player.SPEED
		sprite.flip_h = direction < 0
