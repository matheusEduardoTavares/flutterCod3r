class Data {
  int dia;
  int mes;
  int ano;

  obterFormatada(){
    print('$dia/$mes/$ano');
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
  String d2 = dataCompra.obterFormatada();

  //A data do aniversário é null
  print('A data do aniversário é $d1');
}