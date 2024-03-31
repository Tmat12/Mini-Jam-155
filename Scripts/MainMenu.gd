extends Control


@export var anim_player : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	anim_player.play_backwards("transition")
	GameData.tutorial_read = false
