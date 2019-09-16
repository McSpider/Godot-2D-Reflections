extends KinematicBody2D

export (int) var speed = 100

var velocity = Vector2()
var reflection = null
export var is_controllable = false

func _ready():
	update_reflection()

func update_reflection():
	# Are we part of a YSort tree?, if so update our reflection
	# This moves the sprites reflection into the reflection viewport.
	# We keep a reference to it so we can update is position
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

func _physics_process(delta):
	if is_controllable:
		get_input()
		velocity = move_and_slide(velocity)
	
	# Update the reflections position
	if (reflection):
		reflection.position = self.position
