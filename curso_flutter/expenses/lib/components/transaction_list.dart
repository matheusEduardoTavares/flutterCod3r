import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    //Se colocarmos o SingleChildScrollView aqui,
    //fazendo um wrap na Column
    //não irá funcionar pois o componente pai do 
    //SingleChildScrollView não tem um tamanho pré-
    //definido, a não ser que façamos além desse wrap, 
    //outro wrap em cima desse SingleChildScrollView de
    //um container por exemplo e definamos um tamanho 
    //que caiba na tela. Fazendo isso a lista ficará 
    //com scroll correto, mas como apenas a lista é 
    //scrollable, quando clicarmos para cadastar uma novo
    //transação, irá quebrar com o teclado novamente, 
    //pois o teclado ficou em cima de um componente que 
    //não aceita um scroll, no caso o componente para 
    //adicionar novas transações, e por isso irá quebrar.
    //Portanto não adianta fazermos um wrap nessa column 
    //com um SingleChildScrollView e depois fazer um 
    //wrap nesse SingleChildScrollView com um container 
    //definindo um tamanho fixo pois aí com o teclado 
    //iria quebrar, nesse caso é melhor colocar o 
    //SingleChildScrollView como wrap da column lá no 
    //main.dart , de forma que o componente da lista, o
    //componente que será o gráfico no futuro e o 
    //componente de adicionar uma nova transação, todos
    //fiquem com scroll habilitado.
    //Nesse caso o ListView é mais indicado usar pois 
    //ele só carrega o que está sendo mostrado e também
    //permite scroll de todos os itens na lista, mas o 
    //SingleChildScrollView carrega todos mesmo se não 
    //estão aparecendo. O ListView também precisa de um 
    //pai com tamanho pré-definido, então sem o container
    //em volta dele com um height definido, dará o seguinte
    //erro:
    //Vertical viewport was given unbounded height.
    //Ou seja, como não limitamos a altura, o scroll view
    //não sabe qual tamanho deve assumir uma vez que se
    //tem uma altura ilimitada. Por isso o componente pai
    //tem que ter uma altura pré-definida.
    //O ListView na verdade carrega todos os itens de uma
    //vez, quem tem a característica de carregar em memória
    //apenas os itens da lista que estão aparecendo é o 
    //ListView.builder, isso economiza muita memória pois
    //não será renderizado elementos de forma
    //desnecessária. Até podemos usar o ListView sem o
    //.builder, mas só é um bom uso quando temos certeza
    //do tamanho da lista e que não será muito grande 
    //esta lista, se não é bem melhor usar o ListView
    //.builder . Visualmente não muda nada, mas do ponto
    //de vista de desempenho e otimização fica muito 
    //melhor.
    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        //o itemBuilder recebe um outro contexto que será
        //passado para a função, não é o contexto do 
        //build, é outro contexto, e o segundo parâmetro 
        //é o index, qual elemento queremos renderizar na
        //chamada da função
        itemBuilder: (ctx, index) {
          final transaction = transactions[index];

          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  //O symmetric é para ser diferente no eixo vertical
                  //e no eixo horizontal
                  margin: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      //mesmo método estático do navigator
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    )
                  ),
                  padding: EdgeInsets.all(10),
                  child: Center(
                    //Agora com o flutter_localizations,
                    //podemos formatar valor monetário de 
                    //uma forma mais interessante:
                    child: Text(
                      // 'R\$ ${transaction.value.toStringAsFixed(2).replaceAll('.', ',')}',
                      NumberFormat.currency(symbol: 'R\$', decimalDigits: 2).format(transaction.value),
                      //nesse caso não foi passado locale: 'pt_BR' pois isso
                      //já foi definido no Intl.defaultLocale = 'pt_BR';
                      //então não precisa, mas se não fosse definido como 
                      //default precisaríamos passar se não a moeda não 
                      //ficaria no formato brasileiro (ficaria . ao invés da ,
                      //na hora de definir os centavos)
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      )
                    ),
                  )
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transaction.title, 
                      //Não irá pegar o estilo que aplicamos no 
                      //tema pois o definimos dentro do 
                      //AppBarTheme, então será pego o tema 
                      //de headline6 padrão do flutter já que o 
                      //que nós definimos no tema é apenas para 
                      //AppBar. Só passou a funcionar como esperado
                      //depois que dentro do ThemeData foi colocado
                      //isso:
                      /*
                      textTheme: ThemeData.light().textTheme.copyWith(
                        headline6: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18,
                          //Mesmo resultado para os 2 FontWeight :
                          fontWeight: FontWeight.w700 // FontWeight.bold
                        )
                      )
                      */
                      style: Theme.of(context).textTheme.headline6
                      // style: TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.bold
                      // ),
                    ),
                    Text(
                      //Data no formato:
                      // 26 Dec 2020
                      //Agora com o flutter_localizations,
                      //podemos passar um segundo parâmetro
                      //para o DateFormat, o 'pt_BR' , e
                      //assim a data é formatada para pt BR
                      //ficando:
                      //26 dez 2020
                      DateFormat('d MMM y', 'pt_BR').format(
                        transaction.date
                      ), 
                      //Data no formato: 
                      //December 26, 2020
                      // DateFormat.yMMMMd().format(transaction.date),
                      style: TextStyle(
                        color: Colors.grey
                      )
                    )
                  ],
                )
              ],
            ),
          );
        }
        // children: transactions.map((transaction) => ).toList(),
        //Ou:
        // children: <Widget>[
        //   ..._transactions.map((transaction) => Card(
        //     child: Text(transaction.title),
        //   )).toList()
        // ]
      ),
    );
  }
}