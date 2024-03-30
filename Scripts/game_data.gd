extends Node

var score = 0

var wind_dir = "None"

var wind_changed = false

var health

var boat_num = 1
var delivery_pickups = 1

func _ready():
	health = 3
