part of functional;

class Extrude extends Shape {
  Shape xsec;
  Edge path;
  
  Extrude(this.xsec, this.path);
  
  List<Point> get allPoints {
    List<Point> base = xsec.allPoints;
    List<vec3> stops = path.generatePoints();
    
    P = [];
    
    stops.forEach((vec3 stop){
      base.forEach((Point b){
        P.add(b + stop);
      });
    });
    
    return P;
  }
  
}

