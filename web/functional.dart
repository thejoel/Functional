library functional;

import 'dart:html';
import 'package:vector_math/vector_math_browser.dart';

//part 'Space.dart';
part 'Shape.dart';

void main() {
  CanvasElement C = query("#canv");
  var ctx = C.context2d;

  var S = new Space();

  var P1 = new vec3(100, 200, 0);

  //Make sqaure
  var origin = S.addPoint([100, 100, 0]);
  S..connect(to: P1)
   ..connect(to:new vec3(200, 200, 0))
   ..connect(to:new vec3(200, 100, 0))
   ..connect(to:origin);

  //Make triangle
  var triStart = S.addPoint([300, 100, 0]);

  S.connect(to:new vec3(375, 200, 0));

  var edge = S.connect(to:new vec3(450, 100, 0));

  S.connect(to:triStart);

  //Testing modifications
  edge.generate(option:"vertical");

  //Render that shit
  List R = S.render();

  Set endpoints = new Set();
  S.shapes.forEach((Shape shape) {
    endpoints.add(shape.start);
    endpoints.add(shape.end);
  });

  renderPath(ctx, R);
}

void renderPath(cont, List path) {
  var off = 400;

  bool line = false;
  path.forEach((v) {
    if (line) {
      cont.lineTo(v.x, off - v.y);
    } else {
      cont.moveTo(v.x, off - v.y);
    }

    line = !line;
  });

  cont.stroke();
}