class Cliente {
  String nome;
  String cpf;

  Cliente({this.nome, this.cpf});

  @override
  String toString(){
    return nome;
  }
}