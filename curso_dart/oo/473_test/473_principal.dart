//Import relativo:

//Sendo os 2 arquivos dentro da mesma pasta,
//funcionaria de ambas formas abaixo, pois 
//Se estiver dentro da mesma pasta, não precisa do 
// ./ no import
// import './473_pessoa.dart';
// import '473_pessoa.dart';

//Nesse caso que estamos com esse arquivo dentro da pasta
//test, e precisamos sair dele para acessar o arquivo
//473_pessoa.dart que está dentro da pasta model,então 
//usamos esse import:
import '../473_model/473_pessoa.dart';

void main(){
  var p1 = Pessoa();
  p1.nome = 'João';

  print('O nome da pessoa é: ${p1.nome}');
}