part of functional;

class Rectangle extends Shape {
  ConstraintAttach1D _width, _height;
  
  Rectangle() {
    P..add(new vec3(0.0, 0.0, 0.0))
     ..add(new vec3(100.0, 0.0, 0.0))
     ..add(new vec3(100.0, 100.0, 0.0))
     ..add(new vec3(0.0, 100.0, 0.0));
    
    E..add(new Edge(P[0], P[1]))
     ..add(new Edge(P[1], P[2]))
     ..add(new Edge(P[2], P[3]))
     ..add(new Edge(P[3], P[0]));
    
    vec3 hori = new vec3(1.0, 0.0, 0.0);
    vec3 vert = new vec3(0.0, 1.0, 0.0);
    
    _width = new ConstraintAttach1D(P[0], P[1], hori);
    _height = new ConstraintAttach1D(P[1], P[2], vert);
    
    C..add(new ConstraintAttach1D(P[0], P[1], vert))
     ..add(new ConstraintAttach1D(P[1], P[2], hori))
     ..add(new ConstraintAttach1D(P[2], P[3], vert))
     ..add(new ConstraintAttach1D(P[3], P[0], hori))
     ..add(_width)..add(_height);
    
    C.forEach((cons){cons.distance = 0.0;});
    _width.distance = 100.0;
    _height.distance = 100.0;
    
  }
  
  set width(double w) {
    _width.distance = w;
  }
  
  set height(double h) {
    _height.distance = h;
  }
  
  get width => _width.distance;
  get height => _height.distance;
}
