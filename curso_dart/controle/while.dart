import 'dart:io';

void main(){
  var digitado = '';

  int a = 0;
  while(a < 10){
    print(a);
    a++;
  }

  for (int a = 0; a < 10; a++){
    print(a);
  }

  print('-------------------');

  while(digitado != 'sair'){
    stdout.write('Digite algo ou sair: ');
    digitado = stdin.readLineSync();
  }

  //De forma geral, em listas, maps
  //e sets usamos o for in ou o for
  //tradicional para percorrê-los
  //Mas quando temos situações que não
  //sabemos quantas vezes a expressão
  //irá acontecer usamos o while.

  print('-------------------');

  digitado = '';

  for(; digitado != 'sair';){
    stdout.write('Digite algo ou sair: ');
    digitado = stdin.readLineSync();
  }

  print('-------------------');
  
  digitado = 'sair';

  do {
    stdout.write('Digite algo ou sair: ');
    digitado = stdin.readLineSync();
  } while(digitado != 'sair');

  print('Fim');
}