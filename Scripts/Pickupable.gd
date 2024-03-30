extends Area2D

@export var Type = "Health"
@export var sprite : Node

var rng = RandomNumberGenerator.new()
var x = 22
var y = 11

func _ready():
	var randPosx = rng.randi_range(72, (x * 48) +72)
	var randPosy = rng.randi_range(72, (y * 48) +72)
	if Type == "Health":
		sprite.frame_coords.x = 31
		sprite.frame_coords.y = 9
		position.x = randPosx
		position.y = randPosy 
	elif Type == "Delivery":
		sprite.frame_coords.x = 41
		sprite.frame_coords.y = 4
		position.x = randPosx
		position.y = randPosy 

func _on_body_entered(body):
	if Type == "Health":
		if GameData.health < 3:
			GameData.health += 1
			queue_free()
	elif Type == "Delivery":
		if not body.has_package:
			body.has_package = true
			queue_free()
