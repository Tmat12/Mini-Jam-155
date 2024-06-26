extends CharacterBody2D


@export_category("Boat Textures")
@export var horizontal_texture : Sprite2D
@export var up_texture : Sprite2D
@export var down_texture : Sprite2D

@export var has_package = false

# Number of pixels to move the ship
var grid_pixels = 48
var x
var y


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#first thing that runs
func _ready():
	x = ((position.x - 72)/grid_pixels) + 1
	y = ((position.y - 72)/grid_pixels) - 1

#runs every visual frame
func _process(delta):
	if Input.is_action_just_pressed("wind_down"):
		reset_textures()
		down_texture.visible = true
	if Input.is_action_just_pressed("wind_up"):
		reset_textures()
		up_texture.visible = true
	if Input.is_action_just_pressed("wind_left"):
		reset_textures()
		horizontal_texture.visible = true
		horizontal_texture.flip_h = true
	if Input.is_action_just_pressed("wind_right"):
		reset_textures()
		horizontal_texture.visible = true
		horizontal_texture.flip_h = false
	
	if has_package:
		horizontal_texture.modulate = Color("9dff00")
		up_texture.modulate = Color("9dff00")
		down_texture.modulate = Color("9dff00")
	else:
		horizontal_texture.modulate = Color("b86e28")
		up_texture.modulate = Color("b86e28")
		down_texture.modulate = Color("b86e28")

func reset_textures():
	horizontal_texture.visible = false
	up_texture.visible = false
	down_texture.visible = false


func move_ship():
	if GameData.wind_dir == "None":
		pass
	elif GameData.wind_dir == "Up":
		if y == 1 or ObjPos.rockPos.has(str(x) + str(y - 1)):
			return
		position.y -= 48
		y += 1
	elif GameData.wind_dir == "Down":
		if y == 11 or ObjPos.rockPos.has(str(x) + str(y + 1)):
			return
		position.y += 48
		y -= 1
	elif GameData.wind_dir == "Left":
		if x == 1 or ObjPos.rockPos.has(str(x - 1) + str(y)):
			return
		position.x -= 48
		x -= 1
	elif GameData.wind_dir == "Right":
		if x == 22 or ObjPos.rockPos.has(str(x + 1) + str(y)):
			return
		position.x += 48
		x += 1
	x = ((position.x - 72)/grid_pixels) + 1
	y = ((position.y - 72)/grid_pixels) + 1
