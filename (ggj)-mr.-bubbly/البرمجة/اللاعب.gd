extends CharacterBody3D


const SPEED = 5.0
const FRIC = 0.1
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	%Camera3D.global_position.x += 0.1*(global_position.x-%Camera3D.global_position.x)
	%Camera3D.global_position.z += 0.1*(global_position.z-%Camera3D.global_position.z)
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = lerpf(velocity.x, 0, FRIC)
		velocity.z = lerpf(velocity.z, 0, FRIC)

	move_and_slide()
