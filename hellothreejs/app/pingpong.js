var tri = (function(){
    var tri = {}

    var scene, cam, renderer, light, controls;
    var stats;

    var k = {
        deltamove: 1,
        deltarotate: 0.1,
        heightaboveground: 1,
    }

    var g = {

    }

    tri.update = function(){
        stats.update()
    }

    tri.render = function(){
        renderer.render(scene, cam);
    }

    tri.animate = function(){
        requestAnimationFrame(tri.animate);
        tri.update()
        tri.render()
        controls.update() // TODO CONTROLS
    }

    tri.setupscene = function(){
        renderer = new THREE.WebGLRenderer({
            antialias: true,
            alpha: false
        });
        renderer.setSize(window.innerWidth, window.innerHeight);
        document.body.appendChild(renderer.domElement);

        scene = new THREE.Scene();
        light = new THREE.DirectionalLight("white", 1);
        light.position.set(1, 1, 1).normalize();
        scene.add(light);

        // var geometry = new THREE.PlaneGeometry( 20, 20, 10, 10);
        // var material = new THREE.MeshBasicMaterial( {
        //     color: "white",
        //     wireframe: true,
        //     fog: true,
        // } );
        // var plane = new THREE.Mesh( geometry, material );
        // scene.add( plane );
    }

    tri.setupmap = function(){
        // geometry = new THREE.BoxGeometry(10, 10, 1);
        // g.mat1 = new THREE.MeshLambertMaterial({
        //     color: "lightgreen",
        //     fog: true,
        // });
        // g.obj1 = new THREE.Mesh(geometry, g.mat1);
        // scene.add(g.obj1);

        var manager = new THREE.LoadingManager();
        manager.onProgress = function ( item, loaded, total ) {
            console.log( item, loaded, total );
        };

        var texture = new THREE.Texture()
        var loader = new THREE.ImageLoader( manager );
        loader.load( 'static/eiffel-tower.scene/OLDMETAL.JPG', function ( image ) {
            texture.image = image;
            texture.needsUpdate = true;
        } );

        var loader = new THREE.ObjectLoader(manager);
        loader.load( "static/eiffel-tower.scene/eiffel-tower.json", function(obj){
	        obj.traverse( function ( child ) {
                if ( child instanceof THREE.Mesh ) {
                    child.material.map = texture;
                }
            } );

            obj.position.y -= 50
            obj.position.z -= 250
            scene.add(obj)
        });

    }

    tri.bind = function(){
        Mousetrap.bind(["up", "w"], function(e){
            cam.translateZ(-k.deltamove)
            return false
        })

        Mousetrap.bind(["down", "s"], function(e){
            cam.translateZ(k.deltamove)
            return false
        })

        Mousetrap.bind(["right", "d"], function(e){
            cam.rotation.z -= k.deltarotate
            return false
        })

        Mousetrap.bind(["left", "a"], function(e){
            cam.rotation.z += k.deltarotate
            return false
        })
    }

    tri.setupcam = function(){
        cam = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
        // cam.position.x = 10;
        // cam.position.z = k.heightaboveground;
        // cam.up = new THREE.Vector3(0, 0, 1)
        // cam.rotation.order = "ZXY"
        // cam.lookAt(new THREE.Vector3(0, 0, k.heightaboveground))

        // TODO CONTROLS. controls interfere with rotation
        cam.position.z = 0;

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
		document.getElementById("info").appendChild(stats.domElement);
    }

    tri.setup = function(){
        tri.setupscene()
        tri.setupcam()
        tri.setupstats()
        tri.setupmap()
        tri.bind()
    }

    tri.init = function(){
        tri.setup()
        tri.animate();
    }

    return tri
}());
