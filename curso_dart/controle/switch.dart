import 'dart:math';

main(){

  //Gera um valor de 0 até 10
  var nota = Random().nextInt(11);
  print('A nota sorteada foi $nota.');

  //No dart é obrigatório ter o 
  //break no uso do switch.

  switch(nota){
    case 10: case 9:
      print('Quadro de Honra');
      print('Parabéns!');
      break;
    case 8:
    case 7:
      print('Aprovado!');
      break;
    case 6:
    case 5:
    case 4:
      print('Recuperação!');
      break;
    case 3:
    case 2:
    case 1:
    case 0:
      print('Reprovado!');
      break;
    default:
      print('Nota inválida!');
  }

  print('Fim!');
}