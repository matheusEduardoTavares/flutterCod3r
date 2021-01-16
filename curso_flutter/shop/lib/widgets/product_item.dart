import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product);

  @override
  Widget build(BuildContext context) {
    return GridTile(
       child: Image.network(
         product.imageUrl,
         //O cover faz com que toda área 
         //do tile seja coberta pela imagem, que
         //era o childAspectRatio que 
         //colocamos 3/2, ou seja, proporção de
         //1.5 em relação da largura com a altura.
         fit: BoxFit.cover,
       ),
       footer: GridTileBar(
         backgroundColor: Colors.black87,
         leading: IconButton(
           icon: Icon(Icons.favorite),
           onPressed: () {}
         ),
         title: Text(
           product.title,
           textAlign: TextAlign.center,
         ),
         trailing: IconButton(
           icon: Icon(Icons.shopping_cart),
           onPressed: () {}
         )
       ),
    );
  }
}