main(){
  //O método reduce pode transformar uma lista em 
  //qualquer outra coisa.

  var notas = [7.3, 5.4, 7.7, 8.1, 5.5, 4.9, 9.1, 10.0];

  //Como seria feito manualmente a soma de todas as 
  //notas:

  var totalManual = 0.0;

  for(var nota in notas){
    totalManual += nota;
  }

  print(totalManual); //58.0

  //------------------------------------------------

  var total = notas.reduce(somar);
  print(total);

  var nomes = ['Ana', 'Bia', 'Carlos', 'Daniel', 'Maria', 'Pedro'];
  print(nomes.reduce(juntar));
}

// var somaNotas = notas.reduce((total, notaAtual) => total + notaAtual);

double somar(double acumulador, double elemento){
  print("$acumulador $elemento");
  // 7.3 5.4
  // 12.7 7.7
  // 20.4 8.1
  // 28.5 5.5
  // 34.0 4.9
  // 38.9 9.1
  // 48.0 10.0
  // 58.0
  return acumulador + elemento;
}

String juntar(String acumulador, String elementoAtual){
  print('$acumulador => ,$elementoAtual');
  return '$acumulador, $elementoAtual';
}