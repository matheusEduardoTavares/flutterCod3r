import 'dart:math';

main(){
  somaComPrint(2, 3);

  int c = 4;
  int d = 5;
  somaComPrint(c, d);

  somaDoisNumerosQuaisquer();
}

//Se não colocarmos nada o padrão atribuído de 
//retorno será void.
somaComPrint(int a, int b){
  print(a + b);
}

void somaDoisNumerosQuaisquer(){
  int n1 = Random().nextInt(11);
  int n2 = Random().nextInt(11);
  print('Os valores sorteados foram: $n1 e $n2');
  print(n1 + n2);
}