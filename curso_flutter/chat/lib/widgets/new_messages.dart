import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();

    ///Conseguimos pegar qual é o usuário logado na 
    ///aplicação usando o método [currentUser] do 
    ///[FirebaseAuth.instance]
    final user = await FirebaseAuth.instance.currentUser();
    final userData = await Firestore.instance.collection('users')
      .document(user.uid).get();

    Firestore.instance.collection('chat')
      .add({
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        ///Usamos seu [uid] pois esse é o identificador
        ///único de usuário no [Firebase]
        'userId': user.uid,
        'userName': userData['name'],
        'userImage': userData['imageUrl'],
      });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enviar mensagem...',
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}