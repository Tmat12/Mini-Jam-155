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
@export var move_timer : Timer
@export var spawn_timer : Timer
@export var boat_spawn_timer : Timer
@export var drop_off_timer : Timer

@export_category("Animation Player")
@export var anim_player : AnimationPlayer

@export_category("Game Over Control")
@export var game_over_container : Node

func _ready():
	anim_player.play("opening")
	GameData.timers_started = false
	GameData.game_over = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("wind_down"):
		reset_wind("Down")
		down_img.texture = filled_textures[0]
		GameData.wind_changed = true
		if not GameData.timers_started:
			start_timers()
	if Input.is_action_just_pressed("wind_up"):
		reset_wind("Up")
		up_img.texture = filled_textures[1]
		GameData.wind_changed = true
		if not GameData.timers_started:
			start_timers()
	if Input.is_action_just_pressed("wind_left"):
		reset_wind("Left")
		left_img.texture = filled_textures[2]
		GameData.wind_changed = true
		if not GameData.timers_started:
			start_timers()
	if Input.is_action_just_pressed("wind_right"):
		reset_wind("Right")
		right_img.texture = filled_textures[3]
		GameData.wind_changed = true
		if not GameData.timers_started:
			start_timers()
		
	# Manage Health
	if GameData.health == 3 and not GameData.game_over:
		health_textures[2].visible = true
	if GameData.health == 2:
		health_textures[1].visible = true
		health_textures[2].visible = false
	if GameData.health == 1:
		health_textures[0].visible = true
		health_textures[1].visible = false
	if GameData.health == 0:
		health_textures[0].visible = false
		end_game()

func end_game():
	stop_timers()
	health_textures[0].visible = false
	game_over_container.visible = true
	GameData.game_over = true
	GameData.health = 3
	GameData.wind_dir = "None"
	GameData.wind_changed = false
	GameData.score = 0

func start_timers():
	move_timer.start()
	spawn_timer.start()
	boat_spawn_timer.start()
	drop_off_timer.start()
	GameData.timers_started = true

func stop_timers():
	move_timer.stop()
	spawn_timer.stop()
	boat_spawn_timer.stop()
	drop_off_timer.stop()

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
