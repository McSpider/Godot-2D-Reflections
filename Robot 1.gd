extends KinematicBody2D

var speed = 20
var velocity = Vector2(speed, 0)

func _ready():
	randomize()
	speed = randf()*50+10
	start(Vector2(randi()%1004+10,randi()%580+10), randi()%360+1)


func start(pos, dir):
	position = pos
	velocity = Vector2(speed, 0).rotated(dir)
	self.z_index = -1

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
