class Data {
  int dia;
  int mes;
  int ano;

  void obterFormatada(){
    print('$dia/$mes/$ano');
  }
} 

main(){
  var dataAniversario = new Data();
  dataAniversario.dia = 3;
  dataAniversario.mes = 10;
  dataAniversario.ano = 2020;

  print(dataAniversario); //Instance of 'Data'
  dataAniversario.obterFormatada(); // 3/10/2020
  // print('${dataAniversario.dia}/${dataAniversario.mes}/${dataAniversario.ano}'); //3/10/2020

  print('---------------------------------');

  Data dataCompra = Data();
  dataCompra.dia = 23;
  dataCompra.mes = 12;
  dataCompra.ano = 2021;
  print(dataCompra); //Instance of 'Data'
  dataCompra.obterFormatada(); // 23/12/2021
  // print('${dataCompra.dia}/${dataCompra.mes}/${dataCompra.ano}'); //23/12/2021
}