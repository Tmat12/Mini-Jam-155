extends Area2D

var x
var y

func _ready():
	x = ((position.x - 72) / 48)
	y = ((position.y - 72) / 48)

func _on_body_entered(body):
	if body.has_package:
		body.has_package = false
		GameData.score += 1

func _on_area_entered(area):
	area.queue_free()
