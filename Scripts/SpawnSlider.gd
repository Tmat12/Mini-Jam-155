extends HSlider

@export var drop_off_timer : Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = 10 - drop_off_timer.time_left
