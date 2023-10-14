extends CharacterBody2D

@export var speed: int = 35
@onready var animations = $AnimationPlayer

var direction: Vector2 = Vector2(0, 1)  # Start by moving downwards
var timer: float = 0
var change_interval: float = 2.0  # Time in seconds after which NPC changes direction

func change_direction():
	direction = Vector2(randi()%3 - 1, randi()%3 - 1).normalized()
	timer = 0  # Reset the timer

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var anim_direction = "Down"
		if direction.x < 0: anim_direction = "Left"
		elif direction.x > 0: anim_direction = "Right"
		elif direction.y < 0: anim_direction = "Up"
		elif direction.y > 0: anim_direction = "Down"
		animations.play("walk" + anim_direction)
	
func _physics_process(delta):
	velocity = direction * speed  # Set the velocity based on the direction
	move_and_slide()
	updateAnimation()

	timer += delta
	if timer >= change_interval:
		change_direction()
