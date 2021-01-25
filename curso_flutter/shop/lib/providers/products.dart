//Essa classe irá encapsular a lista dos produtos que 
//iremos compartilhar dentro da aplicação. Ela será 
//usado em vários componentes por isso está dentro 
//da pasta providers. Faremos um mixin com o 
//ChangeNotifier que está completamente relacionado com
//o observer. Quando uma mudança acontece (um evento 
//é disparado), ele notifica todos os interessados,
//em saberem quando um determinado valor foi 
//modificado. Quando um produto for excluído ou adicionado
//da lista, todos os interessados serão notificados, 
//por exemplo. Assim o componente que renderiza a 
//lista dos produtos na tela pode ser atualizado 
//quando for notificado de alguma mudança.
//Esse ChangeNotifier já é do flutter, não precisamos 
//importar nenhuma lib interna para tal a não ser o 
//import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';

class Products with ChangeNotifier{

  List<Product> _items = DUMMY_PRODUCTS;

  //Aqui no get não iremos querer retornar 
  //diretamente os itens pois, quando retornar 
  //os itens, estmaos retornando uma referência para
  //essa lista de produto. Se estamos retornando uma
  //referência para essa lista de produtos, significa
  //que uma vez que alguém pega a referência dessa lista
  //será capaz de alterar a lista de produtos, incluir
  //e excluir produtos por exemplo. Não queremos que 
  //o controle da lista seja perdido retornando sua
  //referência. Então é uma boa prática retornar uma 
  //cópia desses itens. Se alguém quiser adicionar 
  //ou deletar um produto terá que trabalhar com essa
  //classe Products, e não com a lista que é retornada
  //no getter.

  // List<Product> get items => [ ..._items ];
  List<Product> get items => List.from(_items);

  void addProduct(Product product) {
    //Aqui acabamos de mexer na lista de produtos. 
    //Isso representa um evento. Precisamos 
    //notificar todos os interessados em saberem 
    //a mudança que aconteceu. Por isso usamos o 
    //mixin do ChangeNotifier que tem um método 
    //chamado notifyListeners, e é nesse ponto 
    //que todos os interessados serão notificados.
    //Sempre que mudarmos algo dentro dessa classe 
    //chamaremos o notifyListeners para todos os 
    //interessados serem notificados.
    _items.add(product);
    notifyListeners();
  }
}