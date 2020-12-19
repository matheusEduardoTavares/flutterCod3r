class Carro {
  final int velocidadeMaxima;
  int velocidadeAtual;

  Carro(this.velocidadeMaxima, {int velocidadeAtual = 0}){
    this.velocidadeAtual = velocidadeAtual > velocidadeMaxima ? velocidadeMaxima : velocidadeAtual;
  }

  int acelerar(){
    int novaVelocidade = velocidadeAtual + 5;
    if (novaVelocidade > velocidadeMaxima){
      velocidadeAtual = velocidadeMaxima;
    }
    else {
      velocidadeAtual = novaVelocidade;
    }
    return velocidadeAtual;
  }

  int frear(){
    int novaVelocidade = velocidadeAtual - 5;
    if (novaVelocidade < 0){
      velocidadeAtual = 0;
    }
    else {
      velocidadeAtual = novaVelocidade;
    }
    return velocidadeAtual;
  }

  bool estaNoLimite(){
    return velocidadeAtual == velocidadeMaxima;
  }

}