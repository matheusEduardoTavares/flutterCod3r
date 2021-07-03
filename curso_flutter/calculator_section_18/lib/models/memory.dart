///Classe que implementa a lógica da calculadora, em
///que terá funcionalidades para interpretar o 
///botão clicado, as operações matemáticas e etc.
///Será responsável por mostrar os dados no 
///display.
class Memory {
  var _value = '0';

  String get value => _value;

  void applyCommand(String command) {
    if (command == 'AC') {
      _allClear();
    }
    else {
      _value += command;
    }
  }

  void _allClear() {
    _value = '0';
  }
}