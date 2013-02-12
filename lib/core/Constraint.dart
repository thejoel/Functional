part of functional;

abstract class Constraint {
  dynamic A, B;
  bool visited = false;
  
  nextFrom(dynamic Entity);//Get the next element given a starting point
  
  //Degrees of freedom
  get valid;
  apply();
  
  enforce() {
    if (!valid){
      apply();
    }
  }
}

class ConstraintAttach1D extends Constraint {
  vec3 A, B, ref;
  double distance;
  
  ConstraintAttach1D(vec3 this.A, vec3 this.B, vec3 this.ref) {
    ref.normalize();
    distance = ((B - A) * ref).length;
  }
  
  nextFrom(vec3 Entity) {
    if (identical(A, Entity)) {
      return B;
    }
    
    return A;
  }
  
  get valid => (((B - A) * ref).length) == distance;
  
  apply() {
    //Apply A to B
    vec3 dif = ((A - B) * ref) - ref.clone().scale(distance);
    A.sub(dif);
  }
  
  toString() => 'ref=$ref, dist=$distance';

}