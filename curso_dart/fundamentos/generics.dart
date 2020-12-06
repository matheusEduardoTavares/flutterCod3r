main(){
  print('Início');
  //Quando temos um erro de compilação, não será executado
  //nenhuma linha do programa.
  List<String> frutas = ['banana', 'maçã', 'laranja'];
  // frutas.add(123); //Erro de compilação
  //frutas[100]; //Erro de runtime, assim, chega a printar Início
  //e o erro só acontece quando chega nesta linha pois o 
  //compilador não sabe anteriormente, antes de executar
  //quantos elementos existem dentro de frutas.
  frutas.add('melão');
  print(frutas);

  Map<String, double> salarios = {
    'gerente': 19345.78,
    'vendedor': 16345.80,
    'estagiário': 600.00
  };

  print(salarios);

  //O nome generics não é atribuído nesses casos do ponto de
  //vista de quem usa uma classe genérica. Generics vem do 
  //ponto de vista de quem construíu a classe genérica, e
  //quando usamos especificamos essas variáveis genéricas
  //que foram criadas, pois por exemplo entrando no código do 
  //core, do Map, vemos que é um Map<K, V> , sendo K e V 
  //generics, e quando usamos estamos especificando quais 
  //são os atributos genéricos, por isso chamamos de generics
  //e não specific.

  //A melhor forma de usarmos as estruturas é especificar
  //os valores e garantir estruturas homogêneas. Isso torna
  //o código mais organizado.
  
}