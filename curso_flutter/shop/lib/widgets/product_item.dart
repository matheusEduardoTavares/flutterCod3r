import 'package:flutter/material.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/app_routes.dart';
import '../providers/product.dart';
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

    // final Product product = Provider.of<Product>(context);
    //ClipRoundedRectangle, é um widget cujo nome
    //quer dizer que vai cortar fora uma parte do
    //arredondamento de um retângulo

    //Outra estratégia que temos além de usar o
    //Provider.of é o uso do Consumer. Diferente do
    //Provider.of que criamos uma função para ele
    //e o colocamos dentro do método build, o 
    //Consumer é um Widget que colocamos dentro da
    //árvore de componentes.
    //Usando o Consumer deixamos de usar o produto do
    //final Product product = Provider.of<Product>(context);
    //e passamos a usar o produto que é pego no 
    //builder. Ao fazer essa troca o comportamento será
    //exatamente o mesmo. A vantagem de usar o consumer
    //com relação ao Provider.of, é o fato dele ser um
    //widget, então podemos colocá-lo exatamente no 
    //ponto que queremos dentro da árvore de componentes.
    //A única coisa que muda no nosso caso é o símbolo
    //do favorito, então podemos envolver apenas o 
    //botão de favoritos com um consumer de tal forma
    //que conseguimos controlar exatamente a parte do
    //componente que será alterada.
    /*
    //Aqui está o exemplo usando o Consumer em tudo,
    //mas iremos colocá-lo apenas para o botão de 
    //favoritar, de forma a usar o product para 
    //poder renderizar todas as informações na tela
    //mas deixar o listen seu para false, uma vez
    //que as mudanças serão realizadas só no botão
    //de favoritar.
    return Consumer<Product>(
      builder: (ctx, product, _) => ClipRRect(
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
      ),
    );
    */

    final Product product = Provider.of<Product>(context, listen: false);
    //Aqui iremos pegar o carrinho, e o listen dele
    //será false. Pois o componente de ProductItem
    //ao clicar no carrinho não irá mudar nada, quem
    //irá mudar é o contador de carrinhos que será
    //colocado mais para frente na AppBar. Diferente
    //do produto que usamos um Consumer para ele, pois
    //no caso de produto ao clicar em favoritos o produto
    //irá ou não aparecer dependendo do PopupMenuItem
    //que estiver selecionado.
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
          leading: Consumer<Product>(
            //Aqui acontece o shadowing, o sombreamento,
            //como o product daqui tem um escopo menor,
            //aqui dentro é referenciado este product
            //e não o product mais externo. O terceiro 
            //parâmetro do builder é um child, um widget,
            //em que passamos para o Consumer um child,
            //e esse terceiro parâmetro do builder será
            //esse child que passamos, mas ele nunca muda,
            //por exemplo, aqui nós mudamos o Icon, mas se
            //fosse um componente mais complexo que tivesse
            //mais coisas além do icon e algumas partes não
            //precisasse mudar, então o passaríamos para o
            //child e usaríamos o terceiro parâmeto do 
            //build para colocar na árvore esse elemento e
            //ele nunca será rebuildado. Isso gera uma 
            //pequena otimização, de forma que só renderize
            //novamente o que realmente precisa. É uma 
            //otimização pequena mas já é uma otimização
            //de usar o Consumer colocando só na parte do
            //componente que muda de acordo com a mudança
            //do estado.
            // child: Text('Nunca muda'),
            // builder: (ctx, product, child) => IconButton(
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
              //Ao clicar duas vezes em um mesmo item,
              //é adicionado sua quantidade, mas não 
              //na contagem de itens do carrinho, e 
              //sim no atributo quantity do CartItem.
              cart.addItem(product);
            },
          )
        ),
      ),
    );
  }
}