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
      
      var material = new MeshLambertMaterial( color: 0xBBB );
      var material2 = new MeshBasicMaterial( color: 0x000000, wireframe: true, transparent: true );
      
      edges = new Line( geometry.createPointsGeometry(), material2 );
      //cube = SceneUtils.createMultiMaterialObject( geometry, [ material, material2]);
      scene.add( edges );
    }
    
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

    renderer.render( scene, camera );

  }

}

void main() {
  var origin = new Func.Point();
  var rect = new Func.Rectangle();
  
  var zeroX = new Func.ConstraintAttach1D(rect.start, origin.P[0], new vec3(1.0, 0.0, 0.0));
  var zeroY = new Func.ConstraintAttach1D(rect.start, origin.P[0], new vec3(0.0, 1.0, 0.0));
  
  rect.width = 200.0;
  rect.height = 200.0;
  
  zeroX.distance = 0.0;
  zeroY.distance = 0.0;
  
  var h = new Func.Shape();
  h..addChild(rect);
  
  print(h);
  h.regen();
  print(h);
  
  var eng = new WebGL_Engine();
  
  eng.shape = h;
  eng.run();
}