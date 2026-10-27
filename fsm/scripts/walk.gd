extends State

class_name Walk

@export var sprite: AnimatedSprite2D
var player: CharacterBody2D

func enter():
	player = sprite.get_parent()
	sprite.play("walk")

func update(delta: float):
	var direction := Input.get_axis("ui_left", "ui_right")
	if !direction:
		transition.emit(self, "idle")
	
	if direction:
		player.velocity.x = direction * player.SPEED
		sprite.flip_h = direction < 0
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	
	if Input.is_action_just_pressed("ui_up") and player.is_on_floor():
		transition.emit(self, "jump")
