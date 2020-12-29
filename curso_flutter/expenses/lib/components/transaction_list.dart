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
      child: transactions.isEmpty ? Column(
        children: [
          SizedBox(height: 20),
          Text(
            'Nenhuma Transação Cadastrada',
            style: Theme.of(context).textTheme.headline6
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              //O BoxFit.cover vai fazer a imagem ficar dentro
              //da área desde que saiba em que área está, tenha
              //algum elemento com propriedade bem definida.
              //Para resolver o problema da imagem passar o 
              //tamanho permitido, deixamos o BoxFit.cover e
              //fazemos um wrap nesse Image.asset com um 
              //Container deifnindo um height fixo, assim a 
              //área estará bem definida.
              fit: BoxFit.cover
            ),
          ),
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        //o itemBuilder recebe um outro contexto que será
        //passado para a função, não é o contexto do 
        //build, é outro contexto, e o segundo parâmetro 
        //é o index, qual elemento queremos renderizar na
        //chamada da função
        itemBuilder: (ctx, index) {
          final transaction = transactions[index];
          //Agora ao invés de retornarmos um card 
          //contendo toda a estrutura que queremos, 
          //para melhorar o visual da lista iremos 
          //retornar um ListTile, que é um Widget do 
          //flutter. Ele é muito comum de usarmos quando
          //temos uma lista, temos várias coisas pré-
          //definidas. Ele tem title, subtitle, 
          //trailing que é a parte final, leading que é
          //a parte inicial do tijolo que compõe a 
          //lista, e podemos definir algo personalizado 
          //para cada elemento da lista.
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 5
            ),
            child: ListTile(
              //Podemos repetir o comportamento do Circle
              //Avatar desta forma:
              // leading: Container(
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: Theme.of(context).primaryColor
              //   ),
              //   height: 60,
              //   width: 60,
              //   child: Padding(
              //     padding: const EdgeInsets.all(6.0),
              //     child: FittedBox(child: Text(NumberFormat.currency(symbol: 'R\$', decimalDigits: 2).format(transaction.value))),
              //   )
              // ),
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(child: Text(NumberFormat.currency(symbol: 'R\$', decimalDigits: 2).format(transaction.value))),
                )
              ),
              title: Text(
                transaction.title,
                style: Theme.of(context).textTheme.headline6
              ),
              subtitle: Text(
                DateFormat('d MMM y').format(transaction.date)
              ),
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