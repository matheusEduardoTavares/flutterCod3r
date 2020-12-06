main(){
  String nome = 'João';
  String status = 'aprovado';
  double nota = 9.2;

  String frase1 = nome + " está " + status + " porquê tirou nota " + nota.toString() + "!";

  print(frase1);//João está aprovado porquê tirou nota 9.2!

  //Na interpolação é chamado o toString para as variáveis de 
  //forma automática
  String frase2 = '$nome está $status porquê tirou nota $nota!';
  print(frase2);//João está aprovado porquê tirou nota 9.2!

  String frase3 = '$nome está $status porquê tirou nota ${nota.toString()}!';
  print(frase3);//João está aprovado porquê tirou nota 9.2!

  //O \ é o scape.
  String frase4 = '\$nome está $status porquê tirou nota ${nota.toString()}!';
  print(frase4);//$nome está aprovado porquê tirou nota 9.2!

  print("1 + 1 = ${1 + 1}");//1 + 1 = 2
  print("30 * 30 = ${30 * 30}");//30 * 30 = 900
}