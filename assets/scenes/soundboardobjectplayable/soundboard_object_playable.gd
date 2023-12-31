extends Control

var MainObjectsParent
func _ready():
	MainObjectsParent = self.get_parent().get_parent().get_parent().get_parent().get_parent()
	MainObjectsParent.send_info_to_sfx_grid_obj.connect(_when_soundeffect_data_given)
	MainObjectsParent.kill_all_grid_sfx_objs.connect(_when_told_to_be_removed)
var AssignedUniqueID
func _when_soundeffect_data_given(SentUniqueSoundID):
	if AssignedUniqueID == null:
		AssignedUniqueID = SentUniqueSoundID
	# We have the sound ID!!! Now do the thing and actually load it.
	var SFX_FolderPath = "user://profiles/" + $"/root/GlobalModule".CurrentProfile + "/soundeffects/" + AssignedUniqueID + '/'
	$Control/SoundEffectName.text = FileAccess.get_file_as_string(SFX_FolderPath + "title.txt") # SFX Title
	var SFX_Cover = Image.new()
	SFX_Cover.load(SFX_FolderPath + "coverimage.png")
	$Control/SoundEffectCover.texture_normal = ImageTexture.create_from_image(SFX_Cover)

func _on_options_button_pressed():MainObjectsParent.on_externally_told_to_mod_sound(AssignedUniqueID)


func _when_sound_effect_played():
	print("Played sound: " + AssignedUniqueID)
	$"/root/GlobalModule".PlayAudioFile("user://profiles/" + $"/root/GlobalModule".CurrentProfile + "/soundeffects/" + AssignedUniqueID + '/soundeffect.mp3')

func _when_told_to_be_removed():queue_free()

func _on_garbage_button_pressed():$/root/GlobalModule.delete_sound_effect(AssignedUniqueID)
