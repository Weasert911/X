extends Area3D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	print("[Checkpoint] Player entered")

	GameManager.set_checkpoint_from_area(self)
