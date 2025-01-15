extends Node

var userPath:String = OS.get_user_data_dir()


const DirectoryName:String = "MonkaUtils"
const monkaConsoleText:String = "📦Monka! - "
const graphicConfigResourceName:String = "graphic_config.tres"


func getFullDirectoryPath()->String:
	return userPath + "/" + DirectoryName

class monka_errors:
	extends Node
	func notImplementedYet(n)->void:
		push_warning("Method not implemented yet: ", n)
		pass
	
	pass

var errors:monka_errors = monka_errors.new()

var graphicConfig:GraphicConfigResource

func createMonkaUtilsDirectory()->void:
	#print()
	if not DirAccess.dir_exists_absolute(getFullDirectoryPath()):
		DirAccess.make_dir_absolute(getFullDirectoryPath())

func getGraphicConfig()->GraphicConfigResource:
	var confResource:GraphicConfigResource = ResourceLoader.load(getFullDirectoryPath() + "/" + graphicConfigResourceName)
	if confResource == null:
		confResource = GraphicConfigResource.new()
		print_rich(monkaConsoleText + "[color=salmon]GraphicConfigResource was not found in[/color] %s\n[color=salmon]creating a new one...[/color]" %(getFullDirectoryPath() + "/" + graphicConfigResourceName))
		saveGraphicConfigResource(confResource)
	return confResource

func saveGraphicConfigResource(res:GraphicConfigResource)->void:
	if res:
		ResourceSaver.save(res, getFullDirectoryPath() + "/" + graphicConfigResourceName)
		print_rich(monkaConsoleText + "[color=green]Resource saved at[/color] %s" %(getFullDirectoryPath()))
	pass

func _ready() -> void:
	createMonkaUtilsDirectory()
	graphicConfig = getGraphicConfig()
	print("data dir: ", userPath + "/MonkaUtils")
	self.add_child(errors)
	pass



func playSound(sr:MonkaSoundResource)->void:
	if not sr: push_error("Sound Resource is null: ", sr); return;
	var s:AudioStreamPlayer3D = createSpatialSound(sr)
	s.stream = sr.stream
	s.volume_db = sr.volume
	s.area_mask = sr.maskLayer
	if sr.useRandomPitch:	s.pitch_scale = sr.getRandomPitch();
	else: s.pitch_scale = sr.minPitch
	
	s.ready.connect(func():
		if sr.autostart:
			s.play(sr.offset)
			if sr.fadeIn:
				s.volume_db = -300
				var _t:Tween = create_tween().parallel()
				_t.tween_property(s, "volume_db", sr.volume, sr.fadeInTime)
				pass
		pass)
	
	s.finished.connect(func():
		s.queue_free()
		pass)
	
	self.add_child(s)
	pass

func createSound(sr:MonkaSoundResource)->AudioStreamPlayer:
	if not sr: push_error("Sound Resource is null: ", sr); return;
	return AudioStreamPlayer.new()

## [parameter position] is global
func playSpatialSound(sr:MonkaSoundResource, position:Vector3)->void:
	if not sr: push_error("Sound Resource is null: ", sr); return;
	var s:AudioStreamPlayer3D = createSpatialSound(sr)
	s.stream = sr.stream
	s.volume_db = sr.volume
	s.area_mask = sr.maskLayer
	if sr.useRandomPitch:	s.pitch_scale = sr.getRandomPitch();
	else: s.pitch_scale = sr.minPitch
	
	s.ready.connect(func():
		s.global_position = position
		if sr.autostart:
			s.play(sr.offset)
			if sr.fadeIn:
				s.volume_db = -300
				var _t:Tween = create_tween().parallel()
				_t.tween_property(s, "volume_db", sr.volume, sr.fadeInTime)
				pass
		pass)
	
	s.finished.connect(func():
		s.queue_free()
		pass)
	self.add_child(s)
	
	pass

func createSpatialSound(sr:MonkaSoundResource)->AudioStreamPlayer3D:
	if not sr: push_error("Sound Resource is null: ", sr); return
	return AudioStreamPlayer3D.new()
