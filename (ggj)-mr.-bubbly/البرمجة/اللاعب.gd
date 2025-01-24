extends CharacterBody3D

var playerProperties: المزايا = preload("res://الموارد/اللاعب/مزايا.tres")
const CAMERA_DRAG = 0.05

func changeSpeed(value) -> void:
	playerProperties.playerSpeed = value

func updateSize(mult: float) -> void:
	playerProperties.sizeMultiplier = mult
	scale = Vector3(scale.x * playerProperties.sizeMultiplier,scale.y,scale.z * playerProperties.sizeMultiplier)
	changeSpeed(playerProperties.playerSpeed*(1/mult**1.2)) #semi-exponential decrease in speed as size increases
	%Camera3D.position.y += mult-1 # update the camera's y position to keep the height static
	
func _ready() -> void:
	updateSize(1)

func _physics_process(delta: float) -> void:
	
	# Camera drag
	%Camera3D.position.x += CAMERA_DRAG*(position.x-%Camera3D.position.x)
	%Camera3D.position.z += CAMERA_DRAG*(position.z-%Camera3D.position.z)
	

	var input_dir := Input.get_vector("a", "d", "w", "s")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * playerProperties.playerSpeed
		velocity.z = direction.z * playerProperties.playerSpeed
	else:

		velocity.x = move_toward(velocity.x, 0, playerProperties.playerSpeed)
		velocity.z = move_toward(velocity.z, 0, playerProperties.playerSpeed)

	move_and_slide()
