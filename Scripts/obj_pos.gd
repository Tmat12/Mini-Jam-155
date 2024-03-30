extends Node


var rockPos
var objPos
var pickupPos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameData.obj_spawned:
		for rocks in get_tree().get_nodes_in_group("Rocks")
