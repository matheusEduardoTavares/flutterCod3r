import 'package:flutter/material.dart';
import 'transaction_item.dart';
import '../models/transaction.dart';

typedef DeleteTransaction = void Function(String);
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final DeleteTransaction onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    // print('build() TransactionList');
    return transactions.isEmpty ? LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Nenhuma Transação Cadastrada',
            style: Theme.of(context).textTheme.headline6
          ),
          const SizedBox(height: 20),
          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover
            ),
          ),
        ],
      )
      //Existe um comportamento estranho relacionado ao
      //ListView quando usamos um builder, por isso 
      //inicialmente iremos comentar o ListView usando 
      //builder, e depois veremos uma possível solução 
      //usando chaves globais, que não é a solução ideal,
      //provavelmente isso é um bug.
      //Criamos o TransactionItem que recebe uma key e 
      //passa essa key para o super, e esse atributo serve
      //para identificar um elemento unicamente dentro de
      //um determinado contexto. Se usarmos uma chave local
      //dentro de um determinado nível da árvore, ele irá
      //comparar a partir das chaves como por exemplo uma
      //lista ou podemos usar uma chave global de forma que
      //será possível identificar o elemento dentro da 
      //aplicação inteira. No caso da Key key que é o atributo
      //key do TransactionItem, depois fazermos um 
      //super(key: key), de forma que o super faz referência
      //a superclasse, a classe pai, e assim essa classe pai
      //a deixamos identificável unicamente pelo key, pois
      //estamos chamando o construtor da classe pai e passando
      //o key.
    ) : 
      /* ListView(
        children: transactions.map((transaction) {
          return TransactionItem(
            //Agora aqui passamos para key se passarmos
            //uma chave única, a UniqueKey(), isso não será 
            //viável pois teremos uma única chave e assim
            //todos os itens serão identificados por uma 
            //mesma chave. Se deixarmos com essa UniqueKey,
            //quando cadastrarmos um segundo item na lista,
            //todos os itens que já tinham sido cadastrados
            //passarão a mudar a cor, isso porque sempre
            //será gerado um identificador único, que não era
            //o anterior, vai tentar procurar o elemento e não
            //vai achar então vai criar um novo elemento com 
            //um novo estado.
            // key: UniqueKey(),
            //A chave que irá nos atender é a ValueKey em que
            //passamos o valor no construtor do ValueKey()
            //e esse valor será o identificador do item. Basta
            //então passarmos o ID do transaction que já tem 
            //essa ideia de deixar cada transaction única e 
            //assim garantimos que não haverá mais problema nesse
            //caso. O ValueKey nesse caso resolve o problema
            //e é uma chave local, será usada apenas dentro
            //do contexto do ListView. Uma chave local só
            //funciona dentro daquele nível, se colocarmos
            //uma chave associada a um subtipo, por exemplo
            //pegar uma ValueKey e associar a um elemento
            //secundário dentro da nossa árvore de componentes,
            //não irá funcionar.
            key: ValueKey(transaction.id),
            transaction: transaction,
            onRemove: onRemove
          );
        }).toList(),
      ); */
    ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final transaction = transactions[index];
        return TransactionItem(
          //Agora, nesse contexto com o ListView.builder,
          //usar uma ValueKey, uma chave local não faz o
          //trabalho que queremos que ela faça. Volta a 
          //dar o problema de se perder no estado quando
          //deleta um item. Nesse caso para funcionar
          //temos que passar o GlobalObjectKey passando
          //o objeto da transaction como sendo uma chave.
          //Usamos o GlobalObjectKey quando queremos 
          //garantir que um dado componente mostre 
          //exatamente a posição que ele ficou em uma 
          //lista. Por ser Global ela será única dentro 
          //de toda árvore de componentes, isso é bom porque
          //não é só local, irá garantir que ele é único na
          //aplicação inteira, e é ruim também pois 
          //terá que procurar em toda a árvore de componentes
          //para poder achar o elemento associado aquela key.
          //Isso gera mais ineficiência, só a usamos quando
          //realmente é necessária como nesse caso.
          //Com relação ao ValueKey não funcionar no 
          //ListView.builder, temos este comentário na 
          //comunidade:
          /*
            This is working as intended. Check out the document in here https://master-api.flutter.dev/flutter/widgets/ListView/ListView.builder.html
            it mentioned ListView.builder by default does not support child reordering. If you are planning to change child order at a later time, consider using ListView or ListView.custom.

            we have an example snippet to show how to do that in the listview.custom api doc https://master-api.flutter.dev/flutter/widgets/ListView/ListView.custom.html
          */
          key: GlobalObjectKey(transaction),
          transaction: transaction,
          onRemove: onRemove
        );
      }
    );
  }
}