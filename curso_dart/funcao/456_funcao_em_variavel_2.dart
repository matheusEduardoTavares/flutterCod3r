void main(List<String> args){
  //Nesse caso é retornado um set de um único número:
  //resultado de a + b
  var adicao = (int a, int b) => {
    a + b
  };

  print(adicao(4, 19)); //{23}
  print(adicao(4, 19) is Set); //true

  //Arrow Function
  var subtracao = (int a, int b) => a - b;
  var multiplicacao = (int a, int b) => a * b;
  var divisao = (int a, int b) => a / b;

  print(subtracao(9, 13));
  print(multiplicacao(9, 13));
  print(divisao(9, 13));
}