import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: const EdgeInsets.all(10),
          child: Text('Funcionou!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          ///Agora que já instalamos a dependência do 
          ///[Firestore], usamos a classe [Firestore] para 
          ///conseguirmos acessar o banco, em que a 
          ///partir do seu atributo [instance] conseguimos
          ///acessar as coleções, pegar os dados lá do 
          ///banco, e etc. A partir dessa instância, temos
          ///o método [collection] em que passamos o nome 
          ///da coleção e é retornado os dados que estão 
          ///dentro desta coleção lá no [Firestore]. A 
          ///partir disso, temos o método [snapshots], que
          ///são os dados em si, e por fim para isso 
          ///chamamos o método [listen] para vincular um 
          ///interessado de forma que sempre que houver uma
          ///alteração, o método que passarmos para o [listen]
          ///como parâmetro será chamado. Ao printar o parâmetro
          ///da função que passamos para o método [listen], vemos
          ///que é uma instância de [QuerySnapshot]. Para
          ///esse parâmetro, podemos chamar o atributo 
          ///[documents], aí nos é retornado uma lista
          ///contendo 2 objetos, duas instâncias de 
          ///[DocumentSnapshot]. Isso ocorreu pois lá
          ///no [Firestore] dentro da collection chat 
          ///que estamos filtrando aqui, temos 2 
          ///documentos, então cada um é um desses 
          ///documentos. Se pegarmos qualquer uma dessas
          ///2 instâncias, e dela acessarmos via chave 
          ///como um map passando a chave 'text', será 
          ///retornado o valor adicionado naquele 
          ///documento cuja coluna corresponde a text.
          ///Se formos ao [Firestore] e adicionarmos 
          ///mais documentos dentro da collection 
          ///chamada chat, veremos que automaticamente
          ///sem fazermos nada, o método passado para 
          ///o [listen] acaba sendo executado pois 
          ///ele percebe que houve uma alteração lá 
          ///no [Firestore]. Sendo assim, ele acaba
          ///trabalhando de forma reativa, em tempo
          ///real, pois quando alteramos o banco de
          ///dados, a própria dependência do [Firestore],
          ///acaba conseguindo criar mecanismos para 
          ///atualizar a aplicação de uma forma interessante,
          ///já que foi registrado uma função para ficar 
          ///escutando as eventuais mudanças dentro da collection
          ///chat, o que é muito interessante.
          Firestore.instance.collection('chat')
            .snapshots().listen((querySnapshot) {
              print(querySnapshot); ///Instance of 'QuerySnapshot'
              print(querySnapshot.documents); ///[Instance of 'DocumentSnapshot', Instance of 'DocumentSnapshot']
              print(querySnapshot.documents[0]); ///Instance of 'DocumentSnapshot'
              print(querySnapshot.documents[0]['text']); ///Bom dia
              querySnapshot.documents.forEach((element) {
                print(element['text']);
                ///Bom dia
                ///Tudo bem?
              });
            });
        },
      ),
    );
  }
}