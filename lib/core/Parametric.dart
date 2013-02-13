part of functional;

class Parametric<T> {
  T Entity;
  Function modifier;
  
  get val => modifier(Entity);
}

