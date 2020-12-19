List<E> filtrar<E>(List<E> lista, bool Function(E) fn) {
  List<E> listaFiltrada = [];
  for(E elemento in lista){
    if (fn(elemento)){
      listaFiltrada.add(elemento);
    }
  }

  return listaFiltrada;
}

main(){
  var notas = [8.2, 7.3, 6.8, 5.4, 2.7, 9.3];
  var boasNotasFn = (double nota) => nota >= 7.5;

  var somenteNotasBoas = filtrar(notas, boasNotasFn);
  //Podemos explicitar qual será o tipo de E, do generics
  //da função dessa forma. Mas mesmo que não explicitemos
  //a linguagem irá conseguir inferir seu tipo.
  var somenteNotasBoas2 = filtrar<double>(notas, boasNotasFn);

  print(somenteNotasBoas); //[8.2, 9.3]

  print(somenteNotasBoas2); //[8.2, 9.3]

  var nomes = ['Ana', 'Bia', 'Rebeca', 'Gui', 'João'];

  var nomesGrandesFn = (String nome) => nome.length >= 5;
  print(filtrar(nomes, nomesGrandesFn));
}