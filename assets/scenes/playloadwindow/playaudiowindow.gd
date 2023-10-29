extends Node
var audio_modify_dialog = load("res://assets/scenes/audiocustomizewindow/audiocustomizewindow.tscn")
var credits_window = load("res://assets/scenes/misc/credits/credits.tscn")
signal send_to_modify_sound_effect(unique_id)
signal kill_all_grid_sfx_objs
func _ready():
	$"/root/GlobalModule".sound_has_been_saved.connect(when_sound_finished_saving)
	propagate_grid_objects()


func when_sound_finished_saving():
	kill_grid_objects()
	propagate_grid_objects()

func when_sound_deleted(): # Don't put any file-related operations here! Put it in the Global Module instead.
	kill_grid_objects()
	propagate_grid_objects()

# Once you decide to modify an object...
var new_sound = true
var chosen_id
func _on_file_mod_button_pressed():
	if new_sound == true:
		when_sound_modified(str(randi()))
		print("Creating new sound...")
		
func on_externally_told_to_mod_sound(Unique_Sound_ID): when_sound_modified(Unique_Sound_ID)

func when_sound_modified(Unique_Sound_ID: String):
	add_child(audio_modify_dialog.instantiate())
	emit_signal("send_to_modify_sound_effect", Unique_Sound_ID)

func _on_credits_button_pressed(): add_child(credits_window.instantiate())

func kill_grid_objects():
	emit_signal("kill_all_grid_sfx_objs")



# Make the grid thing.
signal send_info_to_sfx_grid_obj(UniqueSoundID: String)
var SoundUniqueID
func propagate_grid_objects():
	print("Loading soundboard...")
	var GridContainerForSFX = $UI_Parent/SoundBoardGrid/ScrollContainer/HFlowContainer
	var SoundObjectGridPieceFile = preload('res://assets/scenes/soundboardobjectplayable/soundboard_object_playable.tscn')
	for String in DirAccess.get_directories_at("user://profiles/" + $/root/GlobalModule.CurrentProfile + "/soundeffects/"): # See the function once_sound_effect_object_created to understad everything
		GridContainerForSFX.add_child(SoundObjectGridPieceFile.instantiate()) 
		SoundUniqueID = String # Just to make it a little less confusing.
		send_info_to_sfx_grid_obj.emit(SoundUniqueID)



func _on_save_folder_button_pressed():OS.shell_open(ProjectSettings.globalize_path('user://'))


func _on_mute_all_sounds_button_pressed():$"/root/GlobalModule".PlayAudioFile("res://assets/themes/default/silence.mp3")
