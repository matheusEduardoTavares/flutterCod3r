import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    //ClipRoundedRectangle, é um widget cujo nome
    //quer dizer que vai cortar fora uma parte do
    //arredondamento de um retângulo
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
         child: GestureDetector(
           onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_DETAIL,
              arguments: product
            );

            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ProductDetailScreen(product)
            //   ),
            // );
           },
           child: Image.network(
             product.imageUrl,
             //O cover faz com que toda área 
             //do tile seja coberta pela imagem, que
             //era o childAspectRatio que 
             //colocamos 3/2, ou seja, proporção de
             //1.5 em relação da largura com a altura.
             fit: BoxFit.cover,
           ),
         ),
         footer: GridTileBar(
           backgroundColor: Colors.black87,
           leading: IconButton(
             icon: Icon(Icons.favorite),
             onPressed: () {},
             color: Theme.of(context).accentColor,
           ),
           title: Text(
             product.title,
             textAlign: TextAlign.center,
           ),
           trailing: IconButton(
             icon: Icon(Icons.shopping_cart),
             onPressed: () {},
             color: Theme.of(context).accentColor,
           )
         ),
      ),
    );
  }
}