import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();

    final fbm = FirebaseMessaging();
    fbm.configure(
      onMessage: (msg) {
        print('onMessage...');
        print(msg);
        return;
      },
      onResume: (msg) {
        print('onResume...');
        print(msg);
        return;
      },
      onLaunch: (msg) {
        print('onLaunch...');
        print(msg);
        return;
      },
    );

    fbm.subscribeToTopic('chat');

    fbm.requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              onChanged: (item) {
                if (item == 'logout') {
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
    );
  }
}