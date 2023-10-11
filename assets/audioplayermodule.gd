extends AudioStreamPlayer
func PlayAudioFile(pathtofile):
	# Call this function, with whatever path you desire. Then it will do the thing.
	# By the way, the path can come from anywhere, like the root of the drive. Yay!
	$AudioStreamPlayer.stream = load(pathtofile)
	$AudioStreamPlayer.play()
