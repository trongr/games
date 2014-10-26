var tri = (function(){
    var tri = {}

    tri.init = function(){
        var scene = new THREE.Scene();
        var camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );
        // var renderer = new THREE.WebGLRenderer();
        var renderer = new THREE.WebGLRenderer({antialias:true});
        renderer.setSize( window.innerWidth, window.innerHeight );
        document.body.appendChild( renderer.domElement );

        var geometry = new THREE.BoxGeometry(1,1,1);

        // nice colors on cube faces
        var material1 = new THREE.MeshNormalMaterial();
        var material2 = new THREE.MeshNormalMaterial();
        var material3 = new THREE.MeshNormalMaterial();

        // var material1 = new THREE.MeshBasicMaterial( { color: 0xff0000 } );
        // var material2 = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
        // var material3 = new THREE.MeshBasicMaterial( { color: 0x0000ff } );

        // var material1 = new THREE.MeshNormalMaterial({wireframe:true})
        // var material2 = new THREE.MeshNormalMaterial({wireframe:true})
        // var material3 = new THREE.MeshNormalMaterial({wireframe:true})

        var cube1 = new THREE.Mesh( geometry, material1 );
        var cube2 = new THREE.Mesh( geometry, material2 );
        var cube3 = new THREE.Mesh( geometry, material3 );

        scene.add( cube1 );
        scene.add( cube2 );
        scene.add( cube3 );

        camera.position.z = 2;

        function animate() {
            requestAnimationFrame(animate);

            cube1.rotation.x += 0.01;
            cube1.rotation.y += 0.001;
            cube1.rotation.z += 0.0001;

            cube2.rotation.x += 0.0001;
            cube2.rotation.y += 0.01;
            cube2.rotation.z += 0.001;

            cube3.rotation.x += 0.001;
            cube3.rotation.y += 0.0001;
            cube3.rotation.z += 0.01;

            renderer.render(scene, camera);
        }

        animate();
    }

    return tri
}())
