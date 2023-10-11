extends Node

var audio_modify_dialog = load("res://assets/scenes/audiocustomizewindow/audiocustomizewindow.tscn")
signal send_to_modify_sound_effect(unique_id)
func when_new_sound_button_pressed():
	add_child(audio_modify_dialog.instantiate())
	emit_signal("send_to_modify_sound_effect", "The Unique ID doesnt exist so this is a reminder") 
