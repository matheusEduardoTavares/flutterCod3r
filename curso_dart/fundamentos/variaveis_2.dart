void main(List<String> args){
  //Quando usamos o var ou o dynamic o compilador irá 
  //inferir o tipo para variável. Quando usamos var, a 
  //variável tem o seu tipo inferido e depois não pode 
  //mais mudar esse tipo, já o dynamic pode mudar o tipo
  //que foi inferido a qualquer momento.
  var n1 = 2;
  //Daria erro:
  // n1 = "";
  var n2 = 4.56;
  var texto = "O valor da soma é: ";
  //Essa concatenação daria erro:
  // print(texto + (n1 + n2));

  var t1 = "Olá";
  var t2 = " Dart!!!";
  print(t1 + t2);

  //Isso funciona:
  print(texto + (n1 + n2).toString());

  //Toda variável tem o atributo runtimeType dentro de dart,
  //e ele mostra qual é o tipo daquela variável
  print(n1.runtimeType); //int
  print(n2.runtimeType); //double
  print(texto.runtimeType); //String

  //Uma outra forma de verificar se é de um certo tipo:
  print(n1 is int); // true
  print(n1 is String); // false
  print(n2 is int); // false
}