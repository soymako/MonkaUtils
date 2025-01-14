extends Component
class_name TriggerComponent

@export var customLocalScript:GDScript

signal Triggered()

func trigger()->void:
	if customLocalScript:
		var n:Node = Node.new()
		n.set_script(customLocalScript)
		n.add_child(n)
		if n.has_method("trigger"):
			n.call("trigger")
		else:
			n.queue_free()
			push_error("local script has no `trigger()` method")
		return
	Monka.errors.notImplementedYet(self)
	pass
