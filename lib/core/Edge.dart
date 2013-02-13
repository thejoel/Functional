part of functional;

class Edge {
  num resolution;
  Point start, end;
  Function driver = ((Location loc) => loc.absolute);
  
  Edge(this.start, this.end, {Function overdriver, num this.resolution : 2 }) {
    if (?overdriver) {
      driver = overdriver;
    }
  }
  
  interpolate(scale) {
    vec3 relative = (end - start) * scale;
    vec3 absolute = relative + start;
    
    return driver(new Location(relative, absolute));
  }
  
  List<vec3> generatePoints([num res]) {
    if (!?res){
      res = resolution;
    }
    List<vec3> ret = [interpolate(0)];
    num step = 1 / (res-1);
    
    for(num ii=1; ii < res; ii++){
      ret.add(interpolate(step*ii));
    }
    
    ret.add(interpolate(1));
    
    return ret;
  }
}


