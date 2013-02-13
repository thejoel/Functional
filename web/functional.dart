import 'dart:html';
import 'dart:math' as Math;

import 'package:vector_math/vector_math_browser.dart';
import 'package:three/three.dart';
import 'package:three/extras/scene_utils.dart' as SceneUtils;
import '../lib/functional.dart' as Func;

class WebGL_Engine  {
  Element container;

  var camera;
  var particleMaterial;
  Scene scene;
  WebGLRenderer renderer;
  Func.Shape shape;
  var edges;
  var mesh;
  var particles;

  void run() {
    init();
    animate(0);
  }

  void init() {

    container = new Element.tag('div');

    document.body.nodes.add( container );

    scene = new Scene();

    camera = new PerspectiveCamera( 70, window.innerWidth / window.innerHeight, 1, 1000 );
    //camera = new OrthographicCamera (-500,500,500,-500);
    camera.position.z = 400;

    scene.add(camera);
    
    var light = new DirectionalLight( 0xffffff );
    light.position.setValues( 0, 0.5, 2 );
    scene.add( light );
    
    particleMaterial = new ParticleBasicMaterial( color: 0x000000, size: 8, opacity: .75 );
    var material = new MeshLambertMaterial( color: 0xBBB );
    var material2 = new MeshBasicMaterial( color: 0x000000, wireframe: true, transparent: true );

    var geometry = new Shape();
    var points = new Geometry();
    
    /*points.moveTo(shape.P[0].x, shape.P[0].y);
    shape.P.forEach((pt){
      points.lineTo(pt.x, pt.y);
    });*/
    shape.allPoints.forEach((pt){
      points.vertices.add(new Vector3(pt.x, pt.y, pt.z));
    });
    
    if (shape.allEdges.length > 0){
      shape.allEdges.forEach((ed){
        geometry.moveTo(ed.start.x, ed.start.y);
        geometry.lineTo(ed.end.x, ed.end.y);
      });
      
      
      edges = new Line( geometry.createPointsGeometry(), material2 );
      //cube = SceneUtils.createMultiMaterialObject( geometry, [ material, material2]);
      scene.add( edges );
    }
    
    
    mesh = new Mesh(points, material);
    scene.add( mesh );
    
    //Particle particle = new Particle( particleMaterial );
    particles = new ParticleSystem( points, particleMaterial );
    scene.add( particles );

    renderer = new WebGLRenderer();
    renderer.setSize( window.innerWidth, window.innerHeight );

    container.nodes.add( renderer.domElement );

    window.on.resize.add(onWindowResize);
    //window.onResize(onWindowResize);
  }

  onWindowResize(e) {

    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();

    renderer.setSize( window.innerWidth, window.innerHeight );

  }
  
  animate(num time) {

    window.requestAnimationFrame( animate );
    
    if (shape.allEdges.length > 0){
      edges.rotation.x += 0.003;
      edges.rotation.y += 0.01;
    }
    
    particles.rotation.x += 0.003;
    particles.rotation.y += 0.01; 
    
    mesh.rotation.x += 0.003;
    mesh.rotation.y += 0.01; 

    renderer.render( scene, camera );

  }

}

void main() {
  var h = new Func.Shape();
  h.P.add(new Func.Point(0.0, 0.0, 0.0));
  h.P.add(new Func.Point(0.0, 1.0, 0.0));
  h.P.add(new Func.Point(1.0, 1.0, 0.0));
  h.P.add(new Func.Point(0.0, 0.0, -1.0));
  
  h.E.add(new Func.Edge(h.P[0], h.P[1]));
  h.E.add(new Func.Edge(h.P[1], h.P[2]));
  h.E.add(new Func.Edge(h.P[2], h.P[0]));
  
  h.F.add(new Func.Face(h.E));
  
  var e = new Func.Extrude(h, new Func.Edge(h.P[0], h.P[3]));
  
  var eng = new WebGL_Engine();
  
  eng.shape = e;
  eng.run();
}