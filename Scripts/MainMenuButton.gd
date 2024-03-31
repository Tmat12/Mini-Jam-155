extends Button

@export var anim_player : AnimationPlayer

func _on_pressed():
	GameData.game_over = true
	ObjPos.reset_pos()
	anim_player.play_backwards("opening")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
