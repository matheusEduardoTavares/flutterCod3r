import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Aqui no product Provider.of, podemos passar um
    //segundo atributo além do context, que é o 
    //listen, que recebe uma booleana e a 
    //iniciaremos como true. Ele serve para o seguinte:
    //quando pegamos um elemento a partir do Provide.of,
    //que é um ChangeNotifier, significa que esse 
    //ChangeNotifier vai notificar sempre que houver
    //uma mudança dentro dele. Quando ao pegar o 
    //valor que está nesse provider, e passamos o 
    //listen: true para ele, estamos dizendo que 
    //queremos continuar escutando as mudanças do
    //elemento, que no caso é o produto. Sempre que 
    //mudar algo queremos ser notificados para poder 
    //atualizar o componente. É o que acontece quando
    //clicamos para favoritar um produto, muda o seu
    //estado, já que um produto é um ChangeNotifier.
    //O true é o padrão, agora, quando mudamos o 
    //listen para false, paramos de escutar essas 
    //alterações, paramos de ser notificados, deixando
    //como false ao favoritar/desfavoritar um produto,
    //não veremos as mudanças devido a isso. Iremos 
    //usar o listen como false quando recebemos um 
    //ChangeNotifier via provider e estivermos usando
    //apenas atributos que são final, que não mudam,
    //então se pegamos algo do provider, mas só usamos
    //informações que não são alteráveis, então 
    //não faz sentido deixar o listen: true. Tem
    //mais alguns casos que veremos mais à frente. 
    // final Product product = Provider.of<Product>(context, listen: false);

    final Product product = Provider.of<Product>(context);
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
             icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
             onPressed: () {
               product.toggleFavorite();
             },
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