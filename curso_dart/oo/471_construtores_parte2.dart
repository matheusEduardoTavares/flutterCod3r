class Data {
  int dia;
  int mes;
  int ano;

  //Ao invés de ter que passar para cada atributo o 
  //valor do parâmetro no construtor na mão, é
  //possível definir para que o parâmetro já preencha
  //o atributo direto bastando usar o this no
  //recebimento dos parâmetros. Deixaremos os 
  //parâmetros opcionais também. Também podemos usar
  //parâmetros nomeados.
  Data([this.dia = 1, this.mes = 1, this.ano = 1970]);

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
}