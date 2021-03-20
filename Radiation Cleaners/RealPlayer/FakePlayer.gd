extends KinematicBody

var speed = 5
var angle_speed = 10
var current_dir = Vector3()
var next_pos = Vector3()
var destination = Vector3()
var can_move = false
var collision_array = []
var time = 5
var points = 0
onready var collision_node = Global.collision
onready var button_duration = $Timer
onready var health_label = $CanvasLayer/Label
onready var points_label = $CanvasLayer/Point
onready var ray = $RayCast

func _ready():
	Global.player = self
	current_dir = "up"
	next_pos = Vector3.FORWARD
	destination = translation
	generate_collision()
	
func _process(delta):
	time = clamp(time,0,60)
	health_label.set_text(str(int(time)))
	points_label.set_text(str(points))
	time -= 1 * delta
	if time <= 0:
		game_over()
	
func generate_collision():
	for i in collision_node.get_child_count():
		var node = collision_node.get_child(i)
		collision_array.append(node.translation)

func game_over():
	print("Game Over")

func _physics_process(delta):
	translation = translation.move_toward(destination,speed * delta)
	$Mesh.rotation.y = lerp_angle($Mesh.rotation.y, atan2(-next_pos.x, -next_pos.z), delta * angle_speed)
	
	if Input.is_action_pressed("Interact"):
		if ray.is_colliding():
			var cube = ray.get_collider()
			if cube.is_in_group("Floor"):
				if cube.material.albedo_color[1] >= 0.3:
					points += 1
					cube.TIME.start()
					cube.speed = 0
					cube.toxic = 0
					cube.radable = false
					cube.material.albedo_color[1] = 0

	if !translation + Vector3.FORWARD in collision_array:
		if Input.is_action_pressed("w") and button_duration.is_stopped():
			next_pos = Vector3.FORWARD
			current_dir = "w"
			can_move = true
			button_duration.start()
	if !translation + Vector3.BACK in collision_array:
		if Input.is_action_pressed("s") and button_duration.is_stopped():
			next_pos = Vector3.BACK
			current_dir = "s"
			can_move = true
			button_duration.start()
	if !translation + Vector3.LEFT in collision_array:
		if Input.is_action_pressed("a") and button_duration.is_stopped():
			next_pos = Vector3.LEFT
			current_dir = "a"
			can_move = true
			button_duration.start()
	if !translation + Vector3.RIGHT in collision_array:
		if Input.is_action_pressed("d") and button_duration.is_stopped():
			next_pos = Vector3.RIGHT
			current_dir = "d"
			can_move = true
			button_duration.start()
		
	if translation.distance_to(destination) <= 0.0000 and can_move:
		destination = translation + (next_pos)
		destination = translation + (next_pos)
		can_move = false

