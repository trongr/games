var tri = (function(){
    var tri = {}

    var scene, cam, renderer, light, geometry, controls;
    var stats;

    var k = {
        antialias: true,
        alpha: false,
        fov: 75,
        asp: window.innerWidth / window.innerHeight,
        near: 0.1,
        far: 10,
        camz: 2,
        lightx: 0, lighty: 0, lightz: 2,
        lightintensity: 1,
        boxw: 1, boxh: 1, boxd: 1,
        rotations: [0.01, 0.001, 0.0001],
    }

    var g = {
        mat1: null,
        mat2: null,
        mat3: null,
        obj1: null,
        obj2: null,
        obj3: null,
    }

    function rotate(obj, i){
        obj.rotation.x += k.rotations[i % 3];
        obj.rotation.y += k.rotations[(i + 1) % 3];
        obj.rotation.z += k.rotations[(i + 2) % 3];
    }

    tri.update = function(){
        rotate(g.obj1, 0)
        rotate(g.obj2, 1)
        rotate(g.obj3, 2)
        stats.update()
    }

    tri.render = function(){
        renderer.render(scene, cam);
    }

    tri.animate = function(){
        requestAnimationFrame(tri.animate);
        tri.update()
        tri.render()
        controls.update()
    }

    tri.setupscene = function(){
        scene = new THREE.Scene();
        cam = new THREE.PerspectiveCamera(k.fov, k.asp, k.near, k.far);
        cam.position.z = k.camz;
        renderer = new THREE.WebGLRenderer({
            antialias: k.antialias,
            alpha: k.alpha
        });
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.body.appendChild(renderer.domElement);

        light = new THREE.DirectionalLight("white", k.lightintensity);
        light.position.set(k.lightx, k.lighty, k.lightz).normalize();
        scene.add(light);
    }

    tri.setupobjs = function(){
        geometry = new THREE.BoxGeometry(k.boxw, k.boxh, k.boxd);
        // geometry = new THREE.SphereGeometry(1, 10, 10);

        g.mat1 = new THREE.MeshPhongMaterial({color:"pink", specular:"green", shininess:30});

        g.mat2 = new THREE.MeshPhongMaterial({
            color: "lightgreen",
            specular: "lightblue", // black is more matte, white more shiny
            shininess: 30,
        });

        g.mat3 = new THREE.MeshPhongMaterial({
            color: "lightblue",
            specular: "white",
            shininess: 180,
        });

        //         g.mat1 = new THREE.MeshLambertMaterial( {color:"pink"} );
        //         g.mat2 = new THREE.MeshLambertMaterial( {color:"lightgreen"} );
        //         g.mat3 = new THREE.MeshLambertMaterial( {color:"lightblue"} );

        //         // nice colors on obj faces
        //         g.mat1 = new THREE.MeshNormalMaterial();
        //         g.mat2 = new THREE.MeshNormalMaterial();
        //         g.mat3 = new THREE.MeshNormalMaterial();

        g.obj1 = new THREE.Mesh( geometry, g.mat1 );
        g.obj2 = new THREE.Mesh( geometry, g.mat2 );
        g.obj3 = new THREE.Mesh( geometry, g.mat3 );

        scene.add( g.obj1 );
        scene.add( g.obj2 );
        scene.add( g.obj3 );
    }

    tri.setupcontrols = function(){
		controls = new THREE.TrackballControls(cam);

		controls.rotateSpeed = 1.0;
		controls.zoomSpeed = 1.2;
		controls.panSpeed = 0.8;

		controls.noZoom = false;
		controls.noPan = false;

		controls.staticMoving = true;
		controls.dynamicDampingFactor = 0.3;

		controls.keys = [ 65, 83, 68 ];

		controls.addEventListener('change', tri.render);
    }

    tri.setupstats = function(){
		stats = new Stats();
		stats.domElement.style.position = 'absolute';
		stats.domElement.style.top = '0px';
		stats.domElement.style.zIndex = 100;
		document.getElementById("info").appendChild( stats.domElement );
    }

    tri.setup = function(){
        tri.setupscene()
        tri.setupobjs()
        tri.setupcontrols()
        tri.setupstats()
    }

    tri.init = function(){
        tri.setup()
        tri.animate();
    }

    return tri
}());
