import '../476_modelo/carro.dart';

main(){
  Carro c1 = new Carro(320);

  // while (c1.velocidadeAtual > 0) {
  while (!c1.estaParado()) {
    print('A velocidade atual é ${c1.frear()} Km/h.');
  }

  print('O carro parou com velocidade ${c1.velocidadeAtual} Km/h.');

  c1.velocidadeAtual = 500;
  c1.velocidadeAtual = 3;
  print('Velocidade Atual: ${c1.velocidadeAtual}');

  c1.velocidadeAtual = -1;
  print('Velocidade Atual: ${c1.velocidadeAtual}');

  print('O carro parou com velocidade ${c1.velocidadeAtual} Km/h.');

  while (!c1.estaNoLimite()) {
    print('A velocidade atual é ${c1.acelerar()} Km/h.');
  }

  print('O carro chegou no máximo com velocidade de ${c1.velocidadeAtual} Km/h.');

  c1.velocidadeAtual = 500;
  c1.velocidadeAtual = 3;
  c1.velocidadeAtual = 322;
  print('Velocidade Atual: ${c1.velocidadeAtual}');
  print('O carro parou com velocidade ${c1.velocidadeAtual} Km/h.');

}