extends Node
var audio_modify_dialog = load("res://assets/scenes/audiocustomizewindow/audiocustomizewindow.tscn")
var credits_window = load("res://assets/scenes/misc/credits/credits.tscn")
signal send_to_modify_sound_effect(unique_id)

func _ready():
	get_tree().get_root().size_changed.connect(on_window_resize)
	on_window_resize()
	propagate_grid_objects()

func on_window_resize(): # When the window resizes...
	print("Window has been told to resize.")
	# Avoid object overlap...
	var TopBarContainerSizeHeight = $UI_Parent/TopBar/HBoxContainer.size.y * $UI_Parent/TopBar/HBoxContainer.scale.y
	$UI_Parent/SoundBoardGrid/ScrollContainer.position = Vector2(3,2 + TopBarContainerSizeHeight)

# Once you decide to modify an object...
var new_sound = true
var chosen_id
func _on_file_mod_button_pressed():
	if new_sound == true:
		when_sound_modified(str(randi()))
		print("Creating new sound...")

func when_sound_modified(Unique_Sound_ID: String):
	add_child(audio_modify_dialog.instantiate())
	emit_signal("send_to_modify_sound_effect", Unique_Sound_ID)

func _on_credits_button_pressed(): add_child(credits_window.instantiate())


# Make the grid thing.
var SoundUniqueID
func propagate_grid_objects():
	print("Loading soundboard...")
	var GridContainerForSFX = $UI_Parent/SoundBoardGrid/ScrollContainer/GridContainer
	var SoundObjectGridPieceFile = preload('res://assets/scenes/soundboardobjectplayable/soundboard_object_playable.tscn')
	print("Here are the all UIDs for the SFX: " + str(DirAccess.get_directories_at("user://profiles/" + $/root/GlobalModule.CurrentProfile + "/soundeffects/")))
	for String in DirAccess.get_directories_at("user://profiles/" + $/root/GlobalModule.CurrentProfile + "/soundeffects/"): # See the function once_sound_effect_object_created to see the REAL for loop. 
		SoundUniqueID = String # Just to make it a little less confusing.
		var SFX_FolderPath = "user://profiles/" + $/root/GlobalModule.CurrentProfile + "/soundeffects/" + SoundUniqueID
		GridContainerForSFX.add_child(SoundObjectGridPieceFile.instantiate())
# I would also like to point something out: it seems quite odd that I use a for loop to create the sound effects, and then get their NodePaths in a completely separate function. Well, due to how Godot times it all, it means that this gets to receive the NodePath of the new kid BEFORE making another kid. 
# Confused? Not big surprise. To sum it up, you can treat the function as part of the for loop.
func once_sound_effect_object_created(SoundUniqueObjectID: NodePath):
	pass
