in vec3 worldPosition;

void main() {
	bool x_edge = abs(worldPosition.x) > 0.4;
	bool y_edge = abs(worldPosition.y) > 0.64;
	bool z_edge = abs(worldPosition.z) > 0.4;

	if (!y_edge && !z_edge) {
		discard;
	}

	if (!y_edge && !x_edge) {
		discard;
	}

	gl_FragColor = vec4(1, 1, 1, 1);
}