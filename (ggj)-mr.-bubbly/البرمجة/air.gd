extends Area3D


func _ready() -> void:
	body_entered.connect(Hit)
	pass

func Hit(body: Node3D) -> void:
	if body.has_meta("Player"):
		body.emit_signal("PlaySound","res://التأثيرات الصوتية/SoundEffects/TouchingWater.mp3")
		body.playerProperties.onHit()
		print(body.playerProperties.HP)
		if body.playerProperties.dead == true:
			body.emit_signal("PlaySound","res://التأثيرات الصوتية/SoundEffects/BackgroundMusic.mp3")
