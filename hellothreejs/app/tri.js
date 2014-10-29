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
            pos: {x:2, y:-2, z:4}, 
            intensity: 1, // anything more than 1 makes a surface white when shone head on
        },
        box: {
            geo: {w:1, h:1, d:1}
        },
        rot: [0.01, 0.001, 0.0001],
    }
    
    tri.rotate = function(obj, i){
        obj.rotation.x += tri.k.rot[i % 3];
        obj.rotation.y += tri.k.rot[(i + 1) % 3];
        obj.rotation.z += tri.k.rot[(i + 2) % 3];
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
//         var geometry = new THREE.SphereGeometry(1, 10, 10);

        var material1 = new THREE.MeshPhongMaterial({
            color: "pink",
            specular: "green",
            shininess: 30,
        });
        var material2 = new THREE.MeshPhongMaterial({
            color: "lightgreen",
            specular: "lightblue", // black is more matte, white more shiny
            shininess: 30,
        });
        var material3 = new THREE.MeshPhongMaterial({
            color: "lightblue",
            specular: "white",
            shininess: 180,
        });        
        
//         var material1 = new THREE.MeshLambertMaterial( {color:"pink"} );
//         var material2 = new THREE.MeshLambertMaterial( {color:"lightgreen"} );
//         var material3 = new THREE.MeshLambertMaterial( {color:"lightblue"} );
        
//         // nice colors on obj faces
//         var material1 = new THREE.MeshNormalMaterial();
//         var material2 = new THREE.MeshNormalMaterial();
//         var material3 = new THREE.MeshNormalMaterial();

        var obj1 = new THREE.Mesh( geometry, material1 );
        var obj2 = new THREE.Mesh( geometry, material2 );
        var obj3 = new THREE.Mesh( geometry, material3 );

        scene.add( obj1 );
        scene.add( obj2 );
        scene.add( obj3 );

        camera.position.z = tri.k.cam.pos.z;

        function animate() {
            requestAnimationFrame(animate);

            tri.rotate(obj1, 0)
            tri.rotate(obj2, 1)
            tri.rotate(obj3, 2)

            renderer.render(scene, camera);
        }

        animate();
    }

    return tri
}())
