out vec3 worldPosition;

void main() {
	worldPosition = vec3(modelMatrix * vec4(position, 1.0));

	gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}