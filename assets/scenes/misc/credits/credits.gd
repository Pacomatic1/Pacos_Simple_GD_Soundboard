extends Window
func _on_close_requested(): _on_exitbutton_pressed()
func _on_exitbutton_pressed(): self.queue_free()
