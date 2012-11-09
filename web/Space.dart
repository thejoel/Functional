part of functional;

class Shape {
  vec3 start, end, input, dif;
  Set options;

  Shape(this.start, this.input) {
    generate();
  }

  vec3 renderPoint(vec3 v) => new vec3(v.x, v.y, 0);

  void generate({vec3 endPoint, String option}) {
    if (?endPoint) {
      input = endPoint;
    }

    if (!?option) {
      end = input;
    } else if (option == "horizontal") {
      end = new vec3(input.x, start.y, 0);
    } else if (option == "vertical") {
      end = new vec3(start.x, input.y, 0);
    }
  }

  num get dx {
    return end.x - start.x;
  }

  num get dy {
    return end.y - start.y;
  }

  num get dz {
    return end.z - start.z;
  }

  num get length {
    vec3 dif = end - start;
    return sqrt((dif.x * dif.x) + (dif.y * dif.y));
  }

  List render() {
    List ret = [];
    /*num step = length / (resolution-1);

    mat4 rotate = new mat4.raw((dx / length), (dy / length), 0, 0,
                              (-dy / length), (dx / length), 0, 0,
                                0, 0, 1, 0,
                                0, 0, 0, 1);

    ret.add(start);

    for (num ii=start.x+step; ii<end.x; ii += step) {
      ret.add(renderPoint(new vec3(ii, 0, 0)));
    }

    ret.add(end);*/

    return [start, end];
  }
}

class Space {
  Set points, shapes;
  vec3 lastPoint;

  Space() {
    points = new Set();
    shapes = new Set();
  }

  vec3 addPoint(dynamic P) {
    if (P is List) {
      lastPoint = new vec3(P[0], P[1], P[2]);
    } else if (P is vec3) {
      lastPoint = P;
    }

    points.add(lastPoint);
    return lastPoint;
  }

  Shape connect({vec3 point, vec3 to}) {
    if (!?point) {
      point = lastPoint;
    }

    Shape s = new Shape(point, to);
    shapes.add(s);
    addPoint(to);
    return s;
  }

  List render() {
    List path = [];
    shapes.forEach((s){
      path.addAll(s.render());
    });

    return path;
  }
}
