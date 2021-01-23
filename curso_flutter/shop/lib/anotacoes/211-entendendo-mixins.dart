/*
class Carro {
  int _velocidade = 0;

  int acelerar() {
    _velocidade += 5;
    return _velocidade;
  }

  int frear() {
    _velocidade -= 5;
    return _velocidade;
  }
}

class Ferrari extends Carro {}
class Gol extends Carro {}


void main() {
  // var c1 = Carro();
  // var c1 = Ferrari();
  //Podemos passar uma subclasse de Carro como instância
  //para dentro da variável carro. Isso acontece devido
  //a polimorfismo, o Carro pode assumir múltiplas formas
  // Carro c1 = Ferrari();

  // print(c1.acelerar());
  // print(c1.acelerar());
  // print(c1.acelerar());

  // print(c1.frear());
  // print(c1.frear());

  Carro c1 = Ferrari();
  print(c1.acelerar());

  c1 = Gol();
  print(c1.acelerar());
  print(c1.acelerar());

  print(c1.frear());
  print(c1.frear());
}
*/

class Carro {
  int _velocidade = 0;

  int acelerar() {
    _velocidade += 5;
    return _velocidade;
  }

  int frear() {
    _velocidade -= 5;
    return _velocidade;
  }
}

//Mixin significa mistura. Não é uma herança, é 
//como se fosse um CTRL C + CTRL V automatizado, ele
//copia o código dentro do mixin para a classe que 
//fazemos um with com tal mixin.
mixin Esportivo {
  bool _turboLigado = false;

  ligarTurbo() {
    _turboLigado = true;
  }

  desligarTurbo() {
    _turboLigado = false;
  }
}

mixin Luxo {
  bool _arLigado = false;

  ligarAr() {
    _arLigado = true;
  }

  desligarAr() {
    _arLigado = false;
  }
}

//Dart tem herança simples. Não poderíamos fazer por
//exemplo a Ferrari herdar de mais de uma classe.
class Transporte {}

//Isso dá erro:
// class Ferrari extends Carro, Transporte with Esportivo {}

//Daria para fazer o Carro extender o transporte e depois
//a Ferrari herdar de Carro. Já no caso do mixin, uma
//classe pode usar vários mixins. A classe ferrari irá
//receber o que foi definido de cada mixin, e 
//diferente da herança que os dados continuam na classe
//pai, e recebemos isso com a herança, no caso do 
//mixin ele copia o código e cola dentro da classe que
//usa o with nele, de forma que passamos a ter isso
//dentro da classe.
class Ferrari extends Carro with Esportivo, Luxo {
  //Sobrescrevendo o método de acelerar que vem 
  //do mixin (o override é opcional, sem ele também 
  //é sobrescrito o método caso o herde do pai ou 
  //o pegue do mixin, mas é bom colocar esse 
  //decorator para deixar claro):
  @override 
  int acelerar(){
    //Se o turbo estiver ligado irá acelerar 2 
    //vezes
    if (_turboLigado) {
      super.acelerar();
    }

    return super.acelerar();
  } 
}
class Gol extends Carro {}

void main() {
  var c1 = Ferrari();
  print(c1.acelerar());

  c1.ligarTurbo();

  print(c1.acelerar());
  print(c1.acelerar());

  print(c1.frear());
  print(c1.frear());
}