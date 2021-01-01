import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

typedef DeleteTransaction = void Function(String);
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final DeleteTransaction onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    //Para evitar que o tamanho da imagem quebre iremos
    //fazer um wrap da Column com um LayoutBuilder para 
    //usarmos as constraints para ter um tamanho certo para
    //que a imagem tenha um espaço para ser renderizado de
    //forma correta. O problema no momento é que estamos
    //usando um container com height 200 como wrap da 
    //imagem para poder renderizá-la, e usando o 
    //LayoutBuilder ela terá todo o tamanho disponível
    return transactions.isEmpty ? LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          // SizedBox(height: constraints.maxHeight * 0.05),
          // Container(
          //   height: constraints.maxHeight * 0.3,
          //   child: FittedBox(
          //     child: Text(
          //       'Nenhuma Transação Cadastrada',
          //       style: Theme.of(context).textTheme.headline6
          //     ),
          //   ),
          // ),
          // SizedBox(height: constraints.maxHeight * 0.05),
          SizedBox(height: 20),
          Text(
            'Nenhuma Transação Cadastrada',
            style: Theme.of(context).textTheme.headline6
          ),
          SizedBox(height: 20),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover
            ),
          ),
        ],
      )
    ) : ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final transaction = transactions[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 5
          ),
          child: ListTile(
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
            //Agora de acordo com uma certa largura mostraremos
            //um elemento ou não
            trailing: MediaQuery.of(context).size.width > 480 ? 
              FlatButton.icon(
                onPressed: () => onRemove(transaction.id), 
                icon: Icon(Icons.delete), 
                label: Text('Excluir'),
                textColor: Theme.of(context).errorColor,
              ) : InkWell(
                onTap: () => onRemove(transaction.id),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).errorColor,
                  ),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
          ),
        );
      }
    );
  }
}