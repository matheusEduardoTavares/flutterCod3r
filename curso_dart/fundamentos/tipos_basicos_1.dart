/*
  - Números (int e double)
  - Sequência de caracteres (String)
  - Booleano (bool)
  - dynamic
*/

main() {
  //Tipos básicos aceitam colocarmos a notação ponto. Ou seja,
  //direto da variável ou pelo próprio literal, podemos chamar
  //métodos ou atributos daquele tipo
  int n1 = 3;
  //No caso do n2 seu valor sera 5.67 pois estamos usando o
  //método abs que retorna o valor absoluto de quem o chamou.
  //Se deixarmos apenas -5.67.abs() , o resultado final será
  //-5.67 pois primeiro irá ser aplicado o abs em 5.67 e 
  //depois será feito uso do operador unário -, por isso
  //continua negativo.
  double n2 = (-5.67).abs();
  // print(n2.abs());

  double n3 = double.parse("12.765");

  //O resultado sempre é convertido para o tipo que pode
  //armazenar + informações, então um int junto de um double
  //irá resultar em um double
  print(n1.abs() + n2 + n3);

  //Outro tipo que temos para números é o num. O num é o pai
  //do double e do int, esses 2 tipos herdam dele, portanto
  //qualquer variável com num pode ser ou int ou double.
  //Não é comum usarmos num, e sim int ou double.
  num n4 = 6;
  print(n1.abs() + n2 + n3 + n4);
  n4 = 6.7;
  print(n1.abs() + n2 + n3 + n4);

  String s1 = "Bom";
  String s2 = " dia";

  print(s1 + s2.toUpperCase() + "!!!");

  bool estaChovendo = true;
  bool muitoFrio = false;

  print(estaChovendo || muitoFrio);
  print(estaChovendo && muitoFrio);

  //Começa com uma String
  dynamic x = "Um texto bem legal";
  print(x);

  //E passa a ser um int. Portanto o tipo dynamic não é
  //fortemente tipado, e sua inferẽncia pode alterar, 
  //inclusive alterando o tipo da variável anteriormente.
  x = 123;
  print(x);

  x = false;
  print(x);

  var y = "Outro texto bem legal!";
  //O var faz a inferência mas depois dá erro se tentar 
  //alterar o tipo:
  //y = 123;
  print(y);
}