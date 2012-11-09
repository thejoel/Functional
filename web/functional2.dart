import 'dart:html';
import 'package:vector_math/vector_math_browser.dart';

class Connection {
  vec3 loc; //Location

  Connection(this.loc);
  Connection.xyz(num x, num y, num z) {
    loc = new vec3(x, y, z);
  }
}

class Shape {
  Set connections;
  num resolution;

  Shape() {
    resolution = 2;
  }

  renderPoint(num x) => new vec3(x, 0, 0);

  render() {
    List ret = [];
    num start = 0,
        end   = 1,
        step  = 1 / (resolution-1);

    ret.add(renderPoint(start));

    for (num ii=start+step; ii<end; ii += step) {
      ret.add(renderPoint(ii));
    }

    ret.add(renderPoint(end));

    return ret;
  }
}

class Arc extends Shape {
  var R, C, T;

  Arc({this.R : .5, this.C : 0, this.T : 0}) {
    resolution = 50;
  }

  renderPoint(num x) {
    num temp = x-.5;
    num y = sqrt((R*R) - (temp * temp)) - C;
    return new vec3(x, y, 0);
  }
}

class ChainLink {
  vec3 previous, next;
  Shape shape;

  ChainLink(this.previous, this.next, this.shape);

  List path() {
    List path = shape.render();
    vec3 dif = next - previous;
    num mag = sqrt((dif.x * dif.x) + (dif.y * dif.y));
    mat4 trans = new mat4.raw( (dif.x / mag), (dif.y / mag), 0, 0,
                              (-dif.y / mag), (dif.x / mag), 0, 0,
                                0, 0, 1, 0,
                                0, 0, 0, 1);

    trans.scale(mag);

    path = transformPath(path, trans);
    path = translatePath(path, previous);

    return path;
  }
}

class Chain {
  Shape tool;
  vec3 origin;
  List pts, links;

  Chain() {
    links = [];
    origin = new vec3();
    pts = [origin];
  }

  addTool(Shape s) {
    tool = s;
  }

  start (num nx, num ny) {
    origin.x = nx;
    origin.y = ny;
  }

  next(num nx, num ny) {
    vec3 next = new vec3(nx, ny, 0);
    links.add(new ChainLink(pts.last, next, tool));
    pts.add(next);
  }

  nextVec(vec3 next) {
    links.add(new ChainLink(pts.last, next, tool));
  }

  close() {
    if (!links.isEmpty){
      nextVec(pts[0]);
    }
  }

  get path {
    List P = [];

    num ii = 0;
    links.forEach((ChainLink link) {
      P.addAll(link.path());
    });

    return P;
  }
}

void main() {
  CanvasElement C = query("#canv");
  var ctx = C.context2d;

  Chain chain = new Chain()..start(400,300)
                           ..addTool(new Shape())
                           ..next(300,300)
                           ..next(300,200)
                           ..next(400,200)
                           ..close();

  var test = chain.pts[2];
  print(chain.pts[2]);
  test.x = 240;
  test.y = 150;
  assert(chain.links.last.next === chain.pts[0]);
  print(chain.path);
  renderPath(ctx, chain.path);
}

List transformPath(List path, mat4 trans) {
  List ret = [];

  path.forEach((v){
    ret.add(trans.transform3(v));
  });

  return ret;
}

List translatePath(List path, vec3 trans) {
  List ret = [];

  path.forEach((v){
    ret.add(v + trans);
  });

  return ret;
}

void renderPath(cont, List path) {
  var off = 400;
  cont.moveTo(path[0].x, off - path[0].y);

  path.forEach((v) {
    cont.lineTo(v.x, off - v.y);
  });

  cont.stroke();
}