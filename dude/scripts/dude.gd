extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $DudeSprite

const SPEED = 200.0
const JUMP_SPEED = -400.0
const GRAVITY = 800.0

var state = "idle"
var double_jump: bool = true
const BOUNCE_DELAY: float = 0.2
var bounce_delay: float = 0

func _ready() -> void:
	animation.play(state)
	
func _physics_process(delta: float) -> void:
		
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	var direction = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * SPEED
	
	if is_on_floor():
		if bounce_delay <= 0:
			pass
		else:
			bounce_delay -= delta
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_SPEED
		double_jump = true
	
	if Input.is_action_just_pressed("ui_up") and not is_on_floor() and double_jump:
		velocity.y = JUMP_SPEED
		double_jump = false
	
	if not is_on_floor(): 
		animation.play("jump")
	elif direction != 0:
		sprite.flip_h = direction < 0
		animation.play("walk")
	else:
		animation.play("idle")
		
	move_and_slide()
	
	var collision_count = get_slide_collision_count()
	for i in collision_count:
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var normal = collision.get_normal()
		if "StaticBox" in collider.name:
			if normal.y > 0.8:
				velocity += normal * SPEED * 1.1
		if "JumpBox" in collider.name:
			if normal.y < -0.8:
				velocity.y = normal.y * SPEED * 3
		if "Wall" in collider.name:
			if abs(normal.x) > 0.8:
				velocity += normal * SPEED
				bounce_delay = BOUNCE_DELAY
