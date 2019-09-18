extends KinematicBody2D

export (int) var speed = 100

var velocity = Vector2()
export var is_controllable = false

var reflection = null
var m_viewport
var r_viewport
signal camera_moved

func _ready():
	if has_node("Camera2D"):
		setup_camera()
	reparent_reflection()

func setup_camera():
	m_viewport = get_node("/root/Control/M Viewport")
	if has_node("/root/Control/R Viewport"):
		r_viewport = get_node("/root/Control/R Viewport")

	connect("camera_moved", m_viewport, "main_camera_moved")
	connect("camera_moved", r_viewport, "main_camera_moved")

	var mask_node = get_node("/root/Control/ViewportContainer/Viewport/Mask")
	connect("camera_moved", mask_node, "main_camera_moved")
	var reflections_node = get_node("/root/Control/ViewportContainer/Viewport/Reflections")
	connect("camera_moved", reflections_node, "main_camera_moved")
	
	mask_node.main_camera_changed(self, $Camera2D)
	reflections_node.main_camera_changed(self, $Camera2D)
	m_viewport.main_camera_changed(self, $Camera2D)
	r_viewport.main_camera_changed(self, $Camera2D)
	
#	### Fixes snap after resize but breaks alignment during resize
#	get_viewport().connect('size_changed', self, 'main_viewport_resized')
#
#func main_viewport_resized():
#	if has_node("Camera2D") and $Camera2D.current:
#		$Camera2D.force_update_scroll()
#
#		emit_signal("camera_moved", self, $Camera2D)
###

func reparent_reflection():
	if not has_node("Reflection"):
		return
	
	# We have a reflection, reparent it into the reflections viewport.
	# Keep a reference to it so we can update is position
	# In this case we are Y sorting the characters so do the same for reflections
	if has_node("/root/Control/R Viewport/YSort"):
		reflection = $Reflection
		self.remove_child(reflection)
		var container_node = Node2D.new()
		container_node.add_child(reflection)
		get_node("/root/Control/R Viewport/YSort").add_child(container_node)
		reflection = container_node


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	if is_controllable:
		get_input()
		velocity = move_and_slide(velocity)
	
	# Update the reflections position
	update_reflections()

var _prev_camera_center = null
func update_reflections():
	if reflection:
		reflection.position = self.position
	
	if has_node("Camera2D") and $Camera2D.current:
		# Fix used to prevent camera lag when moving at/with the drag margin
		$Camera2D.force_update_scroll()
		
		# Only emit the camera moved signal if the camera actually moved (Doesn't really matter, but easy enough to check.)
		if $Camera2D.get_camera_screen_center() != _prev_camera_center:
			emit_signal("camera_moved", self, $Camera2D)
			_prev_camera_center = $Camera2D.get_camera_screen_center()

