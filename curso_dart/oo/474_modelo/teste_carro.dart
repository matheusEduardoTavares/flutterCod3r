import 'carro.dart';

void main(List<String> args){
  Carro carro = Carro(200);

  for (int i = 0; i < 50; i++){
    carro.acelerar();
    print(carro.velocidadeAtual);
    print(carro.estaNoLimite());
  }

  print('------------------------');

  print(carro.velocidadeAtual);
  print(carro.estaNoLimite());
  print('------------------------');

  while (carro.velocidadeAtual > 0){
    carro.frear();
    print(carro.velocidadeAtual);
  }
  
  print('------------------------');

  print(carro.velocidadeAtual);
  print(carro.estaNoLimite());
  print('------------------------');
}