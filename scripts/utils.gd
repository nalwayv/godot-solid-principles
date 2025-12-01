class_name Utils


## Generates a random point uniformly distributed inside a unit sphere.
static func random_inside_unit_sphere() -> Vector3:
	var theta: float = randf() * 2 * PI
	var phi: float = randf() * PI
	
	var sin_theta: float = sin(theta)
	var cos_theta: float = cos(theta)
	var sin_phi: float = sin(phi)
	var cos_phi: float = cos(phi)
	
	return Vector3(sin_phi * cos_theta, sin_phi * sin_theta, cos_phi)
