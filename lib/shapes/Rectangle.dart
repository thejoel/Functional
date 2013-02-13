part of functional;

class Rectangle extends Shape {
  ConstraintAttach1D _width, _height;
  
  Rectangle() {
    /*P..add(new Point(0.0, 0.0, 0.0))
     ..add(new Point(100.0, 0.0, 0.0))
     ..add(new Point(100.0, 100.0, 0.0))
     ..add(new Point(0.0, 100.0, 0.0));*/
    
    P..add(new Point(0.0))
     ..add(new Point(0.0))
     ..add(new Point(100.0, 100.0, 0.0))
     ..add(new Point(0.0));
    
    E..add(new Edge(P[0], P[1]))
     ..add(new Edge(P[1], P[2]))
     ..add(new Edge(P[2], P[3]))
     ..add(new Edge(P[3], P[0]));
    
    vec3 hori = new vec3(1.0, 0.0, 0.0);
    vec3 vert = new vec3(0.0, 1.0, 0.0);
    
    _width = new ConstraintAttach1D(P[0], P[1], hori);
    _height = new ConstraintAttach1D(P[1], P[2], vert);
    
    P[0].offset(P[1], vert, 0.0);
    //P[0].offset(P[1], hori, 55.0);
    P[1].offset(P[2], hori, 0.0);
    P[2].offset(P[3], vert, 0.0);
    P[3].offset(P[0], hori, 0.0);
    
    //C.forEach((cons){cons.distance = 0.0;});
    _width.distance = 100.0;
    _height.distance = 100.0;
  }
  
  regen() {
    P[0].regen();
    /*Set<Constraint> cons = new Set();
    P.forEach((Point point) {
      cons.addAll(point.C);
    });
    
    //Clear all constraints so we can revalidate them all
    cons.forEach((c){
      c.visited = false;
    });
    
    cons.forEach((c){
      c.enforce();
    });*/
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
