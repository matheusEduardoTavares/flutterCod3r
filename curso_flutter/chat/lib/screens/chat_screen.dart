import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          ///O [DropdownButtonHideUnderline] serve 
          ///apenas para remover uma pequena linha
          ///que aparece abaixo do [DropdownButton]
          ///por padrão que é branca e se estiver com
          ///um fundo de outra cor pode ser percebida.
          ///Porém nas versões mais recentes do 
          ///Flutter isso já não acontece mais
          DropdownButtonHideUnderline(
            child: DropdownButton(
              onChanged: (item) {
                if (item == 'logout') {
                  ///Aqui usamos o método [signOut]
                  ///para fazer o logout da aplicação
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
        ///Sempre que chegar novos dados no [stream], será 
        ///chamado o método [builder], sendo que o [builder] 
        ///recebe uma função que recebe o contexto e o 
        ///[AsyncSnapshot] que é o snapshot dos dados, e assim
        ///como o [FutureBuilder], temos que trabalhar com o 
        ///seu [connectionState]
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Messages()
              ),
              NewMessage(),
            ],
          )
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
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
          ///Verificamos que o [snapshots] é um 
          ///[Stream<QuerySnapshot>]. Uma Stream é uma 
          ///sequência de dados e que não necessariamente
          ///é passada toda de uma vez. Por exemplo, no 
          ///momento que carregamos a tela, vai lá e 
          ///carrega uma sequência de dados. A partir do 
          ///momento que definimos para essa Stream um 
          ///[listen], significa que esse interessado irá
          ///ficar ouvindo uma sequência de dados. Então
          ///por exemplo caso adicionemos um novo documento
          ///lá no [Firestore], sem precisar clicar no botão
          ///veremos que o método passado para o [listen] é
          ///executado justamente por isso. No flutter temos
          ///um componente para trabalhar com stream de 
          ///dados, que é o [StreamBuilder]
          // Firestore.instance.collection('chat')
          //   .snapshots().listen((querySnapshot) {
          //     print(querySnapshot); ///Instance of 'QuerySnapshot'
          //     print(querySnapshot.documents); ///[Instance of 'DocumentSnapshot', Instance of 'DocumentSnapshot']
          //     print(querySnapshot.documents[0]); ///Instance of 'DocumentSnapshot'
          //     print(querySnapshot.documents[0]['text']);
          //     querySnapshot.documents.forEach((element) {
          //       print(element['text']);
          //     });
          //   });
          
          ///Para adicionar um novo dado no [Firestore] 
          ///usamos o método [add] a partir da collection,
          ///e passamos para ele um [Map<String, dynamic>]
      //     Firestore.instance.collection('chat')
      //       .add({
      //         'text': 'Adicionado manualmente!',
      //         'flutter': true,
      //       });
      //   },
      // ),
    );
  }
}