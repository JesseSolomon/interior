in vec3 worldPosition;
in vec3 worldNormal;

uniform int face;
uniform vec3 color;

// Define the corners of the box, we don't need to define the whole cube, just the 2D area
const vec2 corners[4] = vec2[](vec2(0.5, 0.5), vec2(-0.5, 0.5), vec2(-0.5, -0.5), vec2(0.5, -0.5));

// Line intersection code ported from Python
// Source: https://stackoverflow.com/questions/3838329/how-can-i-check-if-two-segments-intersect#answer-9997374
bool ccw(vec2 A, vec2 B, vec2 C) {
    return (C.y-A.y) * (B.x-A.x) > (B.y-A.y) * (C.x-A.x);
}

bool intersect(vec2 A, vec2 B, vec2 C, vec2 D) {
    return ccw(A,C,D) != ccw(B,C,D) && ccw(A,B,C) != ccw(A,B,D);
}

void main() {
	// Define a line from the fragnent's position (A) to the camera (B)
	vec2 a = worldPosition.xz;
	vec2 b = cameraPosition.xz;

	// Get the second point to define the face. Example: (Face 0 = Corners 0 & 1; Face 3 = Corners 3 & 0)
	int next = int(mod(float(face + 1), 4.0));

	// Define a line at the given face
	vec2 c = corners[face];
	vec2 d = corners[next];

	// If the defined lines do NOT intersect, then discard the fragment
	if (!intersect(a, b, c, d)) {
		discard;
	}

	// Some simple direction-based lighting to help with depth
	float lighting = (1.0 - distance(worldNormal, vec3(0, 1, 0)) * 0.314);
	
	gl_FragColor = vec4(color * lighting, 1);
}