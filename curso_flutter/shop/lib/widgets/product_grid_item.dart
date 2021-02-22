import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/app_routes.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);

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
              onPressed: () {
                product.toggleFavorite();
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
              ///Agora ao adicionar um item no carrinho queremos
              ///mostrar um [SnackBar] mostrando que tal item
              ///foi adicionado ao carrinho. No [SnackBar] iremos
              ///dar a opção para alterar a última ação realizada,
              ///através de um botão, então se foi 
              ///adicionado um novo item no carrinho, ao clicar
              ///nesse botão aquele item será removido, e se 
              ///aumentou a quantidade de um produto que já 
              ///estava no carrinho, ao clicar no botão, a 
              ///será retirar essa adição.
              ///
              ///Para acessar a tela atual, podemos usar o 
              ///`Scaffold.of(context)`, pois será buscado na 
              ///hierarquia até achar o primeiro Scaffold, que no
              ///caso é o que está em [products_overview_screen.dart].
              ///E nessa tela com o Scaffold iremos adicionar na parte
              ///inferior da tela a Snackbar.
              ///
              ///Um exemplo é que podemos abrir a [Drawer] caso o 
              ///primeiro Scaffold encontrado tiver uma [Drawer], 
              ///ao clicar no botão:
              // Scaffold.of(context).openDrawer();

              ///Para não ter problema de ao clicar rapidamente
              ///em adicionar vários itens ficar vindo uma snack
              ///bar em cima da outra já que a anterior não some
              ///até acabar seu duration, vamos programar para 
              ///que ao clicar em adicionar um novo item, caso 
              ///já esteja aparecendo uma SnackBar ela seja 
              ///escondida
              
              Scaffold.of(context).hideCurrentSnackBar();

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  ///O content do SnackBar geralmente colocamos
                  ///uma mensagem para notificar o usuário
                  content: Text(
                    'Produto adicionado com sucesso!',
                    ///Nesse caso não queremos mas é possível 
                    ///alinhar o texto como quisermos
                    // textAlign: TextAlign.center,
                  ),
                  ///O tempo que o SnackBar deve ficar aparecendo
                  ///antes de sumir
                  duration: Duration(seconds: 2),
                  ///A action de um SnackBar recebe uma 
                  ///SnackBarAction que é outro Widget, e 
                  ///geralmente aqui temos um botão para desfazer
                  ///o que foi feito
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