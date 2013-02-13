part of functional;

class Shape {
  List<Point> P = [];
  List<Edge> E = [];
  List<Face> F = [];
  List<Shape> S = [];
  
  List<vec3> get allPoints {
    List<vec3> ret = [];
    ret.addAll(P);
    
    S.forEach((child) {
      ret.addAll(child.allPoints);
    });
    
    return ret;
  }
  
  List<Edge> get allEdges {
    List<Edge> ret = [];
    ret.addAll(E);
    
    S.forEach((child) {
      ret.addAll(child.allEdges);
    });
    
    return ret;
  }
  
  vec3 get start => P.first;
  vec3 get end => P.last;
  
  toString() => 'Points=$allPoints';
}
