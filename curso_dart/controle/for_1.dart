main(){

  for(int a = 0; a < 10; a+=2){
    print('a = $a');
  }

  for (int a = 100; a >= 0; a -= 4){
    print('a = $a');
  }

  int b = 0;
  for (; b <= 10; b++){
    print('b = $b');
  }

  for (b = 2; b <= 10; b++){
    print('b = $b');
  }
  print('[FORA] b = $b');

  print('Fim!');

  var notas = [8.9, 9.3, 7.8, 6.9, 9.1];
  for(var i = 0; i < notas.length; i++){
    print("nota ${i + 1} = ${notas[i]}");
  }
}