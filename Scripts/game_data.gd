extends Node

var score = 0

var wind_dir = "None"

var wind_changed = false

var health

var boat_num = 1
var delivery_pickups = 1

var timers_started = false
var game_over = false
var tutorial_read = false

func _ready():
	health = 3
