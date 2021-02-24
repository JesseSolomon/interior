in vec3 worldPosition;

uniform int face;

const vec2 corners[4] = vec2[](vec2(0.5, 0.5), vec2(-0.5, 0.5), vec2(-0.5, -0.5), vec2(0.5, -0.5));

bool ccw(vec2 A, vec2 B, vec2 C) {
    return (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x);
}

bool intersect(vec2 A, vec2 B, vec2 C, vec2 D) {
    return ccw(A,C,D) != ccw(B,C,D) && ccw(A,B,C) != ccw(A,B,D);
}

void main() {
	vec2 a = worldPosition.xz;
	vec2 b = cameraPosition.xz;

	int intersectedFace = -1;

	for (int i = 0; i < 4; i++) {
		int next = int(mod(float(i + 1), 4.0));

		vec2 c = corners[i];
		vec2 d = corners[next];

		if (intersect(a, b, c, d)) {
			intersectedFace = i;
			break;
		}
	}
	
	switch (intersectedFace) {
		case -1:
			gl_FragColor = vec4(1, 0, 1, 1);
			break;
		case 0:
			gl_FragColor = vec4(1, 0, 0, 1);
			break;
		case 1:
			gl_FragColor = vec4(0, 1, 0, 1);
			break;
		case 2:
			gl_FragColor = vec4(0, 0, 1, 1);
			break;
		case 3:
			gl_FragColor = vec4(0, 1, 1, 1);
			break;
	}
}