extends Window
func _ready():
	self.close_requested.connect(when_window_closed)
# This stuff is for selectning an audio file.
var audio_file_dialog = load("res://assets/scenes/audiocustomizewindow/filedialogs/audio_dialog/audio_dialog.tscn")
var audio_file_path
func when_audiosel_button_pressed():
	add_child(audio_file_dialog.instantiate())
	$"AudioDialog".add_filter("*.ogg, *.wav, *.mp3","Audio Files")
	$"AudioDialog".file_selected.connect(when_audio_file_selected)
func when_audio_file_selected(path_for_audio):
	audio_file_path = path_for_audio
	$Node/Audio/TextEdit.text = audio_file_path


# This stuff is for selecting an image file.
var image_file_dialog = load("res://assets/scenes/audiocustomizewindow/filedialogs/image_dialog/image_dialog.tscn")
var image_file_path
var image_which_was_selected = Image.new()
func when_imgsel_button_pressed():
	add_child(image_file_dialog.instantiate())
	$"ImageDialog".add_filter("*.tga, *.hdr, *.webp, *.jpeg, *.jpg, *.png","Images")
	$"ImageDialog".file_selected.connect(when_image_file_selected)
func when_image_file_selected(path_for_image):
	image_file_path = path_for_image
	image_which_was_selected.load(image_file_path)
	$Node/Image/TextureButton.texture_normal = ImageTexture.create_from_image(image_which_was_selected) # Now you have a preview of the new image



# This happens when you click save.
func when_settings_saved():
	print("Saving sound...")
	print("Save complete.")

# This happens when you cancel or close the window.
func when_window_closed(): _on_cancel_pressed() # I could link the signal directly to when_cancel_pressed, but who knows, maybe I might want to do something extra.
func _on_cancel_pressed():
	print("Cancelling sound...")
	print('Cancelling complete.')
	self.queue_free()
