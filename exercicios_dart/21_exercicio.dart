main(){
  int a = 3;
  double b = 3.1;

  print('a = $a, b = $b');

  var c = 'Vc é muito legal';
  // c = 123; erro

  print(c is String); // true

  bool estaChovendo = true;
  bool estaFrio = false;

  print(estaChovendo || estaFrio); // true

  print('----------------');

  var nomes = ['Ana', 'Bia', 'Carlos'];
  print(nomes.length); // 3
  nomes.add('Daniel');
  nomes.add('Daniel');
  nomes.add('Daniel');
  print(nomes.length); // 6
  print(nomes.elementAt(0)); // Ana
  print(nomes[5]); // Daniel

  //A lista também tem o método fold.

  print('----------------');

  Set<int> conjunto = {0, 1, 2, 3, 4, 4, 4};
  print(conjunto.length); // 5
  print(conjunto is Set); // true

  //No caso do set, a função reduce é a função fold,
  //e essa função recebe 2 parâmetros, o valor inicial
  //e a callback do reduce.
  print(conjunto.fold<int>(8, (acumulador, atual) => acumulador + atual)); // 18

  print('----------------');

  Map<String, double> notasDosAlunos = {
    'Ana': 9.7,
    'Bia': 9.2,
    'Carlos': 7.8
  };

  for (var chave in notasDosAlunos.keys){
    print('chave = $chave');
  }

  for (var valor in notasDosAlunos.values){
    print('valor = $valor');
  }

  for (var registro in notasDosAlunos.entries){
    print(registro);
    print('${registro.key} = ${registro.value}');
  }

  print('----------------');

  dynamic x = 'Teste';
  x = 123;
  x = false;
  print(x);

  print('----------------');

  const constante = 3;
  // constante = 2; erro
  final constanteFinal = 5;
  // constanteFinal = 8; erro

  print(constante);
  print(constanteFinal);
}