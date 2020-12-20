import '../475_modelo/carro.dart';

main(){
  Carro c1 = new Carro(320);

  while (!c1.estaNoLimite()) {
    print('A velocidade atual é ${c1.acelerar()} Km/h.');
  }

  print('O carro chegou no máximo com velocidade de ${c1.velocidadeAtual} Km/h.');

  // while (c1.velocidadeAtual > 0) {
  while (!c1.estaParado()) {
    print('A velocidade atual é ${c1.frear()} Km/h.');
  }

  print('O carro parou com velocidade ${c1.velocidadeAtual} Km/h.');

  //Esse é um problema que pode acontecer no 
  //momento, o fato de não ter atributos privados:
  // c1.velocidadeAtual = 500;
}