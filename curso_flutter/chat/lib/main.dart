import 'package:chat/screens/auth_screen.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:chat/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///Uma forma que temos de inicializar o APP
///do [Firebase] antes de inicializar a 
///aplicação; além dessa forma, podemos 
///trabalhar com SplashScreens
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(MyApp());
// }
void main() {
  runApp(MyApp());
}

///No momento nosso banco de dados está 
///aberto, ou seja, qualquer pessoa mesmo
///não estando autenticada consegue por 
///exemplo salvar um registro.
///As regras do Firebase ficaram assim:
/*
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
  
  	match /users/{uid} {
    	allow write: if request.auth != null && request.auth.uid == uid;
    }
  
  	match /users/{uid} {
    	allow read: if request.auth != null;
    }
  
    match /chat/{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, appSnapshot) {
        return MaterialApp(
          title: 'Flutter Chat',
          theme: ThemeData(
            primarySwatch: Colors.pink,
            backgroundColor: Colors.pink,
            accentColor: Colors.deepPurple,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.pink,
                ),
                foregroundColor: MaterialStateProperty.all(
                  Colors.white,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                ),
              ),
            ),
            buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            ///Com o [accentColorBrightness] podemos explicitar
            ///para o Flutter se a cor que escolhemos do 
            ///[accentColor] é uma cor escura ou uma cor clara,
            ///para que seja contrastado outras cores 
            ///dependendo do que for colocado nesse 
            ///[accentColorBrightness]. Passamos para ele ou
            ///[rightness.dark] ou [rightness.light]. Não é 
            ///necessário fazer isso com a cor primária, mas com
            ///o [accentColor] é importante fazer
            accentColorBrightness: Brightness.dark,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: appSnapshot.connectionState == ConnectionState.waiting ? 
            SplashScreen() : StreamBuilder(
              ///Sempre que modificar o status se está logado
              ///ou não, automaticamente será chamado novamente
              ///o método [builder]. Mudou o estado do [onAuthStateChanged]
              ///, então o [builder] é chamado
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                ///Se tiver os dados do usuário, vai direto para 
                ///o [ChatScreen]
                if (userSnapshot.hasData) {
                  return ChatScreen();
                }
                
                return AuthScreen();
              }
            ),
        );
      }
    );
  }
}