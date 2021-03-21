extends Spatial

onready var front = $Front
onready var back = $Back
onready var left = $Left
onready var right = $Right
onready var mesh = $MeshInstance
onready var floor_texture = $FloorTile
var speed = 0.04
var toxic = 0
var toxic_num = 1
var radable = false
onready var TIME = $Timer
var material = SpatialMaterial.new()
export var colour: float = 0
func _ready():
	
	material.set_albedo(Color( 0, colour, 0, 1 ))
	material.set_texture(SpatialMaterial.TEXTURE_ALBEDO,floor_texture)
	mesh.material_override = material
	
func _physics_process(delta):
	#print(TIME.is_stopped())
	if front.is_colliding():
		var target = front.get_collider()
		if target.material.albedo_color[1] >= 1 and TIME.is_stopped():
			radable = true
	if back.is_colliding():
		var target = back.get_collider()
		if target.material.albedo_color[1] >= 1 and TIME.is_stopped():
			radable = true
	if left.is_colliding() :
		var target = left.get_collider()
		if target.material.albedo_color[1] >= 1 and TIME.is_stopped():
			radable = true
	if right.is_colliding():
		var target = right.get_collider()
		if target.material.albedo_color[1] >= 1 and TIME.is_stopped():
			radable = true
	#print(radable)
	if radable == true:
		
		spreading()
	
func spreading():
	
	toxic += speed
	material.set_albedo(Color( 0, toxic, 0, 1 ))
	material.set_texture(SpatialMaterial.TEXTURE_ALBEDO,floor_texture)
	mesh.material_override = material
	#print(material.albedo_color)
