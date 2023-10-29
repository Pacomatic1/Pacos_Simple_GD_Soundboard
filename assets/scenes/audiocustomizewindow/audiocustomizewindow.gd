extends Window
func _ready():
	self.close_requested.connect(when_window_closed)
	get_parent().send_to_modify_sound_effect.connect(when_given_information)
	$"Node/OK and Cancel/save".grab_focus()

# When the parent tells it impportant imformation
var unique_sound_id
func when_given_information(unique_id):
	unique_sound_id = unique_id
	# First, retrieve data.
	# See if the sound already exists. 
	# We *could* find the folder, but due to the placeholders and everything, it means that if the sound exists at all, the title.txt must as well. So I did this because it's easier. -Paco
	FileAccess.open("user://profiles/" + $/root/GlobalModule.CurrentProfile + "/soundeffects/" + unique_sound_id + '/title.txt', FileAccess.READ)
	if FileAccess.get_open_error() == 0:
		# Title
		$Node/TextName/TextEdit.text = FileAccess.get_file_as_string("user://profiles/" + $/root/GlobalModule.CurrentProfile + "/soundeffects/" + unique_sound_id + '/title.txt')
		$Node/Audio/TextEdit.text = "Already chosen."
		# Image
		var alreadyselected_imagepreview = Image.new()
		image_file_path = "user://profiles/" + $/root/GlobalModule.CurrentProfile + "/soundeffects/" + unique_sound_id + '/coverimage.png'
		alreadyselected_imagepreview.load("user://profiles/" + $/root/GlobalModule.CurrentProfile + "/soundeffects/" + unique_sound_id + '/coverimage.png')
		$Node/Image/TextureButton.texture_normal = ImageTexture.create_from_image(alreadyselected_imagepreview)
		# Audio
		audio_file_path = "The audio is not going to be modified."




# This stuff is for selecting an audio file.
var audio_file_dialog = load("res://assets/scenes/audiocustomizewindow/filedialogs/audio_dialog/audio_dialog.tscn")
var audio_file_path
var audio_file_selected_has_been_connected
func when_audiosel_button_pressed():
	add_child(audio_file_dialog.instantiate())
	$"AudioDialog".add_filter("*.mp3","Audio Files")
	if not audio_file_selected_has_been_connected:
		$"AudioDialog".file_selected.connect(when_audio_file_selected)
		audio_file_selected_has_been_connected = true
func when_audio_file_selected(path_for_audio):
	audio_file_path = path_for_audio
	$Node/Audio/TextEdit.text = audio_file_path
	
# This stuff is for selecting an image file.
var image_file_dialog = load("res://assets/scenes/audiocustomizewindow/filedialogs/image_dialog/image_dialog.tscn")
var image_file_path
var image_which_was_selected = Image.new()
var image_file_selected_has_been_connected
func when_imgsel_button_pressed():
	add_child(image_file_dialog.instantiate())
	$"ImageDialog".add_filter("*.webp, *.jpeg, *.jpg, *.png","Images")
	if not image_file_selected_has_been_connected:
		$"ImageDialog".file_selected.connect(when_image_file_selected)
	image_file_selected_has_been_connected = true
func when_image_file_selected(path_for_image):
	image_file_path = path_for_image
	image_which_was_selected.load(image_file_path)
	$Node/Image/TextureButton.texture_normal = ImageTexture.create_from_image(image_which_was_selected) # Now you have a preview of the new image


# This happens when you click save.
func when_settings_saved():
	# So that it doesn't give 'nil' which causes stinky errors....
	if image_file_path == null: image_file_path = ''
	if audio_file_path == null: audio_file_path = ''
	# Once the thing is done, the window should close.
	$/root/GlobalModule.sound_has_been_saved.connect(once_settings_have_finished_saving)
	# Send this over to the global module. 
	$/root/GlobalModule.mod_or_save_sound_effects($Node/TextName/TextEdit.text, unique_sound_id, image_file_path, audio_file_path)
func once_settings_have_finished_saving():
	print("Audio Dialog window has closed.")
	self.queue_free()

# This happens when you cancel or close the window.
func when_window_closed(): _on_cancel_pressed() # I could link the signal directly to when_cancel_pressed, but who knows, maybe I might want to do something extra. Plus, the extra slowdown is so negligible that nobody loses anyways.
func _on_cancel_pressed():
	print("Cancelling sound...")
	print('Cancelling complete.')
	self.queue_free()
