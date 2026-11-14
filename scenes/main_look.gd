
extends Node3D

@export var mouse_sensitivity: float = 0.003
@export var min_pitch: float = deg_to_rad(-89.0)
@export var max_pitch: float = deg_to_rad(89.0)

@onready var camera: Camera3D = $Node3D/Camera3D

func _ready() -> void:
	camera.current = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			# YAW: Rotate the parent Node3D left and right
			rotation.y -= event.relative.x * mouse_sensitivity
			# PITCH: Rotate the camera up and down
			camera.rotation.x -= event.relative.y * mouse_sensitivity
			camera.rotation.x = clamp(
				camera.rotation.x,
				min_pitch,
				max_pitch
			)
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
