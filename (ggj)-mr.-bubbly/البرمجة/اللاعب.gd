extends CharacterBody3D
class_name playerScript

signal TouchedWater
signal PlaySound
signal TouchedBubbles
#signal Hit
#signal die
const CAMERA_DRAG = 0.05
const sizeIncrease = 1.45

var playerProperties: المزايا = preload("res://الموارد/اللاعب/مزايا.tres")

func changeSpeed(value) -> void:
	playerProperties.playerSpeed = value

func updateSize(mult: float) -> void:
	playerProperties.sizeMultiplier = mult
	scale = Vector3(scale.x * playerProperties.sizeMultiplier,scale.y,scale.z * playerProperties.sizeMultiplier)
	changeSpeed(playerProperties.playerSpeed*(1/mult**1.2)) #semi-exponential decrease in speed as size increases
	%PlayerCamera.size += mult-1 # update the camera's y position to keep the height static
	
func on_water_touch(isTouched: bool) -> void:
	if isTouched:
		playerProperties.moistureMultiplier = 6
	else:
		playerProperties.moistureMultiplier = 1

func play_sound(resource: String) -> void:
	var res = load(resource)
	$Sound.stream = res
	$Sound.pitch_scale = (RandomNumberGenerator.new()).randf_range(0.85,1.5)
	$Sound.play()

func on_bubble_touch() -> void:
	playerProperties.numberOfBubbles += 1
	updateSize(sizeIncrease)
	pass

@export var moistureMeter: float
@export var moistureMultiplier: float = 1.0
@export var barTime: float = 30 # in seconds

#Player properties
@export var sizeMultiplier: float = 1.0
@export var playerSpeed: float = 3.0
@export var slip: float = 0.0

@export var HP:float = 12
@export var numberOfBubbles = 0

func _ready() -> void:
	PlaySound.connect(play_sound)
	TouchedWater.connect(on_water_touch)
	TouchedBubbles.connect(on_bubble_touch)
	
	# next level properties
	playerProperties.barTime = barTime
	playerProperties.moistureMultiplier = moistureMultiplier
	playerProperties.sizeMultiplier = sizeMultiplier
	playerProperties.playerSpeed = playerSpeed
	playerProperties.HP = HP
	playerProperties.numberOfBubbles = numberOfBubbles

#func hitted():
	#playerProperties.onHit()
	#print(playerProperties.HP)
#func dead():
	#get_tree().change_scene_to_file("res://المشاهد/main_menu.gd")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and playerProperties.numberOfBubbles > 0:
		var relativePlayer = Vector2(DisplayServer.window_get_size().x / 2,DisplayServer.window_get_size().y / 2)
		var relativeVector = event.position - relativePlayer
		playerProperties.numberOfBubbles -= 1
		
		updateSize((1/sizeIncrease))
		print(relativeVector.normalized())
		
func _process(_delta: float) -> void:
	pass

var canMove = true
var decayFactor: float = 0
var input_dir := Input.get_vector("a", "d", "w", "s")
var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
var additionalSpeed := 3.5*int(Input.is_action_pressed("Sprint"))

func _physics_process(_delta: float) -> void:
	# Camera drag
	%PlayerCamera.position.x += CAMERA_DRAG*(position.x-%PlayerCamera.position.x)
	%PlayerCamera.position.z += CAMERA_DRAG*(position.z-%PlayerCamera.position.z)
	
	# Deplete the moisture meter when sprinting
	if(Input.is_action_pressed("Sprint")):
		playerProperties.moistureMultiplier = 4
	elif Input.is_action_just_released("Sprint"):
		playerProperties.moistureMultiplier = 1
	
	# Bounce effect
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
		
	var collision = move_and_collide(velocity * _delta)
		
	if collision and canMove:
		if Input.is_action_pressed("Sprint"):
			canMove = false
