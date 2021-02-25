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

	const sphere = new THREE.Mesh(new THREE.SphereGeometry(0.35, 16, 16), new THREE.ShaderMaterial({
		vertexShader: shaders[0],
		fragmentShader: shaders[2],
		uniforms: {
			face: {
				value: 0
			},
			color: {
				value: new THREE.Vector3(0, 0, 1)
			}
		}
	}));

	const cube = new THREE.Mesh(new THREE.BoxGeometry(0.6, 0.6, 0.6), new THREE.ShaderMaterial({
		vertexShader: shaders[0],
		fragmentShader: shaders[2],
		uniforms: {
			face: {
				value: 1
			},
			color: {
				value: new THREE.Vector3(1, 0, 0)
			}
		}
	}));

	const knot = new THREE.Mesh(new THREE.TorusKnotGeometry(0.3, 0.05), new THREE.ShaderMaterial({
		vertexShader: shaders[0],
		fragmentShader: shaders[2],
		uniforms: {
			face: {
				value: 2
			},
			color: {
				value: new THREE.Vector3(1, 0, 1)
			}
		}
	}));

	const cylinder = new THREE.Mesh(new THREE.CylinderGeometry(0.01, 0.3, 0.65, 18), new THREE.ShaderMaterial({
		vertexShader: shaders[0],
		fragmentShader: shaders[2],
		uniforms: {
			face: {
				value: 3
			},
			color: {
				value: new THREE.Vector3(0, 1, 0)
			}
		}
	}));

	scene.add(box);
	scene.add(sphere);
	scene.add(cube);
	scene.add(knot);
	scene.add(cylinder);
	camera.position.set(0, 0, -2);

	function render() {
		sphere.position.y = Math.sin(performance.now() * 0.002) * 0.1;

		cube.rotateX(0.01);
		cube.rotateY(0.01);
		cube.rotateZ(0.01);

		cylinder.scale.set(1, Math.sin(performance.now() * 0.002), 1);

		renderer.render(scene, camera);

		requestAnimationFrame(render);

		controls.update();
	}

	requestAnimationFrame(render);
}

Promise.all([ fetch("/vertex.glsl"), fetch("/outer_fragment.glsl"), fetch("/inner_fragment.glsl") ]) // fetch both the shaders
.then(requests => Promise.all(requests.map(request => request.text()))) // convert the fetch responses to strings
.then(app);