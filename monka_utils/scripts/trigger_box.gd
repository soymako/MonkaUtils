@tool
extends Area3D
class_name TriggerBox

signal Triggered(body:Node3D)

var hasCollision:bool = false
var hasTriggerComponent:bool = false

var triggerComponent:TriggerComponent


@export var option:triggerBoxTypes = triggerBoxTypes.FREE;



## [b][color=green]True[/color][/b]: [TriggerBox] only works once[br]
## [b][color=red]False[/color][/b]: [TriggerBox] Allows to be [b][i][u]triggered[/u][/i][/b] multiple times without deactivating
## [br][br]
## [color=orange] Note: You can change the [param triggered] value by using [codeblock]triggered = value[/codeblock] or [method TriggerBox.restart]
@export var oneShot:bool = true




## Shows some debug information of the [TriggerBox] [br][br]such as:[br][br]
##[member TriggerBox.option] [br]
##[member TriggerBox.oneShot]
## [br][br]
## [b][color=orange]Note: This only works if the build is [method OS.is_debug_build][/color][/b]
@export var debug:bool = false




@export_group("Call")
## Calls a method on the colliding body
@export var method:String = "queue_free"
## Arguments to pass to the method
@export var args:Array

@export_group("Sound")
@export var soundResource:MonkaSoundResource
## the [param global_position] of this node will be used instead of [member TriggerBox.soundOrigin] ONLY if this is NOT [color=salmon][b]Null[/b][/color]
@export var soundOrigin:Node3D
## if [member TriggerBox.soundOrigin] is null, then this [Vector3] will be used
@export var soundPosition:Vector3

@export_group("Animation")
@export var AnimationTarget:AnimationPlayer
@export var AnimationName:String

var optionLabel:Label3D
var oneShotLabel:Label3D

var triggered:bool = false

enum triggerBoxTypes{
	FREE, ## Calls [method Node.queue_free] on the colliding body
	CALL, ## Calls a specified method on the colliding body, along with its arguments
	TRIGGER_COMPONENT, ## Calls [method TriggerComponent.trigger]
	PLAY_SOUND, ## Calls [method Monka.playSound] [br][color=orange]Note: You need to pass a [MonkaSoundResource] to the method[/color]
	PLAY_SPATIAL_SOUND, ## Calls [method Monka.playSpatialSound] [br][color=orange]Note: You need to pass a [MonkaSoundResource] to the method[/color]
	PLAY_ANIMATION
}


func _ready() -> void:
	if Engine.is_editor_hint(): editorStart(); return;
	createDebugVisualization()
	findTriggerComponent()
	self.body_entered.connect(func(b:Node3D): onBodyEntered(b))
	pass

func findTriggerComponent()->TriggerComponent:
	var component:TriggerComponent
	for _c in self.get_children():
		if _c is TriggerComponent: triggerComponent = _c
	return component;

func createDebugVisualization()->void:
	if debug and OS.is_debug_build():
		
		
		optionLabel = Label3D.new()
		optionLabel.text = triggerBoxTypes.find_key(option)
		optionLabel.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		match option:
			triggerBoxTypes.FREE:
				optionLabel.modulate = Color(1,0,0)
			triggerBoxTypes.CALL:
				optionLabel.modulate = Color(0,1,1)
			triggerBoxTypes.PLAY_SOUND:
				optionLabel.modulate = Color(0,1,0)
		self.add_child(optionLabel)
		
		oneShotLabel = Label3D.new()
		oneShotLabel.text = "OneShot: %s" %oneShot
		self.add_child(oneShotLabel)
		oneShotLabel.position = Vector3(0,.25,0)
		
		
		
		pass
	pass

func editorStart()->void:
	
	
	self.child_entered_tree.connect(func(node:Node):
		if node is CollisionShape3D:
			hasCollision = true
			if option == triggerBoxTypes.TRIGGER_COMPONENT:
				#updateWarnings()
				pass
		print("nodo: ", node)
		pass)
	
	
	self.child_exiting_tree.connect(func(node:Node):
		if node is CollisionShape3D: hasCollision = false
		pass)
	
	pass

#func updateWarnings()->void:
	#pass

func restart()->void:
	triggered = false
	pass

func onBodyEntered(b:Node3D)->void:
	match option:
		triggerBoxTypes.FREE:
			b.queue_free()
		triggerBoxTypes.CALL:
			if method.is_empty(): push_error("Method is empty: ", method); return;
			if b.has_method(method):
				b.call_deferred(method, args)
			else:
				push_error(b, "Does not has method: ", method)
		triggerBoxTypes.PLAY_SOUND:
			Monka.playSound(soundResource)
		triggerBoxTypes.PLAY_SPATIAL_SOUND:
			if soundResource:
				if soundOrigin: soundPosition = soundOrigin.global_position
				Monka.playSpatialSound(soundResource, soundPosition)
		triggerBoxTypes.TRIGGER_COMPONENT:
			if triggerComponent: triggerComponent.trigger()
			else: push_error("TriggerBox does not has TriggerComponent as a child!: \nTriggerBox: %s \nTriggerComponent: %s" %[self, triggerComponent])
		triggerBoxTypes.PLAY_ANIMATION:
			if AnimationTarget and not AnimationName.is_empty():
				AnimationTarget.play(AnimationName)
	pass
