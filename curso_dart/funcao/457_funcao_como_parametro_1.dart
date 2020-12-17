import 'dart:math';

void executar({Function fnPar, Function fnImpar}){
  var sorteado = Random().nextInt(10);
  print('O valor sorteado foi $sorteado');

  sorteado % 2 == 0 ? fnPar() : fnImpar();

  if (sorteado % 2 == 0){
    fnPar();
  }
  else{
    fnImpar();
  }
}

void main(){
  var minhaFnPar = () => print('Eita! O valor é par!');
  var minhaFnImpar = () => print('Legal! O valor é ímpar!');

  executar(fnPar: minhaFnPar, fnImpar: minhaFnImpar);
}