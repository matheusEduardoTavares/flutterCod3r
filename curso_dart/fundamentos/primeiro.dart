/*
main() {
  //Nesse exemplo temos 3 sentenças de código, de forma
  //que a primeira, do primeiro print ocupa 3 linhas mas
  //é uma única sentença. O fim de uma sentença é marcado
  //pelo ;
  print(
  'Olá Dart!'
  );
  
  print('Olá Dart!');
  print('Olá Dart!');
}
*/

/*
main(){
  //Agora temos 2 sentenças de código em uma mesma linha:
  print('Olá Dart!');print('Olá Dart!');
}
*/

//Blocos são conjuntos de sentenças de códigos, definido pelas
//chaves.

//Nesse exemplo abaixo, temos 2 sentenças de código e 
//2 blocos de códigos. Se executado ambos os prints
//serão executados normalmente.
/*
main()
{
  print('Olá Dart!');

  //Podemos por um bloco dentro de outro:
  {
    print('Fim!');
  }
}
*/

//Executa ambos os prints:
/*
main()
{
  print('Olá Dart!');

  if (true){
    print('Fim!');
  }
}
*/

//Executa apenas um print:
/*
main()
{
  print('Olá Dart!');
  if (false) {
    print('Fim!');
  }
}
*/

//A porta de entrada de um programa dart é a estrutura main,
//tanto que se tivermos apenas a estrutura abaixo, será
//gerado o seguinte erro:
//Dart_LoadScriptFromKernel: The binary program does not contain 'main'.

/*
teste(){
  print('Olá Dart!');
}
*/

//Podemos usar aspas duplas ou simples para strings:
/*
main(){
  print('Olá Dart!');
  print('Até o próximo exercício!!!');
}
*/

//O método main pode receber uma lista como parâmetro. Isso
//é usado quando vamos executar o programa a partir da 
//linha de comando, por exemplo, se executarmos esse arquivo
//assim: dart primeiro.dart arg1 arg2 , então o print(args);
//resultará em: [arg1, arg2]
main(List args){
  print('Olá Dart!');
  print(args);
}