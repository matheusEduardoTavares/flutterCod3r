main() {
  int r1 = soma(7, 3);
  print(r1);

  ///Para conseguir obter o resultado de uma future, 
  ///precisamos usar o then ou o async await.
  ///Podemos ir encadeando os then
  print('antes');
  somaDoFuturo(70, 30)
    .then((r2) {
      print(r2);
      return r2 * 2;
    })
    .then((r3) {
      return r3 * 10;
    })
    .then((r4) {
      return r4 / 5;
    })
    ///Caso aconteça algum erro no then podemos usar o 
    ///[catchError] para capturar o erro e poder 
    ///tratá-lo
    .catchError((err) {
      print('error');
    })
    .then((value) => print(value));
  print('depois');
  ///Resultado:
  ///10
  ///antes
  ///depois
  ///100
  ///400.0
}

int soma(int a, int b) {
  return a + b;
}

Future<int> somaDoFuturo(int a, int b) {
  ///Passamos para o [Future] uma função que será executada
  ///apenas no momento que estivermos criando o [Future]
  return Future(() {
    return a + b;
  });
}