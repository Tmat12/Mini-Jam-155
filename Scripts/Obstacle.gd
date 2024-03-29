extends Area2D
@export var sprite: Sprite2D


var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	var randNum = rng.randi_range(1,2)
	if randNum == 1:
		sprite.frame_coords.x = 25
		sprite.frame_coords.y = 8
		sprite.modulate = Color("b83d3f")
	if randNum == 2:
		sprite.frame_coords.x = 7
		sprite.frame_coords.y = 6
		sprite.modulate = Color("005475")
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_body_entered(body):
	body.queue_free()
