extends Node
signal sound_has_been_saved
var CurrentProfile = "add profiles sometime"
func mod_or_save_sound_effects(SoundTitle: String, UniqueSoundID: String, ImagePath: String, AudioPath: String):
	# Add the directories in case it's their first time.
	# It's done one by one because it doesn't work in bulk. I hate it too.
	print("Making needed directories...")
	DirAccess.make_dir_absolute("user://profiles")
	DirAccess.make_dir_absolute("user://profiles/" + CurrentProfile)
	DirAccess.make_dir_absolute("user://profiles/" + CurrentProfile + "/soundeffects/" )
	DirAccess.make_dir_absolute("user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID)
	
	
	print("Saving sound...")
	print("Sound Name: " + SoundTitle)
	print("Sound ID: " + UniqueSoundID)
	print("Image Path: " + ImagePath)
	print("Audio Path: " + AudioPath)
	# This part will start with the title.
	var titlefile = FileAccess.open("user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID + "/title.txt", FileAccess.WRITE)
	titlefile.store_string(SoundTitle)
	
	# Now for the image.
	var ImageToStore
	if ImagePath == null: # If you didn't choose anything, replace it with this, Since you can't load from a resource in export, I have to use this workaround.
		ImagePath = "res://assets/themes/default/unchosenaudioimage.png"
		ImageToStore = load(ImagePath).get_image() 
	else: ImageToStore = Image.load_from_file(ImagePath) 
	ImageToStore.save_png("user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID + "/coverimage.png") 
	print("Save complete.")
	emit_signal("sound_has_been_saved")
	print("You can find the sound at " + "user://profiles/" + CurrentProfile + "/soundeffects/" + UniqueSoundID)
func PlayAudioFile(pathtofile):
	# Call this function, with whatever path you desire. Then it will do the thing.
	# By the way, the path can come from anywhere, like the root of the drive. Yay!
	$AudioStreamPlayer.stream = load(pathtofile)
	$AudioStreamPlayer.play()
