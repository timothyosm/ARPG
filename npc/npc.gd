extends CharacterBody2D

@export var speed = 20
@export var player: Node2D = null
@onready var nav_agent = $NavigationAgent2D as NavigationAgent2D
@onready var animations = $AnimatedSprite2D

# Define a stopping threshold for distance to player
var stop_threshold = 50

func updateAnimation():
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = "Down"
		if velocity.x < 0: direction = "Left"
		elif velocity.x > 0: direction = "Right"
		elif velocity.y < 0: direction = "Up"
		elif velocity.y > 0: direction = "Down"
		animations.play("walk" + direction)

func _physics_process(_delta: float) -> void:
	# Check distance to player
	if global_position.distance_to(player.global_position) < stop_threshold:
		velocity = Vector2()
		updateAnimation()
		return

	var next_pos = nav_agent.get_next_path_position()
	if next_pos != Vector2():
		var dir = to_local(next_pos).normalized()
		velocity = dir * speed
		move_and_slide()
		updateAnimation()

func make_path():
	nav_agent.target_position = player.global_position

func _on_timer_timeout():
	make_path()
