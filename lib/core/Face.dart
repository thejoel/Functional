part of functional;

class Face {
  List<Edge> E = [];
  
  Face([List<Edge> e_]) {
    if (?e_){
      E.addAll(e_);
    }
  }
}

