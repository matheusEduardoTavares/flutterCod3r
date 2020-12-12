//Printe o seguinte resultado:
/*
#
##
###
####
#####
######
*/
//Use o laço FOR, mas não pode
//controlar o laço usando valor
//numérico !

main(){
  print('Exemplo 1:');
  for (String laco = '#'; laco != "#######"; laco += '#'){
    print(laco);
  }

  print('Exemplo 2:');
  for (String laco = '#'; laco.length < 7; laco += '#'){
    print(laco);
  }
}