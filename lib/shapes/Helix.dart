part of functional;

class Helix extends Shape {
  Edge _e;
  double pitch = 1.0;
  double radius = 1.0;
  bool cw = true;
  
  vec3 _es = new vec3(0, 0, 0);
  vec3 _ee   = new vec3(1, 0, 0);
  
  Helix() {    
    _e = new Edge(_es, _ee, (Location loc) {
      double angle = (loc.relative.x / pitch) * 2 * Math.PI;
      double y = Math.sin(angle) * radius;
      double z = Math.cos(angle) * radius;
      return new vec3(loc.relative.x, y, z);
    });
    
    E.add(_e);
    P..add(start)..add(end);
  }
  
  get start => _e.interpolate(0);
  get end   => _e.interpolate(1);
  
  get length => _ee.x;
  set length(double L) {
    _ee.x = L;
  }
}