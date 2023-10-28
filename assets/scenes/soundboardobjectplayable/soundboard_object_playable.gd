extends Control

func _ready():
	# Tell the grid who you are
	var MainGridObject = self.get_parent().get_parent().get_parent().get_parent().get_parent()
	MainGridObject.once_sound_effect_object_created(self.get_path())

func _when_soundeffect_data_given():
	print("pog")

func _on_options_button_pressed():
	pass


func _when_sound_effect_played():
	pass
