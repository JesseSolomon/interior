out vec3 worldPosition;
out vec3 worldNormal;

void main() {
	worldNormal = vec3(modelMatrix * vec4(normal, 1.0));
	worldPosition = vec3(modelMatrix * vec4(position, 1.0));

	gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}