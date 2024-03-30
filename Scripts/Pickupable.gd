extends Area2D

@export var Type = "Health"
@export var sprite : Node

func _ready():
	if Type == "Health":
		sprite.frame_coords.x = 31
		sprite.frame_coords.y = 9
	elif Type == "Delivery":
		sprite.frame_coords.x = 41
		sprite.frame_coords.y = 4

func _on_body_entered(body):
	if Type == "Health":
		if GameData.health < 3:
			GameData.health += 1
			queue_free()
	elif Type == "Delivery":
		if not body.has_package:
			body.has_package = true
			queue_free()
