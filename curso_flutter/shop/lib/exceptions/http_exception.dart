///Uma vez implementando [Exception] teremos que
///implementar todos os métodos que eventualmente sejam
///abstratos, já que o [Exception] é uma classe abstratas.
///Mas nesse caso específico o [Exception] não possui métodos
///abstratos. Dentro da exceção podemos por exemplo controlar
///os status.
class HttpException implements Exception {
  final String msg;

  const HttpException(this.msg);

  @override 
  String toString() {
    return msg;
  }
}