
import 'dart:io';

void main(List args){
  // Área da circunferência = PI * raio²

  //O dart é composto por várias bibliotecas. Precisaremos 
  //importar algumas dessas bibliotecas tanto para 
  //trabalhar em dart quanto para trabalhar em flutter
  
  //Temos a biblioteca do dart:io em que podemos usar o método
  //readLineSync que está dentro do objeto stdin que temos
  //acesso a partir do momento que importamos essa biblioteca
  //Ele servirá para pegarmos o que o usuário digita. O 
  //resultado sempre será uma string, então devemos 
  //converter caso queiramos outro tipo. 
  //Nesse caso abaixo, se executarmos pelo terminal esse
  //arquivo, devemos digitar algo e dar enter e isso que 
  //foi digitado será armazenado na variável texto.
  // String texto = stdin.readLineSync();
  // print("O valor digitado é: " + texto);

  //Além do final, temos o const para definir constantes.
  // final PI = 3.1415;
  const PI = 3.1415;
  //O final torna uma variável constante em tempo de 
  //execução. Já o const torna a variável constante em 
  //tempo de compilação, ou seja, são valores que podem ser
  //definidos antes do programa estar rodando, como é no
  //caso do PI, todas as demais variáveis que usamos abaixo,
  //são obrigadas a usar final pois dependem do valor digitado
  //pelo usuário que será obtido em tempo de execução.
  //De forma geral, constantes com const tem uma maior
  //otimização, do que com final.
  const x = 3;
  //isso é possível:
  const y = x * PI;
  //só não podemos criar um const a partir de um final
  //ou a partir de uma variável.

  // print("Informe o raio: ");
  //O print sempre dá um \n no fim, para printar na tela
  //sem dar um \n temos que usar o método write do 
  //stdout que também vem na importação do dart:io
  stdout.write("Informe o raio: ");
  final entradaDoUsuario = stdin.readLineSync();
  //final raio = double.parse(entradaDoUsuario);
  //Podemos ou não colocar o tipo também:
  final double raio = double.parse(entradaDoUsuario);

  final area = PI * raio * raio;

  print("O valor da área é: " + area.toString());
  //Dependendo do valor digitado o resultado pode ter
  //uma certa imprecisão, e isso é uma especificação de 
  //como é feito as operações de ponto flutuante. É a 
  //especificação do I3E, que permite essa imprecisão, pois
  //a forma de se fazer operações com ponto flutuante de 
  //forma 100% precisa, é ao menos 15 vezes mais lento que
  //usando esse formato com imprecisão, e muitas linguagens,
  //assim como dart, preferem usar essa imprecisão para 
  //ganhar mais velocidade.

}