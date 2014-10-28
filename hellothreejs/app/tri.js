var tri = (function(){
    var tri = {}
    
    tri.k = {
        renderer: {
            antialias: true,
            alpha: false, // set to true for white background
        },
        antialias: true,
        cam: {
            fov: 75,
            asp: window.innerWidth / window.innerHeight,
            near: 0.1,
            far: 10,
            pos: {x:0, y:0, z:2}
        },
        light: {
            // this is the direction the light shines from. does that mean it shines towards the origin?
            // shines from the right hand side (x:1) bottom (y:-1) and closer to the screen (z:1)
            pos: {x:1, y:-1, z:1}, 
            intensity: 1, // anything more than 1 makes a surface white when shone head on
        },
        box: {
            geo: {w:1, h:1, d:1}
        },
        rot: {
            a: 0.01,
            b: 0.001,
            c: 0.0001,
        }
    }

    tri.init = function(){
        var scene = new THREE.Scene();
        var camera = new THREE.PerspectiveCamera(tri.k.cam.fov, tri.k.cam.asp, tri.k.cam.near, tri.k.cam.far);
        var renderer = new THREE.WebGLRenderer({
            antialias: tri.k.renderer.antialias,
            alpha: tri.k.renderer.alpha
        });
        renderer.setSize( window.innerWidth, window.innerHeight );
        document.body.appendChild( renderer.domElement );

        var light = new THREE.DirectionalLight("white", tri.k.light.intensity); 
        light.position.set(tri.k.light.pos.x, tri.k.light.pos.y, tri.k.light.pos.z).normalize(); 
        scene.add( light );

        var geometry = new THREE.BoxGeometry(tri.k.box.geo.w, tri.k.box.geo.w, tri.k.box.geo.d);

        var material1 = new THREE.MeshLambertMaterial( {color:"pink"} );
        var material2 = new THREE.MeshLambertMaterial( {color:"lightgreen"} );
        var material3 = new THREE.MeshLambertMaterial( {color:"lightblue"} );
        
//         // nice colors on cube faces
//         var material1 = new THREE.MeshNormalMaterial();
//         var material2 = new THREE.MeshNormalMaterial();
//         var material3 = new THREE.MeshNormalMaterial();

        var cube1 = new THREE.Mesh( geometry, material1 );
        var cube2 = new THREE.Mesh( geometry, material2 );
        var cube3 = new THREE.Mesh( geometry, material3 );

        scene.add( cube1 );
        scene.add( cube2 );
        scene.add( cube3 );

        camera.position.z = tri.k.cam.pos.z;

        function animate() {
            requestAnimationFrame(animate);

            cube1.rotation.x += tri.k.rot.a;
            cube1.rotation.y += tri.k.rot.b;
            cube1.rotation.z += tri.k.rot.c;

            cube2.rotation.x += tri.k.rot.b;
            cube2.rotation.y += tri.k.rot.c;
            cube2.rotation.z += tri.k.rot.a;

            cube3.rotation.x += tri.k.rot.c;
            cube3.rotation.y += tri.k.rot.a;
            cube3.rotation.z += tri.k.rot.b;

            renderer.render(scene, camera);
        }

        animate();
    }

    return tri
}())
