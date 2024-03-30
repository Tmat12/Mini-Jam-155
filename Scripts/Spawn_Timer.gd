extends Timer

var spawnables = ["res://Scenes/obstacle.tscn", "res://Scenes/rock.tscn", "res://Scenes/pickupable.tscn"]

var boat_scene = "res://Scenes/boat.tscn"

var delivery_scene = "res://Scenes/pickupable.tscn"

var drop_off_scene = "res://Scenes/drop_off.tscn"

var spawnable_weights = [60, 35, 5]

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timeout():
	attemptSpawn()

func attemptSpawn():
	var randPosx = rng.randi_range(0, 21)
	var randPosy = rng.randi_range(0, 10)
	if randPosx == 0 and randPosy == 0:
		return
	if checkOnTop(randPosx, randPosy):
		return
	if checkSurrounding(randPosx, randPosy):
		return
	spawn(weighted_random(), randPosx, randPosy)

func spawnBoat():
	var randPosx = 0
	var randPosy = 0
	if checkOnTop(randPosx, randPosy):
		return
	var boat = load(boat_scene).instantiate()
	boat.position.x = 72 + (randPosx * 48)
	boat.position.y = 72 + (randPosy * 48)
	get_tree().root.add_child(boat)

func spawnDelivery():
	var randPosx = rng.randi_range(0, 21)
	var randPosy = rng.randi_range(0, 10)
	if randPosx == 0 and randPosy == 0:
		return
	if checkOnTop(randPosx, randPosy):
		return
	var delivery = load(delivery_scene).instantiate()
	delivery.position.x = 72 + (randPosx * 48)
	delivery.position.y = 72 + (randPosy * 48)
	delivery.Type = "Delivery"
	get_tree().root.add_child(delivery)
	ObjPos.deliveryPos.append(str(randPosx) + str(randPosy))

func spawnDropOff():
	ObjPos.dropPos.clear()
	var randPosx = rng.randi_range(1, 21)
	var randPosy = rng.randi_range(1, 10)
	var on_boat = false
	if checkOnTop(randPosx, randPosy):
		delete_obj_here(randPosx, randPosy)
	for boats in get_tree().get_nodes_in_group("Boat"):
		if randPosx == boats.x and randPosy == boats.y:
			on_boat = true
	if not on_boat:
		if checkOnTop(randPosx, randPosy):
			delete_obj_here(randPosx, randPosy)
	var drop_off = load(drop_off_scene).instantiate()
	drop_off.position.x = 72 + (randPosx * 48)
	drop_off.position.y = 72 + (randPosy * 48)
	get_tree().root.add_child(drop_off)
	ObjPos.dropPos.append(str(randPosx) + str(randPosy))

func delete_obj_here(x, y):
	for rock in get_tree().get_nodes_in_group("Rock"):
		if rock.x == x and rock.y == y:
			ObjPos.rockPos.erase(str(rock.x) + str(rock.y))
			rock.queue_free()
	for obs in get_tree().get_nodes_in_group("Obstacle"):
		if obs.x == x and obs.y == y:
			ObjPos.objPos.erase(str(obs.x) + str(obs.y))
			obs.queue_free()
	for pickup in get_tree().get_nodes_in_group("Pickupable"):
		if pickup.x == x and pickup.y == y:
			if pickup.Type == "Health":
				ObjPos.pickupPos.erase(str(pickup.x) + str(pickup.y))
			else:
				ObjPos.deliveryPos.erase(str(pickup.x) + str(pickup.y))
			pickup.queue_free()

func checkOnTop(randPosx, randPosy):
	if ObjPos.rockPos.has(str(randPosx) + str(randPosy)):
		return true
	if ObjPos.pickupPos.has(str(randPosx) + str(randPosy)):
		return true
	if ObjPos.objPos.has(str(randPosx) + str(randPosy)):
		return true
	if ObjPos.dropPos.has(str(randPosx) + str(randPosy)):
		return true
	if ObjPos.deliveryPos.has(str(randPosx) + str(randPosy)):
		return true
	for boats in get_tree().get_nodes_in_group("Boat"):
		if randPosx == boats.x and randPosy == boats.y:
			return true
	return false

func checkSurrounding(x, y):
	if ObjPos.objPos.has(str(x + 1) + str(y)):
		return true
	if ObjPos.objPos.has(str(x - 1) + str(y)):
		return true
	if ObjPos.objPos.has(str(x + 1) + str(y + 1)):
		return true
	if ObjPos.objPos.has(str(x - 1) + str(y - 1)):
		return true
	if ObjPos.objPos.has(str(y + 1) + str(x)):
		return true
	if ObjPos.objPos.has(str(y - 1) + str(x)):
		return true
	if ObjPos.objPos.has(str(y + 1) + str(x - 1)):
		return true
	if ObjPos.objPos.has(str(y - 1) + str(x + 1)):
		return true
	
	return false

func spawn(object, x, y):
	var obj = load(spawnables[object]).instantiate()
	obj.position.x = 72 + (x * 48)
	obj.position.y = 72 + (y * 48)
	get_tree().root.add_child(obj)
	
	if object == 0:
		ObjPos.objPos.append(str(x + 1) + str(y + 1))
	if object == 1:
		ObjPos.rockPos.append(str(x + 1) + str(y + 1))
	if object == 2:
		ObjPos.pickupPos.append(str(x + 1) + str(y + 1))

func weighted_random():
	var sum_of_weights = 0
	for weight in spawnable_weights:
		sum_of_weights += weight
	var rand = randi() % sum_of_weights
	for i in range(spawnable_weights.size()):
		if rand < spawnable_weights[i]:
			return i
		rand -= spawnable_weights[i]
