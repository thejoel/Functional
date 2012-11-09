part of functional;

//Abstract class impliments Shape container (for sub shapes) and connection container for connecting said sub shapes
abstract class Shape {
  List<Shape> shapes;//Children of this
  Set<Shape> connections;//Siblings of this
  List parameters;

  void add(Shape other) {
    shapes.add(other);
  }

  void connect(Shape other) {
    connections.add(other);
  }

  void addParameter();//add a parameter to pool of inputs
  List needsParameters();//Return a set of parameters required to be defined

  vec3 getPoint(vec3 P);
  List<vec3> render();
}

//Point, takes a single vec3 as input and performs no action to modify, returns itself for connections
class Pt extends Shape {
  vec3 _coord;
  Pt(this._coord);
}

/*Line,
 *takes multiple arguments but simplest is two vec3s, other options are (horizontal, vertical, paralell<other> etc)
 *will store and connect two points in locations based on input values
 */
class Line extends Shape {
  num _length, _angle;

  Line(vec3 start_, vec3 end_) {

  }
}

//simple rectangle, takes two vec3s, will store and connect 4 lines