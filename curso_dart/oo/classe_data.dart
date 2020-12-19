//Já existe uma classe no dart para data por default,
//mas iremos criar um só para exemplificar.

//Uma classe define um tipo personalizado, assim 
//como String, int etc
class Data {
  int dia;
  int mes;
  int ano;


  bool showToStringDefault;

  Data({this.dia, this.mes, this.ano, this.showToStringDefault});

  @override 
  String toString(){
    return showToStringDefault ?? true ?
      super.toString() : '$dia/$mes/$ano'; 
  }
}

main(){
  var dataAniversario = new Data();
  dataAniversario.dia = 3;
  dataAniversario.mes = 10;
  dataAniversario.ano = 2020;

  print(dataAniversario); //Instance of 'Data'
  dataAniversario.showToStringDefault = false;
  print(dataAniversario); //3/10/2020

  print('${dataAniversario.dia}/${dataAniversario.mes}/${dataAniversario.ano}'); //3/10/2020

  print('---------------------------------');

  //O new não é obrigatório
  Data dataCompra = Data(dia: 23, mes: 12, ano: 2021, showToStringDefault: false);
  print(dataCompra); //23/12/2021
  dataCompra.showToStringDefault = true;
  print(dataCompra); //Instance of 'Data'
  print('${dataCompra.dia}/${dataCompra.mes}/${dataCompra.ano}'); //23/12/2021
}