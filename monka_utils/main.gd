@tool
@icon("res://icon.svg")
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("TriggerBox", "Area3D", preload("scripts/trigger_box.gd"), preload("icons/trigger_box.svg"))
	add_custom_type("Component", "Node", preload("scripts/component.gd"), preload("icons/component.svg"))
	add_custom_type("Air", "Area3D", preload("scripts/air.gd"), preload("icons/air.svg"))
	add_autoload_singleton("Monka", "scripts/autoloads/monka_autoload.gd")
	
	
	#AudioServer.add_bus(1)
	#AudioServer.add_bus(2)
	#AudioServer.add_bus(3)
	#AudioServer.set_bus_name(1, "SFX")
	#AudioServer.set_bus_name(2, "Voices")
	#AudioServer.set_bus_name(3, "Music")
	pass


func _exit_tree() -> void:
	remove_custom_type("TriggerBox")
	remove_custom_type("Component")
	remove_custom_type("Air")
	#AudioServer.remove_bus(AudioServer.get_bus_index("SFX"))
	#AudioServer.remove_bus(AudioServer.get_bus_index("Music"))
	#AudioServer.remove_bus(AudioServer.get_bus_index("Voices"))
	
	remove_autoload_singleton("Monka")
	pass
