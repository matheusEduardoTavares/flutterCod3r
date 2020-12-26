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
    return Column(
      children: transactions.map((transaction) => Card(
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
                  color: Colors.purple,
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
                    color: Colors.purple,

                  )
                ),
              )
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaction.title, 
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
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
      )).toList(),
      //Ou:
      // children: <Widget>[
      //   ..._transactions.map((transaction) => Card(
      //     child: Text(transaction.title),
      //   )).toList()
      // ]
    );
  }
}