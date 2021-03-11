import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products.dart';
import '../providers/product.dart';
import '../utils/app_routes.dart';

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
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                ///Precisamos marcar o [listen] false aqui pois ele
                ///não está sendo usado no build, e sim dentro de um
                ///widget. Não precisamos esperar as mudanças, então
                ///sem o [listen] false dá erro que não está na tree
                ///tal produto
                Provider.of<Products>(context, listen: false).deleteProduct(product.id);
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        )
      )
    );
  }
}