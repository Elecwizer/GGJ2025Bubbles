extends Node

var playerProperties: المزايا = preload("res://الموارد/اللاعب/مزايا.tres")
var maximumTime := playerProperties.barTime # in seconds

func _ready() -> void:
	playerProperties.moistureMeter = $MeterBar.scale.y # calibrate the scales

func _process(_delta: float) -> void:
	#Moisture meter bar depletion
	
	if($MeterBar.scale.y > 0):
		# (1/_delta) is used to linearize the time since _process is called (1/_delta) times within 1 second
		$MeterBar.scale.y -= playerProperties.moistureMeter/(maximumTime*(1/_delta)) * playerProperties.moistureMultiplier
		$MeterBar.position.y += playerProperties.moistureMeter/(maximumTime*(1/_delta)) * playerProperties.moistureMultiplier * 0.5
	else:
		print("game over")
