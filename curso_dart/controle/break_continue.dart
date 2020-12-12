void main(List<String> args){
  for (int a = 0; a < 10; a++){
    if (a == 6) {
      break;
    }
    print(a);
  }

  print('Depois do laço for #01');

  for (int a = 0; a < 10; a++){
    if (a % 2 == 1) {
      continue;
    }
    print(a);
  }

  print('Depois do laço for #02');

  //Temos também os rotulados,
  //que são estruturas que lembram o
  //paradigma não estruturado.
  //Não é uma boa prática usar o 
  //break e o continue rotulad.
}