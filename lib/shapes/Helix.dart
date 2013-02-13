part of functional;

class Helix extends Edge {
  //Parameters
  double pitch = 1.0;
  double radius = 1.0;
  bool cw = true;
  
  Helix(Point start_, Point end_) : super(start_, end_, resolution : 20) {
    driver = (Location loc) {
      double angle = (loc.relative.x / pitch) * 2 * Math.PI;
      double y = Math.sin(angle) * radius;
      double z = Math.cos(angle) * radius;
      return new vec3(loc.relative.x, y, z);
    };
  }
}