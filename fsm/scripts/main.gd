extends Node2D

@onready var character: CharacterBody2D = $Character
@onready var slime: StaticBody2D = $Slime

func _process(delta: float) -> void:
	var collision_count = character.get_slide_collision_count()
	for i in collision_count:
		var collision = character.get_slide_collision(i)
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		if "Slime" in collider.name:
			if normal.y < -0.8:
				slime.kill()
