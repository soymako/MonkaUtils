extends Resource
class_name MonkaSoundResource

@export var stream:AudioStream
## [color=salmon][b]False[/b][/color]: [param minPitch] is used instead
@export var useRandomPitch:bool = false
@export_range(0,2) var minPitch:float = 1
@export_range(0,2) var maxPitch:float = 1.2
@export var autostart:bool = false
@export var volume:float = 0

## audio play position offset
@export var offset:float = 0
@export_subgroup("fades")
@export var fadeIn:bool = false
@export var fadeInTime:float = 1
@export var fadeOut:bool = false
@export var fadeOutTime:bool = 1

@export_flags_3d_physics var maskLayer:int = 512


func getRandomPitch()->float:
	return randf_range(minPitch, maxPitch)
