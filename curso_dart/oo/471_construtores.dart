class Data {
  int dia;
  int mes;
  int ano;

  //Construtor padrão (que já existe implicitamente
  //tendo o mesmo nome da classe e sem receber 
  //nenhum parâmetro):
  // Data(){

  // }
  
  //Colocando nosso próprio construtor, faz que 
  //o construtor padrão deixe de existir.
  Data(int dia, int mes, int ano){
    //Se deixarmos apenas assim, fica tudo nulo, 
    //pois precisamos do this para separar o que é 
    //atributo e o que é parâmetro
    // dia = dia;
    // mes = mes;
    // ano = ano;
    //this é o objeto atual que está sendo criado no
    //momento que esse construtor foi chamado
    this.dia = dia;
    this.mes = mes;
    this.ano = ano;
  }

  //Dart não suporta sobrecarga de construtores.

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
  var dataAniversario = new Data(3, 10, 2020);
  String d1 = dataAniversario.obterFormatada();

  Data dataCompra = Data(1, 1, 1970);
  // dataCompra.dia = 23;
  dataCompra.mes = 12;
  dataCompra.ano = 2021;

  print('A data do aniversário é $d1'); //A data do aniversário é 3/10/2020

  print('A data da compra é ${dataCompra.obterFormatada()}'); //A data da compra é 23/12/2021

  print(dataCompra); // 23/12/2021

  
}