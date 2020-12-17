import 'dart:math';

main(){
  int n1 = numeroAleatorio(100);
  print(n1);
  int n2 = numeroAleatorio();
  print(n2);

  imprimirData(10, 12, 2020);
  imprimirData(10, 12);
  imprimirData(10);
  //Dá erro:
  // imprimirData();
}

int numeroAleatorio([int maximo = 11]){
  return Random().nextInt(maximo);
}

//A data 01/01/1970 é a data padrão do calendário 
//UNIX, a data 0 desses sistemas é essa
imprimirData(int dia, [int mes = 1, int ano = 1970]){
  print('$dia/$mes/$ano');
}