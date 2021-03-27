import 'package:flutter/material.dart';
import 'package:shop/application/application.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'product.dart';
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

  List<Product> _items = [];

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
      ///No [post] precisamos usar o [.json] na URL.
      '${Application.productsUrl}.json',
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
      ///No [get] precisamos colocar o [.json] na URL
      '${Application.productsUrl}.json',
    );

    Map<String, dynamic> data = json.decode(response.body);

    ///Esse [clear] evita a duplicação de produtos que 
    ///acontece caso seja trocado de rota (ido para outra
    ///página na [Drawer]) e volte para a rota com título 
    ///Loja, pois aí acaba adicionando duas vezes e acaba
    ///duplicando os produtos, e com o método [clear] 
    ///evitamos que isso aconteça porquê sempre é limpado a 
    ///loja para depois adicionar os produtos carregados
    _items.clear();

    ///Não é interessante usar o método forEach pois ele custa
    ///mais processamento que um for in por exemplo. Além disso
    ///o ideal é que no nosso model coloquemos os métodos 
    ///[toJson] e [fromJson] para fazer as conversões do que vem
    ///do backend para poder utilizar no mobile. Como estamos
    ///armazenando os valores com a tipagem correta no firebase,
    ///aqui a tipagem já estará correta também, o [price] já está 
    ///como double lá e o [isFavorite] já está como boolean, 
    ///enquanto os demais são Strings.
    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        );
      });

      notifyListeners();
    }

    ///É opcional colocar:
    //return Future.value();
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      ///Se encontrou o produto, vamos atualizá-lo. No [patch]
      ///também precisamos do [.json], porém para atualizar um
      ///item específico, precisamos da URL inteira, e através
      ///de route params passamos qual é o ID do produto que 
      ///será atualizado, e passamos como parâmetro nomeado o
      ///[body] que irá receber um JSON com os novos dados daquele
      ///produto. Aqui seria interessante usar o [toJson] que 
      ///deveria ser colocado no model
      await http.patch(
        '${Application.productsUrl}/${product.id}.json',
        ///Nesse caso ao alterar um produto não queremos salvar
        ///se ele é favorito ou não, fazemos isso em outras partes,
        ///mas aqui não importa.
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    ///Temos uma técnica chamada exclusão otimista. Podemos 
    ///refletir na interface gráfica a exclusão mesmo antes de
    ///no firebase termos a confirmação que o produto foi 
    ///excluído, e caso aconteça algum erro, voltamos o produto
    ///para lista e mostramos uma mensagem de erro para o 
    ///usuário.
    
    final index = _items.indexWhere((prod) => prod.id == id);

    if (index >= 0) {
      /*
        ///Exclusão usando a estratégia natural:
        final product = _items[index];

        ///Para o delete também precisamos do [.json] na URL e
        ///usar o route params para identificar o produto. Nesse
        ///caso do delete, diferente dos outros, não irá jogar uma
        ///exceção caso aconteça algum erro na hora de excluir
        final response = await http.delete(
          '${Application.productsUrl}/${product.id}.json'
        );

        ///Se o [statusCode] do response da requisição for >= a 400,
        ///significa que houve algum erro nela. O 400 é erro na 
        ///requisição e 500 é erro do lado do servidor. Já o status
        ///da família dos 200 significa bem sucedido.
        if (response.statusCode >= 400) {
          print('problema');
        }
        else {
          _items.remove(product);
          notifyListeners();
        }
      */

      ///Exclusão usando a estratégia de exclusão otimista:
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        '${Application.productsUrl}/${product.id}.json'
      );

      if (response.statusCode >= 400) {
        ///Aí aqui podemos lançar uma excecão para que essa 
        ///exceção seja tratada na aplicação e essa informação
        ///seja mostrada.
        _items.insert(index, product);
        notifyListeners();
        ///Agora aqui iremos lançar nossa exceção personalizada:
        throw HttpException('Ocorreu um erro na exclusão do produto');
      }
    }
  }
}