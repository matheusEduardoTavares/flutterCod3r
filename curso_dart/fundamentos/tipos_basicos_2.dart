/*
  - List
  - Set
  - Map
*/
main(List<String> args){

  List aprovados = ['Ana', 'Carlos', 'Daniel', 'Rafael'];
  var aprovados2 = ['Ana', 'Carlos', 'Daniel', 'Rafael'];
  //ambos são true:
  print(aprovados is List);
  print(aprovados2 is List);
  print(aprovados2); //[Ana, Carlos, Daniel, Rafael]

  print(aprovados2.elementAt(2)); //Daniel
  print(aprovados2[2]); //Daniel

  // print(aprovados[4]); > Erro pois não existe índice 4
  print(aprovados2.length); // 4

  aprovados2.add('Daniel');
  print(aprovados2.length); // 5

  //Usaremos no lugar do Map o var para ele fazer a inferência.
  //Nesse caso a inferência ficar melhor do que usar map e
  //entenderemos isso melhor quando vermos generics. Mas
  //usando Map<String, String> também não seria gerado 
  //nenhum warning, mas como veremos generics depois então
  //usaremos a inferência mesmo por enquanto.
  var telefones = {
    'João': '+55 (11) 98765-4321',
    'Maria': '+55 (21) 12345-6789',
    'Pedro': '+55 (85) 45455-8989',
    'João': '+55 (11) 77777-7777'
  };
  //Não é permitido repetição dentro da chave. Caso houver
  //repetição, irá permanecer a última chave (a última 
  //sobrescreve as anteriores)

  print(telefones is Map); //true
  print(telefones); //{João: +55 (11) 77777-7777, Maria: +55 (21) 12345-6789, Pedro: +55 (85) 45455-8989}
  print(telefones['João']); //+55 (11) 77777-7777
  print(telefones.length); //3
  print(telefones.values); //(+55 (11) 77777-7777, +55 (21) 12345-6789, +55 (85) 45455-8989)
  print(telefones.keys); //(João, Maria, Pedro)
  print(telefones.entries); //(MapEntry(João: +55 (11) 77777-7777), MapEntry(Maria: +55 (21) 12345-6789), MapEntry(Pedro: +55 (85) 45455-8989))

  //Set é um conjunto de valores que não precisam de uma
  //ordem pré-definida e não são indexados. Não há repetição
  //de valores dentro do set. Todas operações de conjuntos
  //são definidos dentro do set como união, intersecção, etc.
  var times = {'Vasco', 'Flamengo', 'Fortaleza', 'São Paulo'};
  //print(times[0]); Isso não é possível pois o set não é indexado
  print(times is Set); //true
  times.add('Palmeiras');
  times.add('Palmeiras');
  times.add('Palmeiras');
  //times.add(123); dá erro pois na linha 52 criamos um set 
  //apenas com elementos string, então a inferência assume
  //que temos um set de string > Set<String>
  //Caso na hora de criar o set colocamos dois tipos diferentes
  //a inferência criará um Set<Object> , sendo Object um tipo
  //mais genérico que suporta String, int, double, bool.
  //Se criamos apenas Set times , então por padrão o set
  //passa a set Set<dynamic> então poderia ser qualquer 
  //tipo dentro do set.
  print(times.length); // 5
  print(times.contains('Vasco')); //true
  print(times.first); //Vasco
  print(times.last); //Palmeiras

  //A lista aceita repetição, diferente do set.
  print(times); //{Vasco, Flamengo, Fortaleza, São Paulo, Palmeiras}

  //Todas essas estruturas vistas podem ser homogêneas ou
  //heterogêneas. O ideal é ter estruturas homogêneos.

}