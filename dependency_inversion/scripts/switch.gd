class_name Switch
extends StaticBody3D

@export var switchable: Node3D

var goal_position: float
var up_position: float
var down_position: float

var goal_scale: float
var up_scale: float
var down_scale: float
var is_switch_pressed: bool
var tmp: bool

@onready var spring_position := FloatSpring.new(20, 0.4)
@onready var spring_scale := FloatSpring.new(20, 0.2)
@onready var nudge_timer := Timer.new()
@onready var button_mesh: MeshInstance3D = $ButtonMesh
@onready var base_mesh: MeshInstance3D = $BaseMesh


func _ready() -> void:
	up_position = button_mesh.position.y
	down_position = up_position - 0.087
	goal_position = up_position
	spring_position.reset(goal_position)
	
	up_scale = 1
	down_scale = up_scale - 0.03
	goal_scale = up_scale
	spring_scale.reset(goal_scale)
	
	add_child(nudge_timer)
	nudge_timer.wait_time = 5.0
	nudge_timer.one_shot = false
	nudge_timer.timeout.connect(nudge_spring.bind(2.0))
	nudge_timer.start()


func _process(delta: float) -> void:
	button_mesh.position.y = spring_position.update(delta, goal_position)
	
	var scale_by := spring_scale.update(delta, goal_scale) - 1
	base_mesh.scale = Vector3(1 - scale_by, 1 + scale_by, 1 - scale_by)


func toggle() -> void:
	if switchable == null:
		return
		
	if switchable.has_meta("Switchable"):
		var switch := (switchable.get_meta("Switchable") as Switchable)
		if not switch.is_active:
			switch.activate()

			goal_position = down_position
			spring_position.position = down_position
			spring_position.velocity = 0
			
			goal_scale = down_scale
			spring_scale.position = down_scale
			spring_scale.velocity = 0
			
			is_switch_pressed = true
		else:
			switch.deactivate()

			goal_position = up_position
			goal_scale = up_scale
			
			is_switch_pressed = false


func nudge_spring(force: float = 1) -> void:
	if is_switch_pressed:
		return
		
	spring_scale.velocity += force
	spring_position.velocity += force
