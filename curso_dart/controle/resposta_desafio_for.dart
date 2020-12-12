void main(){
  String valor = '#';
  for(int i = 0; i < 6; i++){
    print(valor);
    valor += '#';
  }

  print('-------------------');

  for(var valor = '#'; valor != '#######' ; valor += '#'){
    print(valor);
  }
}