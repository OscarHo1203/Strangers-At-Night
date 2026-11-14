extends Node3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("camera_mov")

func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_look.tscn")
