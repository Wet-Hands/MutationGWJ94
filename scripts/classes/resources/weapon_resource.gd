class_name WeaponResource
extends Resource

@export var weapon_name : String = "DefaultWeapon"

@export_category("Ammo")
@export var ammo_type : String = "DefaultAmmo"
@export_range(0, 1024, 1) var maximum_ammo : int
