extends Node
var audio_modify_dialog = load("res://assets/scenes/audiocustomizewindow/audiocustomizewindow.tscn")
var credits_window = load("res://assets/scenes/misc/credits/credits.tscn")
signal send_to_modify_sound_effect(unique_id)

func _ready():
	get_tree().get_root().size_changed.connect(on_window_resize)
	on_window_resize()

func on_window_resize(): # When the window resizes...
	print("Window is being resized.")
	# Avoid object overlap...
	var TopBarContainerSizeHeight = $UI_Parent/TopBar/HBoxContainer.size.y * $UI_Parent/TopBar/HBoxContainer.scale.y
	var TopBarContainerSizeHeightMargin = TopBarContainerSizeHeight + (1 * $UI_Parent/TopBar/HBoxContainer.scale.y)
	$UI_Parent/SoundBoardGrid/ScrollContainer.position = Vector2(0,0)
	$UI_Parent/SoundBoardGrid/ScrollContainer.position.y += TopBarContainerSizeHeightMargin 

# Once you decide to modify an object...
var new_sound = true
var chosen_id
func _on_file_mod_button_pressed():
	if new_sound == true:
		#when_sound_modified(str(randi()))
		when_sound_modified(str(randi()))
		print("Creating new sound...")

func when_sound_modified(Unique_Sound_ID: String):
	add_child(audio_modify_dialog.instantiate())
	emit_signal("send_to_modify_sound_effect", Unique_Sound_ID)


func _on_credits_button_pressed():
	add_child(credits_window.instantiate())
