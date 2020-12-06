main() {

  //Temos os operadores prefix, que vem antes do 
  //operando (exemplo o -), os infix que vem no
  //meio entre dois operandos (exemplo o x + y)
  //e os posfix que vem depois (exemplo o ++).
  // Operadores Aritméticos (binário/infix)
  int a = 7;
  int b = 3;

  int resultado = a + b;
  print(resultado);
  print(a - b);
  print(a * b);
  print(a / b);
  print(a % b);
  print(33 % 2);
  print(34 % 2);
  print(a + b * a - b / a);

  // Operadores Lógicos
  bool ehFragil = true;
  bool ehCaro = false;

  print(ehFragil && ehCaro); // AND -> E
  print(ehFragil || ehCaro); // OR -> OU
  //No OU EXCLUSIVO, apenas um dos dois pode ser verdadeiro.
  print(ehFragil ^ ehCaro); // XOR -> OU EXCLUSIVO
  print(!ehFragil); // NOT -> NÃO - Unário/Prefix
  print(!!ehCaro); // Volta ao valor original

}