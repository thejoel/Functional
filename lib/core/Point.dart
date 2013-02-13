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
  
  List<Point> get attached {
    List<Point> ret = [];
    
    var self = this;
    C.forEach((Constraint cons) {
      ret.add(cons.nextFrom(self));
    });
    
    return ret;
  }
  
  invalidate() {
    C.forEach((c){
      c.visited = false;
    });
  }
  
  bool get valid => C.every((c) => c.valid);
  
  regen() {
    C.forEach((c){
      if (!c.visited) {
        c.enforce();
        c.visited = true;
      }
    });
    
    attached.where((p) => !p.valid).forEach((p) {
      p.regen();
    });
  }
}