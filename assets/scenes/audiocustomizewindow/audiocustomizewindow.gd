extends Window
var audio_file_dialog = preload("res://assets/scenes/audiocustomizewindow/filedialogs/audio_dialog/audio_dialog.tscn")
var image_file_dialog = preload("res://assets/scenes/audiocustomizewindow/filedialogs/image_dialog/image_dialog.tscn")
var audio_file_path
var image_file_path



# This stuff is for selectning an audio file.
func when_audiosel_button_pressed():
	add_child(audio_file_dialog.instantiate())
	$"AudioDialog".file_selected.connect(when_audio_file_selected)
func when_audio_file_selected(path_for_audio):
	audio_file_path = path_for_audio
	$Node/Audio/TextEdit.text = audio_file_path


# This stuff is for selecting an image file.
# This stuff is for selectning an audio file.
func when_imgsel_button_pressed():
	add_child(image_file_dialog.instantiate())
	$"ImageDialog".file_selected.connect(when_image_file_selected)
func when_image_file_selected(path_for_image):
	image_file_path = path_for_image
	$Node/Image/TextureButton.texture_normal = image_file_path.file
