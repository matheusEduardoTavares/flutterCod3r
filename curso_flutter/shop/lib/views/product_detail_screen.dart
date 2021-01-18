import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/counter_provider.dart';

/*
class ProductDetailScreen extends StatelessWidget {
  //Mesmo quando temos um gerenciamento de estado
  //mais sofisticado na aplicação, ainda assim
  //passamos parâmetros de um componente para outro.
  //Mesmo tendo um gerenciamento + sofisticado na 
  //aplicação ainda assim teremos componentes 
  //stateful, então ainda assim passaremos parâmetros
  //tanto para stateful quanto para stateless, quanto
  //também teremos estados no stateful. Por exemplo um
  //botão que quando clicamos nele ele faz uma requisição
  //para pegar dados e queremos mostar um spinner, algo 
  //girando para deixar claro pro usuário que está sendo
  //feito um processamento. Se vai mostrar ou esconder
  //o spinner, não faz sentido colocar essa lógica / dado
  //que define se vai exibir ou não externalizado do 
  //componente, pois é algo inerente aquele componente,
  //então o ideal é que fique encapsulado dentro do 
  //componente. Já outras informações como por exemplo
  //quais são os produtos que estão no carrinho, aí sim
  //faz sentido externalizar isso pois tem vários 
  //componentes que usarão essa informação.

  // final Product product;

  // const ProductDetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget> [
          RaisedButton(
            child: Text('+'),
            onPressed: () {
              //Como o CounterProvider ainda não foi 
              //declarado na árvore (só foi definido na 
              //pasta provider mas não foi colocado na 
              //árvore de componentes), então o 
              //resultado do print será null. Uma vez 
              //indo em main.dart e fazendo um Wrap do 
              //MaterialApp com o CounterProvider ao clicarmos
              //nesse botão será printado CounterProvider, ou
              //seja, aqui temos uma instância de CounterProvider.
              //Ele vai procurando na rede de contextos até chegar
              //em um momento e encontrar uma instância de 
              //CounterProvider.
              // print(CounterProvider.of(context));
              //Agora assim é mostrado o valor do State:
              // print(CounterProvider.of(context).state.value); // 1

              //Podemos incrementar o valor ou decrementá-lo usando 
              //os métodos que criamos na classe CounterState:
              CounterProvider.of(context).state.inc();
              
              //Dessa forma conseguimos, portanto chamar o método que
              //está dentro do componente herdado. Consigo acessar 
              //ele diretamente sem receber ele por parâmetro, e não
              //precisamos passar de um componente para outro para 
              //acessá-lo.
            }
          ),
          //Colocando o texto e clicando para incrementar, o valor
          //vai sendo incrementado mas ao colocar o Text vemos que
          //não está refletindo na UI. Isso acontece pois estamos
          //dentro de um contexto de um componente stateless, e a
          //única forma de um componente stateless mudar é quando
          //um parâmetro recebido pelo componente acaba sendo 
          //alterado, o que não é o caso. Se incrementarmos seu 
          //valor clicando nos botões, sairmos da página e voltarmos
          //aí sim seu valor será atualizado pois o componente foi
          //recriado, mas só será refletido em real time na UI se
          //o componente for stateful.
          Text(CounterProvider.of(context).state.value.toString()),
        ]
      )
    );
  }
}
*/

/*
class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget> [
          RaisedButton(
            child: Text('+'),
            onPressed: () {
              //Ainda sim continuará o valor sendo incrementado
              //mas não mostrando na UI, pois só será refletido
              //na UI quando colocarmos o método para incrementar
              //dentro de um setState. Assim mesmo o dado estando
              //externalizado e não direto no componente, ele é 
              //atualizado.
              // CounterProvider.of(context).state.inc();
              setState(() {
                // CounterProvider.of(context).state.inc();

                //Outra forma de funcionar é usando o contexto
                //direto, porém, nesse caso somos obrigados a 
                //resolver o generics, caso contrário não temos
                //acesso ao state, mesmo sem precisar criar o método 
                //of, mas é mais interessante usar o of:
                context.
                  dependOnInheritedWidgetOfExactType<CounterProvider>().
                    state.inc();
              });
            }
          ),
          Text(CounterProvider.of(context).state.value.toString()),
        ]
      )
    );
  }
}
*/

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
    );
  }
}