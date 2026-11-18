extends Node3D

@onready var role: RichTextLabel = $Control/Role
@onready var dialogue: RichTextLabel = $Control/Dialogue
@onready var control: Control = $Control
@onready var customer: Node3D = $customer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	customer.visible = false
	control.visible = false
	start_event()


func change_role_dialogue(role_text: String, dialogue_text: String) -> void:
	role.text = role_text
	dialogue.text = dialogue_text


func show_dialogue(role_text: String, dialogue_text: String) -> void:
	control.visible = true
	change_role_dialogue(role_text, dialogue_text)


func hide_dialogue() -> void:
	await get_tree().create_timer(3.0).timeout
	control.visible = false


# STAGE 1: THE INTRODUCTION
func start_event() -> void:
	show_dialogue(
		"A",
        "It can't be serious. Why would anyone want to ever accept a stranger into their house?"
	)
	await hide_dialogue()
	await stage_2()


# STAGE 2: CUSTOMER ARRIVES
func stage_2() -> void:
	customer.visible = true
	animation_player.play("walk")
	await animation_player.animation_finished
	await stage_3()

# STAGE 3: GREETING
func stage_3() -> void:
	show_dialogue("A", "Hello ?")
	await hide_dialogue()
	
	show_dialogue("A", "The store's still open.")
	await hide_dialogue()
	
	show_dialogue("A", "Just be quick, and get in.")
	await hide_dialogue()
