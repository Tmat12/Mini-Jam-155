extends Node2D

@export_category("Direction Nodes")
@export var down_img : Node
@export var up_img : Node
@export var left_img : Node
@export var right_img : Node

@export_category("Direction Textures")
@export var outline_textures : Array[Texture2D]
@export var filled_textures : Array[Texture2D]

@export_category("Health Textures")
@export var health_textures : Array[Control]

@export_category("Timer Node for Functions")
@export var spawn_timer : Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("wind_down"):
		reset_wind("Down")
		down_img.texture = filled_textures[0]
		GameData.wind_changed = true
	if Input.is_action_just_pressed("wind_up"):
		reset_wind("Up")
		up_img.texture = filled_textures[1]
		GameData.wind_changed = true
	if Input.is_action_just_pressed("wind_left"):
		reset_wind("Left")
		left_img.texture = filled_textures[2]
		GameData.wind_changed = true
	if Input.is_action_just_pressed("wind_right"):
		reset_wind("Right")
		right_img.texture = filled_textures[3]
		GameData.wind_changed = true
		
	# Manage Health
	if GameData.health == 3:
		health_textures[2].visible = true
	if GameData.health == 2:
		health_textures[1].visible = true
		health_textures[2].visible = false
	if GameData.health == 1:
		health_textures[0].visible = true
		health_textures[1].visible = false
	if GameData.health == 0:
		health_textures[0].visible = false

func reset_wind(new_wind_dir):
	GameData.wind_dir = new_wind_dir
	down_img.texture = outline_textures[0]
	up_img.texture = outline_textures[1]
	left_img.texture = outline_textures[2]
	right_img.texture = outline_textures[3]


func _on_timer_timeout():
	var boats : Array[Node]
	boats = get_tree().get_nodes_in_group("Boat")
	var deliveries = get_tree().get_nodes_in_group("Pickupable")
	for boat in boats:
		boat.move_ship()
	if boats.is_empty():
		spawn_timer.spawnBoat()
	for delivery in deliveries:
		if delivery.Type == "Delivery":
			return
	spawn_timer.spawnDelivery()

func _on_boat_spawn_timer_timeout():
	spawn_timer.spawnBoat()

func _on_drop_off_change_timer_timeout():
	for dropOff in get_tree().get_nodes_in_group("DropOff"):
		dropOff.queue_free()
	spawn_timer.spawnDropOff()
