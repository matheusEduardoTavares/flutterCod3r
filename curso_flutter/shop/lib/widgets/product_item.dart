import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/providers/products.dart';
import '../providers/product.dart';
import '../utils/app_routes.dart';

class ProductItem extends StatelessWidget {

  ProductItem(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold.of(context);

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
                  try {
                    await Provider.of<Products>(context, listen: false)
                      .deleteProduct(product.id);
                  }
                  ///Podemos tratar exceções de forma específica com o [on],
                  ///e passando qual tipo queremos tratar, aí o [catch]
                  ///para esse caso é opcional e só o passamos caso queiramos
                  ///pegar algum detalhe do erro
                  on HttpException catch (error) {
                    ///Por ser um método assíncrono, não conseguimos 
                    ///carregar o [context] aqui, portanto, não 
                    ///conseguimos mostrar uma snackBar aqui diretamente
                    ///com o [Scaffold.of(context)], então iremos
                    ///armazenar o [Scaffold.of(context)] em uma 
                    ///variável dentro do build, para apenas 
                    ///acessá-la aqui usando o [showSnackBar]
                    // Scaffold.of(context)
                    //   .showSnackBar(
                    //     SnackBar(
                    //       duration: Duration(seconds: 3),
                    //       content: Text('Erro ao excluir o produto'),
                    //       action: SnackBarAction(
                    //         onPressed: () {},
                    //         label: 'OK'
                    //       ),
                    //     ),
                    //   );
                    _scaffold
                      .showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                        ),
                      );
                  }
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