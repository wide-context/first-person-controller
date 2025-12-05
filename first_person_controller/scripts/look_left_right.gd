extends Node3D

# Use mouse motion to look left and right

var look_sensitivity: float = 0.002
var look_rotation: float = 0.0


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			# Apply vertical mouse motion to look_rotation
			look_rotation -= event.screen_relative.x * look_sensitivity
			
			# Wrap between 0.0 and TAU (0 and 360 deg)
			look_rotation = fposmod(look_rotation, TAU)
			
			# Reset basis to prevent precision errors due to successive operations
			transform.basis = Basis()
			
			# Rotate left and right
			rotate_object_local(Vector3(0.0, 1.0, 0.0), look_rotation)
