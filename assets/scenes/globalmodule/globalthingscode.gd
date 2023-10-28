extends Node
signal sound_has_been_saved
var CurrentProfile = "0"
func mod_or_save_sound_effects(SoundTitle: String, UniqueSoundID: String, ImagePath: String, AudioPath: String):
	print("Saving sound...")
	# Add the directories in case it's their first time.
	# It's done one by one because it doesn't work in bulk. I hate it too.
	DirAccess.make_dir_absolute("user://profiles")
	DirAccess.make_dir_absolute("user://profiles/" + CurrentProfile)
	DirAccess.make_dir_absolute("user://profiles/" + CurrentProfile + "/soundeffects/" )
	DirAccess.make_dir_absolute("user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID)
	print("Sound Name: " + SoundTitle)
	print("Sound ID: " + UniqueSoundID)
	print("Image Path: " + ImagePath)
	print("Audio Path: " + AudioPath)
	var ConfigFileForSound = ConfigFile.new() # This part will create a configuration file for some other data. The configuration file will be saved wayy at the end. Although it might seem quite pointless to use it for things that aren't a config, it's also super easy, and since this is being done during sound creation optimization is negligible. 
	# This part will start with the title. I used a .txt instead of a config because I don't want any conflicts between config and title string. 
	var titlefile = FileAccess.open("user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID + "/title.txt", FileAccess.WRITE)
	titlefile.store_string(SoundTitle)
	titlefile.close()
	# Now for the image.
	var ImageToStore
	if ImagePath == '': # If you didn't choose anything, replace it with this. Since you can't load a resource as a standard image in export, I have to use this as a workaround.
		ImagePath = "res://assets/themes/default/unchosenaudioimage.png"
		ImageToStore = load(ImagePath).get_image()
	else: ImageToStore = Image.load_from_file(ImagePath) 
	ImageToStore.save_png("user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID + "/coverimage.png")
	# Now for the audio.
	if AudioPath == '': AudioPath = "res://assets/themes/default/unchosenaudio.ogg"
	if AudioPath != "The audio is not going to be modified.":
		var AudioToStore = FileAccess.open("user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID + "/soundeffect." + AudioPath.get_extension(), FileAccess.WRITE)
		ConfigFileForSound.set_value("SoundFXAudioFile", "AudioFileExtension", AudioPath.get_extension())
		var AudioToStoreBuffer
		AudioToStoreBuffer = FileAccess.get_file_as_bytes(AudioPath)
		AudioToStore.store_buffer(AudioToStoreBuffer)
		AudioToStore.close()
	# And now we can finally save the configuration file.
	ConfigFileForSound.save("user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID + "/miscellaneous.cfg")
	print("Save complete.")
	emit_signal("sound_has_been_saved")
	print("You can find the sound at " + "user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID + '/')
func PlayAudioFile(pathtofile: String):
	# Call this function, with whatever path you desire. Then it will do the thing.
	# By the way, the path can come from anywhere, like the root of the drive. Yay!
	$AudioStreamPlayer.stream = load(pathtofile) # Sadly, the one spot it won't come from is the user:// directory. WHY?????????????
	$AudioStreamPlayer.play()
