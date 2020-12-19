class Data {
  int dia;
  int mes;
  int ano;

  //Função dentro de uma classe é chamada de 
  //MÉTODO.
  String obterFormatada(){
    return '$dia/$mes/$ano';
  }

  String toString(){
    return obterFormatada();
  }
} 

main(){
  var dataAniversario = new Data();
  dataAniversario.dia = 3;
  dataAniversario.mes = 10;
  dataAniversario.ano = 2020;
  String d1 = dataAniversario.obterFormatada();

  Data dataCompra = Data();
  dataCompra.dia = 23;
  dataCompra.mes = 12;
  dataCompra.ano = 2021;

  // A data do aniversário é 3/10/2020
  print('A data do aniversário é $d1');
  // A data da compra é 3/10/2020
  print('A data da compra é ${dataCompra.obterFormatada()}');

  print(dataCompra); //23/12/2021
  //Caso o parâmetro passado para o print não seja
  //uma string, o próprio print chama o método
  //toString para o parâmetro.
  print(dataCompra.toString()); //23/12/2021

  Data d2 = dataCompra;
  String s1 = dataCompra.toString();

  print(d2); //23/12/2021
  print(s1); //23/12/2021
}