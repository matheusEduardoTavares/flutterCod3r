import 'package:flutter/material.dart';
import '../providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(product.title),
      //   centerTitle: true,
      // ),
      ///Nossa ideia agora é fazer uma animação que ao fazer
      ///scroll nessa tela, arrastando de baixo para cima,
      ///a imagem se junte ao [AppBar] e faça um
      ///efeito deles desaparecendo - até ficar com o tamanho
      ///padrão. Devido a isso já não 
      ///colocamos mais o [AppBar] direto no [Scaffold].
      ///Iremos trocar o [SingleChildScrollView] pelo 
      ///[CustomScrollView]. E dentro do [CustomScrollView] 
      ///iremos definir [slivers] que são áreas que podem ter
      ///scroll. Dentro desses [slivers] iremos colocar dois
      ///widgets, o [SliverAppBar] e o [SliverList]. Todo 
      ///[children] que estava dentro da nossa [Column] que 
      ///por sua vez era filho do [SingleChildScrollView] 
      ///passará a ser o primeiro parâmetro posicional do 
      ///objeto [SliverChildListDelegate] que por sua vez
      ///será o valor do atributo [delegate] do [SliverList],
      ///sendo assim deletamos a [Column].
      ///No [SliverAppBar] definimos o [expandedHeight] como
      ///300 pois era esse o height do nosso [Container] que
      ///estava como [children] da coluna, o height da imagem,
      ///e faremos com que a [AppBar] sempre apareça colocando
      ///o atributo [pinned] do [SliverAppBar] como true. Até
      ///aqui a [AppBar] ocupa metade da tela e a imagem outra
      ///metade, e podemos arrastar a imagem para cima até 
      ///que a [AppBar] fique com seu tamanho padrão. Mas para
      ///isso acontecer temos que por um [SizedBox] com um 
      ///[height] de 1000 para poder ter espaço para fazer o 
      ///scroll de baixo para cima. Depois dentro do 
      ///[SliverAppBar] definimos seu [flexibleSpace] como
      ///um [FlexibleSpaceBar], e dentro do [FlexibleSpaceBar]
      ///colocamos um title que será o título do produto. E
      ///também para o [FlexibleSpaceBar] passamos o [background]
      ///como o [Hero] contendo nossa imagem, e aí podemos
      ///tirar o [Container] que era o primeiro item da lista
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              centerTitle: true,
              ///Aqui que é o destino da animação Hero, que é
              ///quem queremos que aumente ao clicar até ocupar
              ///seu espaço, basta envolvermos esse widget que
              ///queremos que no caso é o [Image.network] com 
              ///o [Hero] possuindo a mesma tag
              ///Afim de melhorar a visualização, pois dependendo
              ///da imagem fica ruim ler o [title], iremos usar
              ///um [Stack] para só depois colocar o [Hero]
              background: Stack(
                ///Sem esse [fit] com valor [StackFit.expand]
                ///a [AppBar] volta a se separar do background
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: product.id,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ///Usaremos um [DecoratedBox] para por um 
                  ///gradiente, afim de fazer um sombreamento
                  ///para ficar melhor de enxergar essa parte
                  ///onde ficará o título, escurecendo-a mais,
                  ///de forma que inicia um pouco mais claro e 
                  ///vai escurecendo até no fim ficar totalmente
                  ///escuro
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0, 0.8),
                        end: Alignment(0, 0),
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.6),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Text(
                  'R\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  width: double.infinity,
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                  )
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}