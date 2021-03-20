extends KinematicBody

var health = 50
onready var front = $Front
onready var back = $Back
onready var left = $Left
onready var right = $Right
onready var timer = $Timer
onready var mesh = $MeshInstance
var radiated = false
var material = SpatialMaterial.new()

func _ready():
	material.set_albedo(Color( 1, 0, 0, 1 ))
	mesh.material_override = material
	Global.health_cube = self
func _physics_process(delta):
	
	if front.is_colliding():
		var target = front.get_collider()
		if target.material.albedo_color[1] == 1:
			radiated = true
			timer.start()
			
	if back.is_colliding():
		var target = back.get_collider()
		if target.material.albedo_color[1] == 1:
			radiated = true
			timer.start()
			
	if left.is_colliding():
		var target = left.get_collider()
		if target.material.albedo_color[1] == 1:
			radiated = true
			timer.start()
			
	if right.is_colliding():
		var target = right.get_collider()
		if target.material.albedo_color[1] == 1:
			radiated = true
			timer.start()
			
func _on_Timer_timeout():
	
	health = health - 1
	radiated = false
