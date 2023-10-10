extends AudioStreamPlayer
func PlayAudioFile(pathtofile): #Call this function, with whatever path you desire. Then it will do the thing.
	self.stream = load(pathtofile)
	self.play()
