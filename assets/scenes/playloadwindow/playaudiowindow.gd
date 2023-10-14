extends Node

var audio_modify_dialog = load("res://assets/scenes/audiocustomizewindow/audiocustomizewindow.tscn")
signal send_to_modify_sound_effect(unique_id)
func when_new_sound_button_pressed():
	add_child(audio_modify_dialog.instantiate())
	emit_signal("send_to_modify_sound_effect", "add unique id support") 
	$"/root/GlobalModule".PlayAudioFile("C:/Users/ammar/AppData/Roaming/Godot/app_userdata/Hand-Made Soundboard/profiles/add profiles sometime/soundeffects/add unique id support/soundeffect.mp3")
