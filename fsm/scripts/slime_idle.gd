extends State

class_name Slime_idle

@export var sprite: AnimatedSprite2D
var slime: StaticBody2D

func enter():
	slime = sprite.get_parent()
	sprite.play("idle")

func update(delta: float):
	if !slime.alive:
		transition.emit(self, "squished")
