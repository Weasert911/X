extends Node3D

@export var gun_id: String

func interact(body: Node3D):
	if body.is_in_group("player"):
		var wm = get_tree().get_first_node_in_group("weapon_manager")
		wm.add_weapon(gun_id)
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	interact(body)
