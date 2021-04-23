import 'package:chat/widgets/message_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      ///Para ordenarmos a mensagem, passaremos a salvar 
      ///o [Timestamp.now()] delas para saber qual mensagem
      ///foi mandada primeiro, aí usamos o método [.orderBy()]
      ///que é provido da [collection], e escolhemos por
      ///qual documento do [Firestore] queremos ordenar,
      ///que no caso é a chave onde estamos guardando 
      ///esses [Timestamp.now()], no caso, 
      ///`createdAt`
      stream: Firestore.instance.collection('chat')
        .orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final chatDocs = chatSnapshot.data.documents;
        
        return ListView.builder(
          ///Usaremos o atributo [reverse] como
          ///true para simular um chat, uma vez
          ///que geralmente as mensagens vem de 
          ///baixo para cima. Além disso, aqui 
          ///acabamos invertendo a ordem das 
          ///mensagens, por isso na hora de usar 
          ///o [orderBy], passamos o 
          ///[desceding] como true
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['text'],
          ),
        );
      }
    );
  }
}