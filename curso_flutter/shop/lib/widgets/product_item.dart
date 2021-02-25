import 'package:flutter/material.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {

  ProductItem(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        ///Antes estávamos usando o Image.network, mas para
        ///o parâmetro [backgroundImage] do [CircleAvatar]
        ///precisamos de um [ImageProvider], e para tal
        ///usaremos o [NetworkImage], e se for um asset que 
        ///não é o caso é só usar o [AssetImage]
        backgroundImage: NetworkImage(
          product.imageUrl
        ),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {},
              color: Theme.of(context).errorColor,
            ),
          ],
        )
      )
    );
  }
}