extends Node


class monka_errors:
	extends Node
	func notImplementedYet(n)->void:
		push_warning("Method not implemented yet: ", n)
		pass
	
	pass

var errors:monka_errors = monka_errors.new()

func _ready() -> void:
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
