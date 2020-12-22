class Pessoa2 {
  String nome;
  String _cpf;

  //O String é opcional
  String get cpf{
    return _cpf;
  }

  //O void é opcional
  void set cpf(String cpf){
    _cpf = cpf;
  }
}