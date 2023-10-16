extends Node
var audio_modify_dialog = load("res://assets/scenes/audiocustomizewindow/audiocustomizewindow.tscn")
signal send_to_modify_sound_effect(unique_id)



# Once you decide to modify an object...
func _on_file_mod_button_pressed(): when_sound_modified()
func when_sound_modified():
	add_child(audio_modify_dialog.instantiate())
	emit_signal("send_to_modify_sound_effect", "add unique id support")
