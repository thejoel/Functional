part of functional;

class ChildShape {
  Shape s;
  mat4 position;
  
  ChildShape(this.s) {
    position = new mat4.identity();
  }
  
  get allPoints => s.allPoints.map((childPoint) => position.transform3(childPoint));
  get start => position.transform3(s.start);
  get end => position.transform3(s.end);
}