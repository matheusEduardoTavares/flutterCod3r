///Classe que implementa a lógica da calculadora, em
///que terá funcionalidades para interpretar o 
///botão clicado, as operações matemáticas e etc.
///Será responsável por mostrar os dados no 
///display.
class Memory {
  static const operations = const [
    '%', '/', 'x', '-', '+', '='
  ];

  ///Dois números que deverão ser operados
  final _buffer = [0.0, 0.0];
  ///Qual dos 2 valores estão sendo digitados (
  ///as operações na calculadora são tratados 
  ///2 a 2 elementos)
  var _bufferIndex = 0;
  var _value = '0';
  String _operation;
  ///Sempre que o usuário teclar em uma operação 
  ///nova, deve-se zerar o [_value]
  var _wipeValue = false;

  ///Sem esse tratamento feito por esta variável,
  ///ao digitar 10 por exemplo e clicar em mais,
  ///e logo em seguida em menos, ou seja, trocar 
  ///a operação, o valor que aparece no display 
  ///da tela acabará sendo zerado.
  String _lastCommand;

  String get value => _value;


  void applyCommand(String command) {
    if (_isReplacingOperation(command)) {
      _operation = command;
      return;
    }

    if (command == 'AC') {
      _allClear();
    }
    else if (operations.contains(command)) {
      _setOperation(command);
    }
    else {
      _addDigit(command);
    }

    _lastCommand = command;
  }

  bool _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) &&
      operations.contains(command) && 
        _lastCommand != '=' && 
          command != '=';
  }

  void _setOperation(String newOperation) {
    var isEqualSign = newOperation == '=';
    if (_bufferIndex == 0) {
      if (!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
      }
    }
    else {
      _buffer[0] = _calculate();
      _buffer[1] = 0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? 
        _value.split('.')[0] : _value;

      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;
    }

    ///Após realizar um cálculo, o resultado pode
    ///ser usado caso a linha abaixo seja descomentada
    ///removendo também o _wipeValue = true;
    ///Então se a conta deu 8, por exemplo, se deixar
    ///apenas o true e digitar outro número por cima,
    ///irá sumir o 8 e aparecer o número. Já com o 
    ///true, se for digitado 7, ficará 87.
    // _wipeValue = !isEqualSign;
    _wipeValue = true;
  }

  void _addDigit(String digit) {
    final isDot = digit == '.';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    ///Evitar digitar duas vezes . num mesmo número
    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    }

    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;

    ///O . também será um digito para casa decimais
    ///do número
    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
    // print(_buffer);
  }

  void _allClear() {
    _value = '0';
    ///A partir do índice 0, setar os valores colocados
    ///da lista no segundo parâmetro na ordem
    _buffer.setAll(0, [0.0, 0.0]);
    _operation = null;
    _bufferIndex = 0;
    _wipeValue = false;
  }

  double _calculate() {
    switch(_operation) {
      case '%': return _buffer[0] % _buffer[1];
      case '/': return _buffer[0] / _buffer[1];
      case 'x': return _buffer[0] * _buffer[1];
      case '-': return _buffer[0] - _buffer[1];
      case '+': return _buffer[0] + _buffer[1];
      default: return _buffer[0];
    }
  }
}