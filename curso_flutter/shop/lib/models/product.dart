import 'package:flutter/foundation.dart';
// o 'package:flutter/foundation.dart'; ou o
//'package:meta/meta.dart'; podem nos prover o
//decorator @required


class Product {
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
}

//Faz sentido usarmos as imagens dentro
//da pasta de assets quando referenciamos
//uma imagem que não muda na aplicação, como
//a logo, mas no caso das imagens de produtos,
//como estamos sempre cadastrando e removendo
//produtos essas imagens serão imagens na rede,
//por isso iremos armazenar apenas a URL da
//imagem e não a imagem propriamente dita.