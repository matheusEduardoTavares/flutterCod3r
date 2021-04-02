import 'package:flutter/material.dart';
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/providers/auth.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/app_routes.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  final bool showDialogOnFavoriteUpdateError;

  ProductGridItem({
    this.showDialogOnFavoriteUpdateError = true,
  });

  void _showFavoriteChangeError(BuildContext context, ScaffoldState scaffoldState, String errorMessage) {
    if (showDialogOnFavoriteUpdateError) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Erro'),
          content: Text(errorMessage),
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
      scaffoldState.showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context, listen: false);
    final Cart cart = Provider.of<Cart>(context, listen: false);
    final _scaffoldState = Scaffold.of(context);
    final auth = Provider.of<Auth>(context, listen: false);

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
          ///Essa é uma forma de buscar imagens da internet e
          ///tratar enquanto está carregando usando a lib
          ///[transparent_image] para usar o [kTransparentImage],
          ///como [placegolder] do [FadeInImage.memoryNetwork], e
          ///esse [FadeInImage] faz uma animação que inicialmente
          ///é mostrado a imagem do [placeholder] que no caso é 
          ///uma imagem com opacidade 1, ou seja, transparente, e
          ///aí assim que carrega a imagem da URL, é feito um 
          ///efeito de escurecimento até a imagem aparecer por
          ///completo. Aqui conseguimos definir as características
          ///do efeito e também tratar para quando der erro de 
          ///buscar a imagem da internet, podendo mostrar outro 
          ///widget
          // child: FadeInImage.memoryNetwork(
          //   image: product.imageUrl,
          //   fit: BoxFit.cover,
          //   placeholder: kTransparentImage,
          //   imageErrorBuilder: (_, __, ___) => Center(
          //     child: Text('Erro ao carregar a imagem'),
          //   ),
          // ),
          ///Outra forma de fazer isso:
          ///Usaremos a animação chamada Hero para que ao clicar
          ///em uma imagem, a mesma cresça até ocupar a tela 
          ///inteira, é uma animação de transição, e já temos 
          ///um widget para isso chamado [Hero], e então basta 
          ///fazer um wrap do [FadeInImage] com este [Hero]. 
          ///Esse widget [Hero] pede uma [tag] que é um 
          ///identificador. Agora no destino, onde a imagem 
          ///será mostrada, também teremos outro widget
          ///[Hero] que deve ter a mesma [tag], de forma que 
          ///o Flutter entender que a animação começa aqui e 
          ///finaliza lá devido ao fato da [tag] ser igual nos
          ///dois widgets.
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              ///Passamos para o [placeholder] um [ImageProvider],
              ///então não pode ser o [Image.asset], temos que usar
              ///o [NetworkImage], ou no caso o [AssetImage]
              placeholder: AssetImage(
                'assets/images/product-placeholder.png'
              ),
              ///O [image] também recebe um [ImageProvider]. Aqui
              ///ao invés de usar o [Image.network], usaremos o 
              ///[NetworkImage]
              image: NetworkImage(
                product.imageUrl,
              ),
              fit: BoxFit.cover,
              imageErrorBuilder: (_, __, ___) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'ERRO', style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: ' ao carregar a imagem',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ]
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                try {
                  await product.toggleFavorite(auth.token, auth.userId);
                }
                on HttpException catch (e) {
                  _showFavoriteChangeError(
                    context,
                    _scaffoldState,
                    e.toString()
                  );
                }
                catch (e) {
                  _showFavoriteChangeError(
                    context,
                    _scaffoldState,
                    'Ocorreu um erro ao trocar a favoritação. Contate um administrador.'
                  );
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