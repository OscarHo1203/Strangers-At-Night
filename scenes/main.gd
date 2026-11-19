extends Node3D

@onready var role: RichTextLabel = $Control/Role
@onready var dialogue: RichTextLabel = $Control/Dialogue
@onready var control: Control = $Control
@onready var color_rect: ColorRect = $Control/ColorRect
@onready var customer: Node3D = $customer
@onready var collision_shape_3d1: CollisionShape3D = $customer/AnimatableBody3D/CollisionShape3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var customer_2: Node3D = $customer2
@onready var collision_shape_3d2: CollisionShape3D = $customer2/AnimatableBody3D/CollisionShape3D
@onready var eyeball_body: RigidBody3D = $eyeball
@onready var eyeball_coll: CollisionShape3D = $eyeball/CollisionShape3D
@onready var eyeball: MeshInstance3D = $eyeball/Sphere

func _ready() -> void:
	customer.visible = false
	collision_shape_3d1.set_deferred("disabled", true)
	customer_2.visible = false
	collision_shape_3d2.set_deferred("disabled", true)
	control.visible = false
	eyeball.visible = false
	eyeball_coll.set_deferred("disabled", true)
	eyeball_body.freeze = true

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
	color_rect.color = Color(0.353, 0.493, 0.507, 1.0)
	show_dialogue(
		"Cashier",
        "It can't be serious. Why would anyone want to ever accept a stranger into their house?"
	)
	await hide_dialogue()
	await stage_2()


# STAGE 2: CUSTOMER ARRIVES
func stage_2() -> void:
	customer.visible = true
	animation_player.play("walk")
	print("It walks")
	await animation_player.animation_finished
	await stage_3()

# STAGE 3: GREETING
func stage_3() -> void:
	color_rect.color = Color(0.353, 0.493, 0.507, 1.0)
	show_dialogue("Cashier", "Hello ?")
	await hide_dialogue()
	
	color_rect.color = Color(0.353, 0.493, 0.507, 1.0)
	show_dialogue("Cashier", "The store's still open.")
	await hide_dialogue()
	
	color_rect.color = Color(0.353, 0.493, 0.507, 1.0)
	show_dialogue("Cashier", "Just be quick, and get in.")
	await hide_dialogue()

	var camera := get_viewport().get_camera_3d()
	while true:
		var camera_forward: Vector3 = -camera.global_basis.z
		var dir_to_customer: Vector3 = camera.global_position.direction_to(customer_2.global_position)
		if camera_forward.dot(dir_to_customer) >= 0.7:
			break
		await get_tree().process_frame
	customer.queue_free()
	customer_2.visible = true
	collision_shape_3d2.set_deferred("disabled", false)

	await get_tree().create_timer(3.0).timeout
	color_rect.color = Color(0.712, 0.312, 0.247, 1.0)
	show_dialogue("Customer", "Just.. cigar…and a…bottle…")
	
	await hide_dialogue()
	
	color_rect.color = Color(0.353, 0.493, 0.507, 1.0)
	show_dialogue("Cashier", "That'll be $2.50")
	await hide_dialogue()
	
	await get_tree().create_timer(3.0).timeout
	eyeball.visible = true
	eyeball_coll.set_deferred("disabled", false)
	eyeball_body.freeze = false
	await get_tree().create_timer(3.0).timeout
	await stage_4()

func stage_4():
	animation_player.play("siz")
	color_rect.color = Color(0.353, 0.493, 0.507, 1.0)
	show_dialogue("Cashier", "Wha- What the fuck, dude ?!")
	await animation_player.animation_finished
	await hide_dialogue()
	get_tree().change_scene_to_file("res://scenes/last_Cut.tscn")
	
