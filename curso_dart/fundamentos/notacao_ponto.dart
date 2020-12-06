main(){
  //Arredondando:
  double nota = 6.99.roundToDouble();
  print(nota); //7.0
  nota = 6.99.truncateToDouble();
  print(nota); //6.0

  print("Texto".toUpperCase());

  String s1 = "leonardo leitão";
  String s2 = s1.substring(0, 8);
  String s3 = s2.toUpperCase();
  //O método padRight passamos qual o tamanho queremos que
  //dada string tenha, e como segundo parâmetro qual caractere
  //irá preencher a string para que ela obtenha aquele tamanho
  String s4 = s3.padRight(15, "!");

  //Podemos chamar vários atributos ou métodos de forma
  //encadeada, basta apenas entender o tipo que é retornado
  //na chamada do que está sendo feito e a partir daquele
  //tipo é possível chamar qualquer método ou atributo que
  //este tipo tenha.

  var s5 = "leonardo leitão"
    .substring(0, 8)
    .toUpperCase()
    .padRight(15, "!");

  var s6 = "leonardo leitão"
    .substring(0, 8)
    .toUpperCase()
    .padRight(15, "!")
    .length.abs();

  print(s2);//leonardo
  print(s3);//LEONARDO
  print(s4);//LEONARDO!!!!!!!
  print(s5);//LEONARDO!!!!!!!
  print(s6);//15
}