part of functional;

class Line extends Shape {
  Constraint length;
  Constraint start;
  Constraint end;
  
  /*
   * always 2 points
   * P = [new vec3(), new vec3()];
   * always 1 edge;
   * E = [new edge(p[0], p[1])];
   * 
   * constraints define how they're placed and where
   */
  
  
  Line([double len = 1.0, vec3 s, vec3 e]) : 
    start = new Constraint(val : new vec3(0.0, 0.0, 0.0), driving : true),
    length = new Constraint(val : 1.0, driving : true), 
    end = new Constraint(val : new vec3(1.0, 0.0, 0.0), driving : false) 
  {
    C..add(length)..add(start)..add(end); //Add constraints to list
    P..add(start.val)..add(end.val);
    E.add(new Edge(P[0], P[1]));
  }
  
  setStart(vec3 vec) {
    start.apply(vec);
  }
}

