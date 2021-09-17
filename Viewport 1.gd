extends Viewport
var num_robots = 1

# Since the mask viewport is not inside a ViewportContainer
#  we have to manually make it match the main viewport.
# We do this by listening to the size changed signal and then updating the mask viewport size.

# Called when the node enters the scene tree for the first time.
func _ready():
	connect('size_changed', self, '_on_viewport_size_changed')
	
	var thread = Thread.new()
	thread.start(self, 'add_robots', 500)
	
func add_robots(count):
	for x in range(0,count):
		call_deferred("add_robot")
		OS.delay_msec(5)

func add_robot():
	var robot = $Robot.duplicate()
	self.add_child(robot)
	num_robots += 1

func _process(delta):
	$Panel/Label.text = "Robots: " + str(num_robots) + "\r\nFPS: " + str(Engine.get_frames_per_second())

func _on_viewport_size_changed():
	get_node("/root/Control/Viewport").set_size(size)
