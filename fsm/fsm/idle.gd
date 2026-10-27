extends State

class_name Idle

@export var sprite: AnimatedSprite2D
var player: CharacterBody2D

func enter():
	player = sprite.get_parent()
	player.velocity.x = 0
	sprite.play("idle")

func update(delta: float):
	if Input.get_axis("ui_left", "ui_right"):
		transition.emit(self, "walk")
		
	if Input.is_action_just_pressed("ui_up") and player.is_on_floor():
		transition.emit(self, "jump")
