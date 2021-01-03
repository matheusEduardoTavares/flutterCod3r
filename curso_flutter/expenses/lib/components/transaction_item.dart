import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_list.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.onRemove,
  }) : super(key: key);

  final Transaction transaction;
  final DeleteTransaction onRemove;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black
  ];

  Color _backgroundColor;

  @override 
  void initState(){
    super.initState();

    /*
      Aqui temos um problema em trabalhar com listas e
      StatefulWidget em que aqui geramos uma cor aleatória
      para o CircleAvatar de cada item da lista. Mas quando
      apagamos um item da lista, o item abaixo dela não 
      continua com sua cor, e passa a ter a cor do item que
      foi deletado. Ou seja, o estado associado aquele 
      elemento não está acompanhando sempre que 
      excluímos um elemento dentro de uma lista, o componente
      stateful está bagunçando quando juntamos com uma lista
      já que o estado não está sendo respeitado.
      Basicamente o problema que ocorre é o seguinte, 
      cada item do listView, na árvore de widgets tem
      uma referência apontada pelo elemento no element
      tree, e quando apagamos um item da lista de widgets
      o item que estava abaixo dele é realocado para cima,
      local onde estava o item que foi deletado e que o 
      elemento do element tree estava apontando, mas agora 
      o elemento com o estado do item que foi deletado 
      estará apontando para o widget que estava depois e 
      que foi realocado, por isso ele pega a cor do item que
      foi deletado, e as referências e os elementos do 
      element tree não são atualizados pois os itens 
      continuam sendo os mesmos, não mudou o widget para que
      seja recriado os elementos, tudo que acontece é que 
      o último elemento da element tree passará a apontar para
      ninguém pois haverá um widget a menos, então tal 
      elemento é deletado mas todos os demais continuam 
      idênticos, de forma que se deletarmos o último item
      da lista não terá problema, mas se deletarmos um 
      item que não é o último, acontecerá que o estado do que
      foi deletado passará a ser o estado do widget posterior
      ao que foi deletado, e assim por diante, de forma que 
      irá mexer em todos os estados. Para resolver isso, 
      devemos usar chaves, as keys, pois assim garantimos
      qual widget está associado a qual elemento. Não 
      precisamos usar keys sempre, só precisamos usá-la em
      situações atípicas como nesse caso de ter um elemento
      do tipo stateful e uma lista. Se o elemento fosse do
      tipo stateless não teria problema nenhum o fato de 
      estar renovando os componentes e associando aos 
      elementos pré-existentes.
    */

    int i = Random().nextInt(colors.length);
    _backgroundColor = colors[i];
  }

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
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(child: Text(NumberFormat.currency(symbol: 'R\$', decimalDigits: 2).format(widget.transaction.value))),
          )
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.transaction.date)
        ),
        trailing: MediaQuery.of(context).size.width > 480 ? 
          FlatButton.icon(
            onPressed: () => widget.onRemove(widget.transaction.id), 
            icon: const Icon(Icons.delete), 
            //aqui por exemplo podemos usar o const pois
            //seu construtor é constante e o parâmetro
            //que ele recebe já é conhecido em tempo de
            //compilação.
            label: const Text('Excluir'),
            textColor: Theme.of(context).errorColor,
          ) : InkWell(
            onTap: () => widget.onRemove(widget.transaction.id),
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