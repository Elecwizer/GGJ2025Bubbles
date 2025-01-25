extends Resource
class_name المزايا

#Moisture meter properties
@export var moistureMeter: float
@export var moistureMultiplier: float = 1.0
@export var barTime: float = 60 # in seconds

var dead:bool = false

#Player properties
@export var sizeMultiplier: float = 1.0
@export var playerSpeed: float = 3.0
@export var slip: float = 0.0
