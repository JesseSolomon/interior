in vec3 worldPosition;
in vec3 worldNormal;

uniform int face;
uniform vec3 color;

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

	int next = int(mod(float(face + 1), 4.0));

	vec2 c = corners[face];
	vec2 d = corners[next];

	if (!intersect(a, b, c, d)) {
		discard;
	}

	float lighting = (1.0 - distance(worldNormal, vec3(0, 1, 0)) * 0.314);
	
	gl_FragColor = vec4(color * lighting, 1);
}