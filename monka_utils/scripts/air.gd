
extends Area3D
## If True, this node will only work when visible
@export var disableOnVisibility:bool = true
## if True, the force will be applied from the [param global_position] of the area
## [br]else, it'll use the [param basis.z] for the direction
@export var singlePoint:bool = false
## Instead of [b]pushing[/b] every colliding rigid body will be pulled
@export var pull:bool = false
@export_group("Timing 🕑")
## This node will act temporarily and have a max living time, after that. It'll be deleted using [method queue_free]
@export var timed:bool = true
## Max living time this node is allowed to exist, living time starts after [param Air.fadeInTime]
@export var livingTime:float = .5
## Controls the fadeIn curve the [param Air.windIntensity] has
@export_exp_easing("inout") var fadeInTime:float = 1
## Controls the fadeOut curve the [param Air.windIntensity] has when [param Air.livingTime] is over
@export_exp_easing("inout") var fadeOutTime:float = 1

@export_group("Detection 🔍")
## Shoots a raycast for every body it collides with. [br]
## [br][color=salmon]this may affect performance, even though it uses a [PhysicsRayQueryParameters3D] it can cause a lot of stress to your scene
@export var canBeObstructed:bool = true
## Controls the distance of the raycast when checking if the colliding body should be affected by wind.
@export var windDistanceCheck:float = 2.5

## Controls the intensity of the air
@export var windIntensity:float = 1:
	set(v):
		realWindIntensity = v
		windIntensity = v

var affected:Array[RigidBody3D]

var spaceState:PhysicsDirectSpaceState3D
var query:PhysicsRayQueryParameters3D
var result:Dictionary
var realWindIntensity:float = 0

var timer:Timer = Timer.new()


#var testRaycast:RayCast3D = RayCast3D.new()
#@onready var visualize: MeshInstance3D = $"../visualize"

func _ready() -> void:
	
	self.visibility_changed.connect(func():
		if visible: start()
		pass)
	
	#timer.autostart = true
	timer.one_shot = true
	timer.wait_time = livingTime
	self.add_child(timer)
	spaceState = get_world_3d().direct_space_state
	#self.add_child(testRaycast)
	#testRaycast.debug_shape_custom_color = Color(1,0,0)
	#testRaycast.debug_shape_thickness = 10
	self.body_exited.connect(func(b:Node3D):
		if b is RigidBody3D:
			if affected.has(b): affected.erase(b)
		pass)
	start()
	pass

func start()->void:
	if visible:
		if timed:
			var _t:Tween = create_tween()
			_t.tween_property(self, "realWindIntensity", windIntensity, fadeInTime)
			_t.finished.connect(func():
				startTimer()
				pass)
			pass
		else:
			realWindIntensity = windIntensity
	else:
		realWindIntensity = windIntensity
	pass

func startTimer()->void:
	timer.start()
	timer.timeout.connect(func():
		var _t:Tween = create_tween()
		_t.tween_property(self, "realWindIntensity", 0, fadeOutTime)
		_t.finished.connect(func(): self.queue_free())
		pass)
	pass

func _physics_process(delta: float) -> void:
	onOverlappingBodies()
	#print("windIntensity: ", realWindIntensity)
	pass

func onOverlappingBodies()->void:
	if disableOnVisibility and not self.visible: return
	var bodies:Array[Node3D] = get_overlapping_bodies()
	for _b in bodies:
		if _b is RigidBody3D:
			var velocityToApply:Vector3 = (self.basis.z * realWindIntensity) / 4
			
			var r:RigidBody3D = _b as RigidBody3D
			
			if singlePoint:
				velocityToApply = (r.global_position - self.global_position).normalized() * realWindIntensity / 4
			
			if pull:
				velocityToApply = (self.global_position - r.global_position).normalized() * realWindIntensity / 4
			
			if canBeObstructed:
				if spaceState:
					query = PhysicsRayQueryParameters3D.create(r.global_position, r.global_position - self.basis.z * windDistanceCheck)
					result = spaceState.intersect_ray(query)
					#print("resultado: ", result)
					if result.is_empty():
						if not affected.has(r):
							affected.append(r)
						pass
					for _n in affected:
						_n.linear_velocity += velocityToApply
					pass
			else:
				r.linear_velocity += velocityToApply
			#r.apply_impulse(self.basis.z * windForce, self.global_position)
	pass
