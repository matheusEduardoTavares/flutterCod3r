import 'package:flutter/material.dart';
import 'package:shop/utils/url_firebase.dart';
import 'product.dart';
import '../data/dummy_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Products with ChangeNotifier {

  ///Caso usemos um backend próprio a regra aqui muda, mas
  ///basicamente como queremos criar uma coleção chamada de 
  ///produtos e dentro conter todos os produtos lá no 
  ///realtime database do firebase, então precisamos usar
  ///a URL do banco e colocar no fim /[nome da entidade].json,
  ///o que não é padrão nas rotas de backends próprios, não 
  ///temos rotas com .json no fim, mas no caso do firebase
  ///essa é a regra. Assim o que passarmos no body da requisição
  ///de post será criado como itens de um atributo pai que 
  ///será esse [nome da entidade], que no nosso caso será
  ///products
  final _url = '${UrlFirebase.urlFirebase}/products.json';

  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items => List.from(_items);

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product newProduct) async {
    ///Esse é um bom local para colocarmos as chamadas 
    ///HTTP, pois é o provider do produto, toda lógica 
    ///relacionada a produtos está aqui. Até poderíamos
    ///criar uma outra classe e encapsular todas as chamadas
    ///HTTP em um único local, mas por enquanto iremos 
    ///colocar aqui.
    
    ///Agora iremos simular um erro para ver o que 
    ///irá acontecer e depois tratar o erro. Para simular
    ///o erro basta tirar o .json da variável [url].
    ///O erro é gerado no debug console com a seguinte
    //final url = '${UrlFirebase.urlFirebase}/products';
    ///mensagem:
    /*
      [ERROR:flutter/lib/ui/ui_dart_state.cc(177)] Unhandled Exception: FormatException: Unexpected character (at character 1)
      E/flutter (18142): append .json to your request URI to use the REST API.
      E/flutter (18142): ^
    */
    ///E a aplicação irá ficar aparecendo o 
    ///[CircularProgressIndicator] infinitamente, pois 
    ///o response nunca chegará. Não é uma experiência 
    ///agradável para a aplicação. 
    ///Iremos tratar para quando ocorrer um erro usando
    ///o método [catchError] que temos para o [then]. Outra
    ///possibilidade mas não boa é retornar uma string se
    ///tiver erro, e se não tiver retornar null e depois
    ///tratar onde esperamos a resposta da request.

    /*
    ///Usando o then:
    ///Recebemos aqui a URL
    return http.post(
      url,
      ///Precisamos do formato JSON no conteúdo que 
      ///passamos para a requisição
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite,
      }),
    ).then((response) {
      _items.add(
        Product(
          id: json.decode(response.body)['name'],
          title: newProduct.title,
          description: newProduct.description,
          price: newProduct.price,
          imageUrl: newProduct.imageUrl,
        ),
      );
      notifyListeners();

      ///Assim podemos retornar um Future vazio:
      // return Future.value();
      ///Mas não é isso que queremos pois esse return
      ///só será chamado depois de chegar a resposta do
      ///servidor, fazendo com que todo o método já 
      ///tivesse sido executado e assim o [Future] na
      ///função não faria sentido.
      ///O [catchError] adicionado aqui serviu apenas 
      ///como explicação, não precisamos dele aqui pois 
      ///é só capturar o erro na hora de chamar o método
      ///[addProduct].
    });
    */

    ///Com async e await:
    final response = await http.post(
      _url,
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite,
      }),
    );

    _items.add(
      Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
      ),
    );
    notifyListeners();

    /*
      .catchError((error) {
        print(error);

        ///Para não silenciar a requisição, iremos lançar
        ///ela com o [throw], relançando assim o erro, aí
        ///tratamos onde esse método [addProduct] é chamado
        throw error;
      });
    */

    // return Future.value();
    ///Não funciona colocar aqui também porquê esse
    ///código será executado por completo e iremos 
    ///retornar algo antes do [response] ter chegado.
    ///O ideal nesse caso é por um return antes do
    ///[http.post] pois será associado a todo o bloco, 
    ///de forma que um [Future] será retornado.
  }

  Future<void> loadProducts() async {
    final response = await http.get(
      _url,
    );
    print(json.decode(response.body));
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      _items.removeWhere((product) => product.id == id);

      notifyListeners();
    }
  }
}