extends Resource
class_name GraphicConfigResource

signal ConfigChanged(v:GraphicConfigResource)

@export var SSR:bool = false:
	set(v):
		SSR = v
		ConfigChanged.emit(self)
@export var SSRMaxSteps:int = 64:
	set(v):
		SSRMaxSteps = v
		ConfigChanged.emit(self)
@export_exp_easing("inout") var SSRFadeIn:float = .15:
	set(v):
		SSRFadeIn = v
		ConfigChanged.emit(self)
@export_exp_easing("inout") var SSRFadeOut:float = 2:
	set(v):
		SSRFadeOut = v
		ConfigChanged.emit(self)
@export_range(0, 128) var SSRDepth:float = .2:
	set(v):
		SSRDepth = v
		ConfigChanged.emit(self)

@export var SSAOEnabled:bool = false:
	set(v): SSAOEnabled = v; ConfigChanged.emit(self);
@export_range(0,16) var SSAORadius:float = 1:
	set(v): SSAORadius = v; ConfigChanged.emit(self)
@export_range(0,16) var SSAOIntensity:float = 1:
	set(v): SSAOIntensity = v; ConfigChanged.emit(self)

@export_exp_easing("inout") var SSAOPower:float = 1.5:
	set(v): SSAOPower = v; ConfigChanged.emit(self)

@export_range(0, 5) var SSAODetail:float = .5:
	set(v): SSAODetail = v; ConfigChanged.emit(self)

# horizon, lightaffect, AOChannel

#SSIL
#	radius, sharpness, normal rejection

@export var SSILEnabled:bool = false:
	set(v): SSILEnabled = v; ConfigChanged.emit(self)

@export_range(0,16) var SSILIntensity:float = 1:
	set(v): SSILIntensity = v; ConfigChanged.emit(self)


#SDFGI
#	radius, sharpness, normal rejection
@export var SDFGIEnabled:bool = false:
	set(v): SDFGIEnabled = v; ConfigChanged.emit(self)
@export_range(0,16) var SDFGIEnergy:float = 1:
	set(v): SDFGIEnergy = v; ConfigChanged.emit(self)

@export var SDFGICascades:int = 4:
	set(V): SDFGICascades = V; ConfigChanged.emit(self)



#glow
#	HDR all, mapStrengh, map
@export var GlowEnabled:bool = false:
	set(v): GlowEnabled = v;ConfigChanged.emit(self)

@export var GlowNormalized:bool = false:
	set(v): GlowNormalized = v; ConfigChanged.emit(self)

@export_range(0,8) var GlowIntensity:float = .8:
	set(v): GlowIntensity = v; ConfigChanged.emit(self)

@export_range(0, 2) var GlowStrength:float = 1:
	set(v): GlowStrength = v; ConfigChanged.emit(self)

@export_range(0, 1) var GlowBloom:float = 0:
	set(v): GlowBloom = v; ConfigChanged.emit(self)

@export_range(0, 4) var GlowBlendMode:int = 2:
	set(v): GlowBlendMode = v; ConfigChanged.emit(self)


#fog
#	density
@export var FogEnabled:bool = false:
	set(v): FogEnabled = v; ConfigChanged.emit(self)

@export_range(0, 1) var FogDensity:float = .01:
	set(v): FogDensity = v; ConfigChanged.emit(self)

@export var VolumetricFogEnabled:bool = false:
	set(v): VolumetricFogEnabled = v; ConfigChanged.emit(self)

@export_range(0, 1) var VolumetricFogDensity:float = .05:
	set(v): VolumetricFogDensity = v; ConfigChanged.emit(self)
