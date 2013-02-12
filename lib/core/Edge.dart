part of functional;

class Edge {
  vec3 start, end;
  Function driver;
  
  Edge(this.start, this.end, [overdriver]) {
    if (?overdriver) {
      driver = overdriver;
    } else {
      driver = ((Location loc) => loc.absolute);
    }
  }
  
  interpolate(scale) {
    vec3 relative = (end - start) * scale;
    vec3 absolute = relative + start;
    
    return driver(new Location(relative, absolute));
  }
  
  List<vec3> generatePoints([num res = 5]) {
    List<vec3> ret = [interpolate(0)];
    num step = 1 / (res-1);
    
    for(num ii=1; ii < res; ii++){
      ret.add(interpolate(step*ii));
    }
    
    ret.add(interpolate(1));
    
    return ret;
  }
}


