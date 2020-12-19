typedef FilterFunction = bool Function(dynamic);

main(){
  //Pode ser também: FilterFunction f
  List<E> filtrar<E>(List<E> items, bool Function(E) f){
  List<E> newList = [];
  for (int i = 0; i < items.length; i++){
    if (f(items[i])){
      newList.add(items[i]);
    }
  }
  return newList;
}

  var notas = [8.2, 7.1, 6.2, 4.4, 3.9, 8.8, 9.1, 5.1];
  var notasBoas = [];

  FilterFunction filterFunction = (item) => item >= 7;

  notasBoas = filtrar(notas, filterFunction);

  print(notasBoas);
}