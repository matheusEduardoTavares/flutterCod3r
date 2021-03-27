import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/app_routes.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  final bool showDialogOnFavoriteUpdateError;

  ProductGridItem({
    this.showDialogOnFavoriteUpdateError = true,
  });

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    final _scaffoldState = Scaffold.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.PRODUCT_DETAIL,
            arguments: product
          );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                try {
                  await product.toggleFavorite();
                }
                catch (e) {
                  if (showDialogOnFavoriteUpdateError) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Erro'),
                        content: Text(e.toString()),
                        actions: [
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop()
                          ),
                        ],
                      )
                    );
                  }
                  else {
                    _scaffoldState.showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                }
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Produto adicionado com sucesso!',
                  ),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    }
                  )
                )
              );

              cart.addItem(product);
            },
          )
        ),
      ),
    );
  }
}