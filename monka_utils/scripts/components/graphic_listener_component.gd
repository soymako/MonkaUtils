extends Component
class_name GraphicListenerComponent

var parent:WorldEnvironment

func _ready() -> void:
	parent = get_parent()
	if parent is WorldEnvironment:
		if Monka.graphicConfig:
			Monka.graphicConfig.ConfigChanged.connect(applyConfig)
			
			applyConfig(Monka.graphicConfig)
	pass

func applyConfig(c:GraphicConfigResource)->void:
	var e:Environment = parent.environment
	e.ssr_enabled = c.SSR
	e.ssr_max_steps = c.SSRMaxSteps
	e.ssr_fade_in = c.SSRFadeIn
	e.ssr_fade_out = c.SSRFadeOut
	e.ssr_depth_tolerance = c.SSRDepth
	
	e.ssao_enabled = c.SSAOEnabled
	e.ssao_radius = c.SSAORadius
	e.ssao_intensity = c.SSAOIntensity
	e.ssao_detail = c.SSAODetail
	
	e.ssil_enabled = c.SSILEnabled
	e.ssil_intensity = c.SSILIntensity
	
	e.sdfgi_enabled = c.SDFGIEnabled
	e.sdfgi_energy = c.SDFGIEnergy
	e.sdfgi_cascades = c.SDFGICascades
	
	e.glow_enabled = c.GlowEnabled
	e.glow_normalized = c.GlowNormalized
	e.glow_intensity = c.GlowIntensity
	e.glow_strength = c.GlowStrength
	e.glow_bloom = c.GlowBloom
	
	e.fog_enabled = c.FogEnabled
	e.fog_density = c.FogDensity
	
	e.volumetric_fog_enabled = c.VolumetricFogEnabled
	e.volumetric_fog_density = c.VolumetricFogDensity
pass
