import 'dart:math';

main(){
  //nextInt é um método que recebe um valor máximo, 
  //que vai de 0 até o parâmetro -1, e é gerado um
  //número aleatório e inteiro nesse intervalo
  var nota = Random().nextInt(11);

  if (false)


    print('Aprovado!');
    print('Fim!');

  
  if (false)

  {
    print('Aprovado!');
    print('Fim!');
  }

  print("Nota selecionada foi $nota.");
  if (nota >= 7) 
  
  {
    print('Aprovado!');
    print('Fim!');
  } else {
    print("Reprovado!");
  }

  if (nota >= 9) {
    print('Quadro de Honra!');
  } else if (nota >= 7) {
    print("Aprovado!");
  } else if(nota >= 5) {
    print('Recuperação!');
  } else if(nota >= 4) {
    print('Recuperação + Trabalho!');
  } else {
    print("Reprovado!");
  }
  
  if (nota >= 9) {
    print('Quadro de Honra!');
  } else {
    if (nota >= 7) {
      print("Aprovado!");
    } else if(nota >= 5) {
      print('Recuperação!');
    } else if(nota >= 4) {
      print('Recuperação + Trabalho!');
    } else {
      print("Reprovado!");
    }
  }
}