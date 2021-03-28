class AuthException implements Exception {
  ///A ideia para esse tratamento que estamos fazendo é que 
  ///seja passada uma chave do erro que é retornado do firebase,
  ///e podemos pegar esses erros de sua DOC, e aí mapeamos ele
  ///na variável [errors] mostrando assim uma mensagem 
  ///para o usuário. No caso do firebase, quando fazemos uma 
  ///requisição e ela falha, é retornado um map que contém a 
  ///chave `error` e dentro dela temos outro map com as chaves
  ///`code`, `message` e `errors`, sendo o status code, a mensagem
  ///de erro que é as keys do map [errors] que estamos mapeando e
  ///um array que contém maps sobre o erro, respectivamente, então
  ///é só dar um throw nesse [AuthException] passando para ele 
  ///o resultado do [response['error']['message']].
  const AuthException(
    this.key,
  );

  final String key;
  ///Colocaremos aqui uma série de erros que já estão documentados
  ///no firebase
  static const Map<String, String> errors = {
    "EMAIL_EXISTS": "E-mail já existe!",
    "OPERATION_NOT_ALLOWED": "Operação não permitida!",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Tente mais tarde!",
    "EMAIL_NOT_FOUND": "E-mail não encontrado!",
    "INVALID_PASSWORD": "Senha inválida!",
    "USER_DISABLED": "Usuário desativado!",
  };

  @override 
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    }

    return 'Ocorreu um erro na autenticação!';
  }
}