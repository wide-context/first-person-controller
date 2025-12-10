extends Node3D

# Use mouse motion to look up and down

var look_sensitivity: float = 0.002
var look_down_limit: float = -90.0
var look_up_limit: float = 90.0
var look_rotation: float = 0.0


func _ready() -> void:
	# Initialize look rotation to avoid snapping to 0.0
	look_rotation = global_rotation.x


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			# Apply vertical mouse motion to look_rotation
			look_rotation -= event.screen_relative.y * look_sensitivity
			look_rotation = clampf(look_rotation, deg_to_rad(look_down_limit), deg_to_rad(look_up_limit))
			
			# Reset basis to prevent precision errors due to successive operations
			transform.basis = Basis()
			
			# Rotate up and down
			rotate_object_local(Vector3(1.0, 0.0, 0.0), look_rotation)
