class Carro {
  //No caso da velocidade máxima, por ser final, 
  //ela será constante, logo, não tem problema 
  //deixá-la como um atributo público.
  final int velocidadeMaxima;
  //Para tornar um atributo privado, basta por o
  //_ antes dele. Essa modificação não é apenas 
  //visível, de fato o atributo passa a não ser
  //possível acessá-lo externamente, ao menos
  //direto pelo prórpio atributo.
  //Caso o local que irá acessar esse atributo 
  //de um objecto dessa classe Carro, seja dentro
  //desse mesmo arquivo, aí mesmo sendo um 
  //atributo privado é possível acessá-lo.
  //Ou seja, esses atributos privados, com _, 
  //só são acessíveis dentro do arquivo que 
  //se encontram. Serve para métodos também, um 
  //método que começa com _ é privado.
  //Para deixar o atributo privado mas permitir
  //trabalhar com aquele atributo fora do arquivo,
  //deve-se usar os getters and setters.
  int _velocidadeAtual = 0;

  Carro([this.velocidadeMaxima = 200]);

  //Embora não seja possível colocar atributos no 
  //get, este é um método.
  int get velocidadeAtual {
    //nesse caso o this. é opcional
    return this._velocidadeAtual;
  }

  void set velocidadeAtual(int novaVelocidade){
    bool deltaValido = (_velocidadeAtual - novaVelocidade).abs() <= 5;
    if (deltaValido && novaVelocidade >= 0){
      if (novaVelocidade > velocidadeMaxima){
        _velocidadeAtual = velocidadeMaxima;
      }
      else {
        this._velocidadeAtual = novaVelocidade;
      }
    }
  }

  int acelerar(){
    if (_velocidadeAtual + 5 >= velocidadeMaxima){
      _velocidadeAtual = velocidadeMaxima;
    }
    else {
      _velocidadeAtual += 5;
    }
    return _velocidadeAtual;
  }

  int frear(){
    if (_velocidadeAtual - 5 <= 0){
      _velocidadeAtual = 0;
    }
    else {
      _velocidadeAtual -= 5;
    }
    return _velocidadeAtual;
  }

  bool estaNoLimite(){
    return _velocidadeAtual == velocidadeMaxima;
  }

  bool estaParado(){
    return _velocidadeAtual == 0;
  }
}