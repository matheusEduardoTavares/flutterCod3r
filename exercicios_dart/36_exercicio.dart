import 'pessoa2.dart';

class Pessoa {
  String nome;
  String _cpf;

  String get cpf{
    return _cpf;
  }

  void set cpf(String cpf){
    _cpf = cpf;
  }
}

void main(List<String> args){
  var p1 = Pessoa();
  p1.nome = 'João';
  //A convenção do _ torna o atributo / variável privado,
  //mas é privado para fora do arquivo, fora do arquivo
  //não será visível tal atributo / variável, mas dentro
  //do arquivo como nesse caso que a classe pessoa está
  //aqui dentro, então é visível.
  p1._cpf = '123.456.789-00';

  print('O ${p1.nome} tem CPF ${p1._cpf}');

  //Já no caso da classe Pessoa2 seu atributo privado
  //não temos acesso, aí nesse caso seria preciso 
  //usar os getters / setters para acessá-los. Métodos
  //e funções também podem ser privadas.

  var p2 = Pessoa2();
  p2.nome = 'João';
  // p2._cpf = '123.456.789-00'; // ERRO
  p2.cpf = '123.456.789-00';
  print('O ${p2.nome} tem CPF ${p2.cpf}');
}