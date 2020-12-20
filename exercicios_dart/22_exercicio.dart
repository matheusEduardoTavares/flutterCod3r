// int soma(int a, int b){
//   return a + b;
// }

void soma(int a, int b){
  print(a + b);
}

int soma2(int a, int b, int Function(int, int) fn){
  return fn(a, b);
}

void main(List<String> args){
  // final r = soma(2, 3);
  // print('O valor da soma é: $r');

  soma(2, 3);

  final r = soma2(20, 30, (a, b) => a * b + 100);

  print('O resultado é $r!!!!!!');
}