main(){

  int a = 3;
  int b = 4;

  // Operadores Unários
  a++; // Postfix
  print(a);//4

  --a; // Prefix
  print(a);//3

  print(a++ == --b); //true
  print(a == b); //false

  // Operador Lógico Unário (NOT)
  print(!true);//false
  print(!false);//true

  bool x = false;
  print(!x);//true
}