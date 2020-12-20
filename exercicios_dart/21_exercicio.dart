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

  //Os 3 principais métodos de estruturas iteráveis
  // são o map, reduce e filter. A API do dart não
  //disponibiliza a possibilidade de passar um 
  //valor inicial para o método reduce, passando
  //apenas a callback como parâmetro. Porém, 
  //tem-se o método fold, que é igualzinho ao
  //reduce mas sendo obrigatório passar um 
  //valor inicial como parâmetro. Tanto a 
  //lista quando o set possuem os 3 métodos e
  //também o método fold.

  var nomes = ['Ana', 'Bia', 'Carlos'];
  print(nomes.length); // 3
  nomes.add('Daniel');
  nomes.add('Daniel');
  nomes.add('Daniel');
  print(nomes.length); // 6
  print(nomes.elementAt(0)); // Ana
  print(nomes[5]); // Daniel

  print('----------------');

  Set<int> conjunto = {0, 1, 2, 3, 4, 4, 4};
  print(conjunto.length); // 5
  print(conjunto is Set); // true

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