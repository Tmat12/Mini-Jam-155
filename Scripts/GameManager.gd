extends Node2D

@export_category("Scene Crate")
@export var crate_init : RigidBody2D

var crate = preload("res://Scenes/crate.tscn")

var current_crate

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Click"):
		crate_init.position = get_global_mouse_position()
#		remove_child(current_crate)
#		current_crate = crate.instantiate()
#		current_crate.position = get_global_mouse_position()
#		add_child(current_crate)
