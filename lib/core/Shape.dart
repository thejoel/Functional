part of functional;

class Shape {
  List<vec3> P = [];
  List<Edge> E = [];
  Set<Constraint> C = new Set();
  List<Shape> S = [];
  vec3 transDOF;
  vec3 rotDOF;
  
  Shape() {
    transDOF = new vec3(1.0);
    rotDOF = new vec3(1.0);
  }
  
  addChild(Shape child) {
    S.add(child);
  }
  
  regen() {
    S.forEach((Shape child) {
      if (!child.valid){
        child.regen();
      }
    });
    
    C.forEach((Constraint con) {
      con.enforce();
    });
    
    print(valid);
  }
  
  bool get valid => (C.every((Constraint con) => con.valid) && S.every((Shape child) => child.valid));
  
  addConstraint(Constraint cons) {
    C.add(cons);
    transDOF.multiply(cons.transDof);
    rotDOF.multiply(cons.rotDof);
  }
  
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
  
  toString() => 'Points=$allPoints, constraints=$C';
}
