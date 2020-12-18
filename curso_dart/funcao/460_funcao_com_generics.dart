//Object é um tipo genérico que cobre todos os 
//tipos dentro da linguagem dart, exemplo
//int, double, etc . Isso tem haver com herança.
Object segundoElementoV1(List lista) {
  return lista != null && lista.length >= 2
    ? lista[1] : null;
}

//definindo uma função que é do tipo genérica
//o elemento E é só um tipo genérico que pode ser
//qualquer coisa, uma string ou um inteiro. É o 
//tipo de parâmetro que passaremos que define esse
//tipo. Essa é uma função genérica:
E segundoElementoV2<E>(List<E> lista) {
  return lista != null && lista.length >= 2
    ? lista[1] : null;
}

main() {
  var lista = [3, 6, 7, 12, 45, 78, 1];

  print(segundoElementoV1(lista)); //6

  print(segundoElementoV2<int>(lista)); //6

  //Dá erro pois o tipo E passa a ser uma String
  //pois usamos generics para definir o String,
  //e tentamos passar uma lista de int para uma lista
  //de string. 
  // segundoElementoV2<String>(lista);

  //Não precisamos definir o generics, pois se
  //passamos por parâmetro uma lista de inteiros,
  //então o parâmetro List<E> lista, faz com que
  //o E passa a ser int, como o retorno da função
  //e a função tem o generics desse mesmo tipo
  int segundoElemento = segundoElementoV2(lista);
  print(segundoElemento); //6

  //Podemos usar o generics no contexto de OO
  //e também no contexto de função.
}