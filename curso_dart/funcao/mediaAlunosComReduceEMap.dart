main(){
  var alunos = [
    {'nome': 'Alfredo', 'nota': 9.9},
    {'nome': 'Wilson', 'nota': 9.3},
    {'nome': 'Mariana', 'nota': 8.7},
    {'nome': 'Guilherme', 'nota': 8.1},
    {'nome': 'Ana', 'nota': 7.6},
    {'nome': 'Ricardo', 'nota': 6.8}
  ];

  double Function(Map) todasNotas = (aluno) => aluno['nota'];
  double Function(double, double) mediaTurma = (nota1, nota2) => nota1 + nota2;

  var mediaAlunos = alunos
    .map(todasNotas)
    .reduce(mediaTurma) 
    / alunos.length;

  print(mediaAlunos);
}