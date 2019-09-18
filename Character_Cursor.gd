extends Sprite

onready var reflection = $Reflection
# Called when the node enters the scene tree for the first time.
func _ready():
	reparent_reflection()
	pass

func _input(event):
	if event is InputEventMouseMotion:
		self.position = get_global_mouse_position()
		reflection.position = self.position


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
