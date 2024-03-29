extends CharacterBody2D

@export_category("Boat Textures")
@export var horizontal_texture : Sprite2D
@export var up_texture : Sprite2D
@export var down_texture : Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Number of pixels to move the ship
var grid_pixels = 48

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if GameData.wind_changed:
		reset_textures()
		if GameData.wind_dir == "None":
			horizontal_texture.visible = true
		elif GameData.wind_dir == "Up":
			up_texture.visible = true
		elif GameData.wind_dir == "Down":
			down_texture.visible = true
		elif GameData.wind_dir == "Left":
			horizontal_texture.visible = true
			horizontal_texture.flip_h = true
		elif GameData.wind_dir == "Right":
			horizontal_texture.visible = true
			horizontal_texture.flip_h = false
		GameData.wind_changed = false

func reset_textures():
	horizontal_texture.visible = false
	up_texture.visible = false
	down_texture.visible = false


func _on_timer_timeout():
	if GameData.wind_dir == "None":
		pass
	elif GameData.wind_dir == "Up":
		position.y -= 48
	elif GameData.wind_dir == "Down":
		position.y += 48
	elif GameData.wind_dir == "Left":
		position.x -= 48
	elif GameData.wind_dir == "Right":
		position.x += 48
