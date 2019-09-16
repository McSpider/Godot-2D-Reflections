extends KinematicBody2D

var speed = 20
var c_speed = 100
var velocity = Vector2()
var reflection = null
var is_controllable = false

func _ready():
	randomize()
	start(Vector2(randi()%1004+10,randi()%580+10), randi()%360+1)
	speed = randf()*3+0.5

func update_reflection():
	# FIXME, sometimes the node gets free'd before being re-added to the scene, probably because we are calling this in a thread.
	reflection = $Sprite/Sprite
	$Sprite.remove_child(reflection)
	var container_node = Node2D.new()
	container_node.add_child(reflection)
	get_node("/root/Control/R Viewport/YSort").add_child(container_node)
	reflection = container_node

func start(pos, dir):
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)
	self.z_index = -1

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
	velocity = velocity.normalized() * c_speed


func _physics_process(delta):
	if is_controllable:
		get_input()
		velocity = move_and_slide(velocity*speed)
	else:
		var collision = move_and_collide(velocity*speed * delta)
		if collision:
			velocity = velocity.bounce(collision.normal)
			if collision.collider.has_method("hit"):
				collision.collider.hit()
	
	if (reflection):
		reflection.z_index = self.z_index
		reflection.position = self.position

#func _on_VisibilityNotifier2D_screen_exited():
#	queue_free()
