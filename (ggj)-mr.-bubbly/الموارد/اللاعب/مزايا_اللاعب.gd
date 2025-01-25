extends Resource
class_name المزايا

#Moisture meter properties
@export var moistureMeter: float
@export var moistureMultiplier: float = 1
@export var barTime: float = 60 # in seconds

#Player properties
@export var sizeMultiplier: float = 1
@export var playerSpeed: float = 4
@export var slip: float = 0.0

@export var HP:float = 12
@export var numberOfBubbles = 0

var dead:bool = false

signal die

func onHit(damage:float = 3):
	if HP > 0:
		HP -= damage
	else:
		dead = true
		print("dead")
