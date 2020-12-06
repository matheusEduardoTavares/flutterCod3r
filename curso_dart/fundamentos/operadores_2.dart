main(){

  // Operadores de Atribuição (binário/infix)
  double a = 2;
  a = a + 3;
  a += 3;

  print(a);// 8.0
  
  a -= 3;
  a *= 3;
  print(a);// 15.0

  a /= 5;
  print(a);// 3.0

  a %= 2;
  print(a);// 1.0
  
  // Operadores Relacionais (binário/infix) -> O resultado
  //sempre é BOOL

  print(3 > 2);//true
  print(3 >= 3);//true
  print(3 < 4);//true
  print(3 <= 3);//true
  print(3 != 3);//false
  print(3 == 3);//true
  print(3 == '3');//false

  print(2 + 5 > 3 - 1 && 4 + 7 != 7 - 4);//true

  //Operação bit a bit:
  //5 em binário é: 101
  //4 em binário é: 100
  //Assim é feito uma operação de AND em cima dos 0 e 1
  //Exemplo:
  //101 & 100 , primeiro pega o último digito de cada número,
  //1 and 0 e isso retorna 0, depois o segundo dígito de cada
  //número que é 0 and 0 que dá 0, e por fim o primeiro dígito,
  //1 and 1 que dá 1, resultando em 100, e como 100 é 4, o 
  //resultado final de 5 & 4 será 4
  print(5 & 4); //4
  
}