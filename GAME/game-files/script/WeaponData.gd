extends Resource
class_name WeaponData

enum WeaponType {
	PISTOL,
	SMG,
	RIFLE
}

@export var gun_id: String
@export var weapon_type: WeaponType

@export var mag_size: int = 30
@export var max_mags: int = 3

@export var reload_time: float = 1.5
@export var fire_rate: float = 0.1

@export var recoil: float = 1.0
@export var spread: float = 1.0

@export var damage: int = 10
