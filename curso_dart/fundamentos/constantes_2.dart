main(){

  final lista = ['Ana', 'Lia', 'Gui'];
  //A lista é uma constante, mas o conteúdo da lista não
  //Não podemos trocar o endereço de memória dessa lista
  //mas podemos alterar seus elementos internamente sem
  //problema.
  // lista.add('Rebeca');

  //Sendo uma constante, isso daria erro:
  //Pois estamos atribuindo outra lista, outro endereço de
  //memória.
  // lista = ['Banana', 'Maçã'];

  print(lista);//[Ana, Lia, Gui]

  //Para evitar que o conteúdo seja alterado de uma
  //lista, temos que definir a lista como const, ou seja, 
  //tem que ter exatamente aqueles valores definidos antes
  //da execução, exemplo:
  var lista2 = const ['Ana', 'Lia', 'Gui'];
  //Temos um valor literal constante que não pode ser alterado.
  //lista2.add("teste"); //Isso gera a exceção:
  //Unsupported operation: Cannot add to an unmodifiable list
  //Independente de lista2 ser final, const ou uma variável,
  //não poderemos modificar a lista que ele possui caso ela
  //seja const como nesse caso. Mas claro que se lista2 for
  //uma variável, aí podemos atribuir qualquer outro valor
  //a lista2 inclusive uma outra lista, que seria outro
  //endereço de memória, só não podemos modificar a lista
  //que é marcada como const
  // lista2.add("Erro"); >> Gera um erro
  lista2 = ['Banana', 'Maçã'];
  print(lista2);//[Banana, Maçã]

  const lista3 = ['Ana', 'Lia', 'Gui'];
  //Nesse caso em que o lista3 é uma const, também não é
  //possível alterar a lista, pois seus valores tanto 
  //de memória quanto internos devem ser conhecidos em 
  //tempo de compilação
  //lista3.add("Erro"); >> Gera um erro
  //Gera a mesma exceção
  print(lista3);//[Ana, Lia, Gui]

  //Resumindo:
  //Uma lista não pode ser alterada internamente apenas se
  //a variável que recebe a lista é uma const, como em lista3,
  //ou se a lista em si é marcada como const.
}