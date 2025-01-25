extends Area3D

func _ready() -> void:
	body_entered.connect(on_touch)
	body_exited.connect(on_touch_leave)
	pass

func on_touch(body: Node3D) -> void:
	if body.has_meta("Player"):
		body.emit_signal("TouchedWater",true)

func on_touch_leave(body: Node3D) -> void:
	if body.has_meta("Player"):
		body.emit_signal("TouchedWater",false)
