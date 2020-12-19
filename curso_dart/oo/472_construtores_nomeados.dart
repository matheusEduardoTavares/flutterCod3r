class Data {
  int dia;
  int mes;
  int ano;

  Data([this.dia = 1, this.mes = 1, this.ano = 1970]);

  //Construtor nomeado / Named Constructors:
  Data.com({this.dia = 1, this.mes = 1, this.ano = 1970});

  Data.ultimoDiaDoAno(this.ano) {
    dia = 31;
    mes = 12;
  }

  String obterFormatada(){
    return '$dia/$mes/$ano';
  }

  String toString(){
    return obterFormatada();
  }
} 

main(){
  var dataAniversario = new Data(3, 10, 2020);
  String d1 = dataAniversario.obterFormatada();

  Data dataCompra = Data(1, 1, 1970);
  // dataCompra.dia = 23;
  dataCompra.mes = 12;
  dataCompra.ano = 2021;

  print('A data do aniversário é $d1'); //A data do aniversário é 3/10/2020

  print('A data da compra é ${dataCompra.obterFormatada()}'); //A data da compra é 23/12/2021

  print(dataCompra); // 23/12/2021

  print(new Data()); // 1/1/1970
  print(Data(31)); // 31/1/1970
  print(Data(31, 12)); // 31/12/1970
  print(Data(31, 12, 2021)); // 31/12/2021

  print(Data.com(ano: 2022));

  var dataFinal = Data.com(dia: 12, mes: 7, ano: 2024);
  print('O Mickey será público em $dataFinal'); // 12/7/2024

  print(Data.ultimoDiaDoAno(2023)); // 31/12/2023
}