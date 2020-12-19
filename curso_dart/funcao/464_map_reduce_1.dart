void main(List<String> args){
  //No map sempre teremos no fim uma lista de mesmo
  //tamanho, mesmo length. Ela mapeia um elemento em
  //outro elemento.

  //Nesse cado a inferência determina:
  //List<Map<String, Object>>
  var alunos = [
    {'nome': 'Alfredo', 'nota': 9.9},
    {'nome': 'Wilson', 'nota': 9.3},
    {'nome': 'Mariana', 'nota': 8.7},
    {'nome': 'Guilherme', 'nota': 8.1},
    {'nome': 'Ana', 'nota': 7.6},
    {'nome': 'Ricardo', 'nota': 6.8}
  ];

  String Function(Map) pegarApenasONome = (aluno) => aluno['nome'];
  int Function(String) qtdeDeLetras = (texto) => texto.length;
  int Function(int) dobro = (numero) => numero * 2;

  var nomes = alunos.map(pegarApenasONome);
  print(nomes); //(Alfredo, Wilson, Mariana, Guilherme, Ana, Ricardo)

  var quantidadesDeLetras = nomes.map(qtdeDeLetras); 

  print(quantidadesDeLetras); //(7, 6, 7, 9, 3, 7)

  //Ou:
  var quantidadesDeLetras2 = alunos 
    .map(pegarApenasONome)
    .map(qtdeDeLetras);

  print(quantidadesDeLetras2); //(7, 6, 7, 9, 3, 7)

  var multiplicarQuantidadeDeLetrasPorDois
     = quantidadesDeLetras2.map(dobro);

  print(multiplicarQuantidadeDeLetrasPorDois); //(14, 12, 14, 18, 6, 14)

}