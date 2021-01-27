import 'package:flutter/foundation.dart';
// o 'package:flutter/foundation.dart'; ou o
//'package:meta/meta.dart'; podem nos prover o
//decorator @required


//Faremos um mixin com a classe Product também para
//poder ficar alternando se o produto é favorito ou 
//não.
class Product with ChangeNotifier{
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

//Faz sentido usarmos as imagens dentro
//da pasta de assets quando referenciamos
//uma imagem que não muda na aplicação, como
//a logo, mas no caso das imagens de produtos,
//como estamos sempre cadastrando e removendo
//produtos essas imagens serão imagens na rede,
//por isso iremos armazenar apenas a URL da
//imagem e não a imagem propriamente dita.