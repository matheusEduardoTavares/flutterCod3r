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
              onPressed: () async {
                var isDeleteProduct = await showGeneralDialog<bool>(
                  context: context,
                  barrierDismissible: true,
                  barrierLabel: 'Sair',
                  pageBuilder: (_, __, ___) => AlertDialog(
                    title: Text('Excluir produto'),
                    content: Text('Realmente deseja excluir o produto ${product.title} ?'),
                    actions: [
                      FlatButton(
                        child: Text('CANCELAR'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }
                      ),
                      FlatButton(
                        child: Text('EXCLUIR'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        }
                      ),
                    ],
                  )
                );

                if (isDeleteProduct != null && isDeleteProduct) {
                  Provider.of<Products>(context, listen: false).deleteProduct(product.id);
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        )
      )
    );
  }
}