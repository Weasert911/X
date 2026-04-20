extends RigidBody3D
class_name Pickable

var is_held = false

func pick_up():
    is_held = true
    freeze = true
    collision_layer = 0
    collision_mask = 0

func release(position: Vector3, impulse: Vector3):
    is_held = false
    freeze = false
    collision_layer = 1
    collision_mask = 1
    global_position = position
    apply_impulse(Vector3.ZERO, impulse)
