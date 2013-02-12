part of functional;

class Point extends vec3 {
  List<Edge> E = [];
  Set<Constraint> C = new Set();
  
  Point ([dynamic x_, dynamic y_, dynamic z_]) : super(x_, y_, z_);
  
  offset(Point from, [vec3 direction, double distance]) {
    var cons = new ConstraintAttach1D(this, from, direction);
    
    if (?distance) cons.distance = distance;
    
    C.add(cons);
    from.C.add(cons);
  }
}