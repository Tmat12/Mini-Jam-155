extends Button

@export var anim_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	anim_player.play("transition")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
