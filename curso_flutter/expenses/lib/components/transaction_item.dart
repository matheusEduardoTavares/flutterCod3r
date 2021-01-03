import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_list.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.onRemove,
  }) : super(key: key);

  final Transaction transaction;
  final DeleteTransaction onRemove;

  @override
  Widget build(BuildContext context) {
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
        trailing: MediaQuery.of(context).size.width > 480 ? 
          FlatButton.icon(
            onPressed: () => onRemove(transaction.id), 
            icon: const Icon(Icons.delete), 
            //aqui por exemplo podemos usar o const pois
            //seu construtor é constante e o parâmetro
            //que ele recebe já é conhecido em tempo de
            //compilação.
            label: const Text('Excluir'),
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
}