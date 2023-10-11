extends Node
signal sound_has_been_saved
var CurrentProfile = "I need to add profile support twt"
func mod_or_save_sound_effects(SoundTitle: String, UniqueSoundID: String, ImagePath: String, AudioPath: String):
	print("Saving sound...")
	print("Sound Name: " + SoundTitle)
	print("Sound ID: " + UniqueSoundID)
	print("Image Path: " + ImagePath)
	print("Audio Path: " + AudioPath)
	# This part will start with the title.
	var soundconfig = ConfigFile.new()
	soundconfig.set_value("SongText", "songname", SoundTitle)
	#	soundconfig.save("user://profiles/" + self.CurrentProfile + "/soundeffects/" + UniqueSoundID + "/soundeffectconfig.cfg")
	soundconfig.save("user://pril/soundeffectconfig.cfg")
	emit_signal("sound_has_been_saved")
	print("Save complete.")
func PlayAudioFile(pathtofile):
	# Call this function, with whatever path you desire. Then it will do the thing.
	# By the way, the path can come from anywhere, like the root of the drive. Yay!
	$AudioStreamPlayer.stream = load(pathtofile)
	$AudioStreamPlayer.play()
