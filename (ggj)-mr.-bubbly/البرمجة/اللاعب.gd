extends CharacterBody3D
class_name playerScript

var playerProperties: المزايا = preload("res://الموارد/اللاعب/مزايا.tres")
const CAMERA_DRAG = 0.05

func changeSpeed(value) -> void:
	playerProperties.playerSpeed = value

func updateSize(mult: float) -> void:
	playerProperties.sizeMultiplier = mult
	scale = Vector3(scale.x * playerProperties.sizeMultiplier,scale.y,scale.z * playerProperties.sizeMultiplier)
	changeSpeed(playerProperties.playerSpeed*(1/mult**1.2)) #semi-exponential decrease in speed as size increases
	%Camera3D.size += mult-1 # update the camera's y position to keep the height static
	
func _ready() -> void:
	playerProperties.moistureMeter = %MeterBar.scale.y # calibrate the scales
	updateSize(1)

const maximumTime := 15.0 #in seconds
func _process(_delta: float) -> void:
	
	#Moisture meter bar depletion
	if(%MeterBar.scale.y > 0):
		# (1/_delta) is used to linearize the time since _process is called (1/_delta) times within 1 second
		%MeterBar.scale.y -= playerProperties.moistureMeter/(maximumTime*(1/_delta)) * playerProperties.moistureMultiplier
		%MeterBar.position.y += playerProperties.moistureMeter/(maximumTime*(1/_delta)) * playerProperties.moistureMultiplier * 0.5


var canMove = true
var decayFactor: float = 0
var input_dir := Input.get_vector("a", "d", "w", "s")
var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
var additionalSpeed := 3.5*int(Input.is_action_pressed("Sprint"))

func _physics_process(_delta: float) -> void:
	
	# Camera drag
	%Camera3D.position.x += CAMERA_DRAG*(position.x-%Camera3D.position.x)
	%Camera3D.position.z += CAMERA_DRAG*(position.z-%Camera3D.position.z)
	
	if(Input.is_action_pressed("Sprint")):
		playerProperties.moistureMultiplier = 4
	else:
		playerProperties.moistureMultiplier = 1
	
	# bounce effect
	if not canMove:
		velocity.x = -direction.x * (25 - decayFactor)
		velocity.z = -direction.z * (25 - decayFactor)
		decayFactor += 1
		
		if(decayFactor > 15):
			canMove = true
			decayFactor = 0
	
	elif canMove:
		input_dir = Input.get_vector("a", "d", "w", "s")
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		additionalSpeed = 3.5 * int(Input.is_action_pressed("Sprint"))
		
		if direction:
			velocity.x = direction.x * (playerProperties.playerSpeed + additionalSpeed)
			velocity.z = direction.z * (playerProperties.playerSpeed + additionalSpeed)
		else:
			velocity.x = move_toward(velocity.x, 0, playerProperties.playerSpeed + additionalSpeed)
			velocity.z = move_toward(velocity.z, 0, playerProperties.playerSpeed + additionalSpeed)
		
	var collision = move_and_slide()
		
	
	if collision and Input.is_action_pressed("Sprint") and canMove:
		canMove = false
