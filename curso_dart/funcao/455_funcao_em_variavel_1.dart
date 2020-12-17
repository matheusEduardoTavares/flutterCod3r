main(){
  //Dart é HIGHER ORDER FUNCTION
  // tipo nome = valor;
  //Temos um tipo chamado Function, que recebe
  //2 parâmetros inteiros e retorna um inteiro.
  int Function(int, int) soma1 = somaFn;
  print(soma1(20, 313));

  //Como o tipo da variável que é do tipo function já
  //recebe 2 inteiros, não precisamos por os parâmetros
  //tipados, pois já será inferido o int para eles.
  int Function(int, int) soma2 = (int x, y) {
    return x + y;
  };

  print(soma2(20, 311));

  //Se fizermos a inferência de tipo usando o var para
  //o caso abaixo, caso os 2 parâmetros nós tipemos com
  //int, então será entendido que é uma função que 
  //retorna um int. Caso apenas um seja int, a
  //inferência determina que é uma função que retorna
  //num, e caso não tipe nenhum parâmetro, então a 
  //inferência dirá que é uma função que recebe 2 
  //dynamic e retorna um dynamic.
  var soma3 = (int x, y) {
    return x + y;
  };

  var soma4 = ([int x = 1, int y = 1]) {
    return x + y;
  };

  print(soma4(20));
}

int somaFn(int a, int b){
  return a + b;
}