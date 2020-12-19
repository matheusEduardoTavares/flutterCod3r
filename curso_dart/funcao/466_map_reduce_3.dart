main(){
  var alunos = [
    {'nome': 'Alfredo', 'nota': 9.9},
    {'nome': 'Wilson', 'nota': 9.3},
    {'nome': 'Mariana', 'nota': 8.7},
    {'nome': 'Guilherme', 'nota': 8.1},
    {'nome': 'Ana', 'nota': 7.6},
    {'nome': 'Ricardo', 'nota': 6.8}
  ];

  //Se fizermos assim, pela inferência, será entendido
  //que a variável aluno que é cada um dos items 
  //que será iterado na lista de alunos, é do 
  //tipo Map<String, Object> , o String foi inferido
  //pois todas chaves são Strings, mas o valor será
  //inferido como Object, não como double. Então
  //no reduce, irá dar problema na hora de somar o 
  //acumulador com o atual, pois será dito que o 
  //operador + não está definido para Object.
  //Para resolver isso faremos outro map que irá 
  //converter a lista de notas como Object para 
  //a lista de notas double.
  // var total = alunos
  //   .map((aluno) => aluno['nota'])
  //   .reduce((t, a) => t + a); // ERRO

  var total = alunos
    .map((aluno) => aluno['nota'])
    // Basicamente tipamos que cada elemento nota
    //é double. Deixamos o roundToDouble para mostrar
    //apenas que é possível fazer algum tipo de 
    //tratamento.
    .map((nota) => (nota as double).roundToDouble())
    .reduce((t, a) => t + a);

  print("O valor da média é: ${total / alunos.length}");

  //Calculando a média APENAS dos alunos aprovados:
  var notasFinais = alunos
    .map((aluno) => aluno['nota'])
    .map((nota) => (nota as double).roundToDouble())
    .where((nota) => nota >= 8.5);
    
  var totalAprovados = notasFinais.reduce((t, a) => t + a);

  print("O valor da média dos aprovados é: ${totalAprovados / notasFinais.length}");
}