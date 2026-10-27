extends State

class_name Squished

@export var sprite: AnimatedSprite2D
var slime: StaticBody2D

func enter():
	sprite.play("squished")
	slime = sprite.get_parent()
	slime.scale.y = 0.5
	slime.position.y += 10
