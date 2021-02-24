function app(shaders) {
	const scene = new THREE.Scene();
	const camera = new THREE.PerspectiveCamera(75, innerWidth / innerHeight, 0.01, 10);
	const renderer = new THREE.WebGLRenderer();

	renderer.setSize(innerWidth, innerHeight);
	document.body.appendChild(renderer.domElement);

	addEventListener("resize", () => {
		renderer.setSize(innerWidth, innerHeight);
		camera.aspect = innerWidth / innerHeight;
		camera.updateProjectionMatrix();
	});

	const controls = new THREE.OrbitControls(camera, renderer.domElement);

	controls.minDistance = 1.1;

	const box = new THREE.Mesh(new THREE.BoxGeometry(1, 1.5, 1), new THREE.ShaderMaterial({
		vertexShader: shaders[0],
		fragmentShader: shaders[1]
	}));

	const testBox = new THREE.Mesh(new THREE.BoxGeometry(0.5, 0.75, 0.5), new THREE.ShaderMaterial({
		vertexShader: shaders[0],
		fragmentShader: shaders[2],
		uniforms: {
			face: {
				value: 1
			}
		}
	}));

	scene.add(box);
	scene.add(testBox);
	camera.position.set(0, 0, -2);

	function render() {
		renderer.render(scene, camera);

		requestAnimationFrame(render);

		controls.update();
	}

	requestAnimationFrame(render);
}

Promise.all([ fetch("/vertex.glsl"), fetch("/outer_fragment.glsl"), fetch("/inner_fragment.glsl") ]) // fetch both the shaders
.then(requests => Promise.all(requests.map(request => request.text()))) // convert the fetch responses to strings
.then(app);