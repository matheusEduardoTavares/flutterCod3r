import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override 
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleSubmit(AuthData newAuthData) async {
    setState(() {
      _isLoading = true;
    });

    try {
      AuthResult _authResult;
      if (newAuthData.isLogin) {
        _authResult = await _auth.signInWithEmailAndPassword(
          email: newAuthData.email.trim(),
          password: newAuthData.password,
        );
      }
      else {
        ///Agora além de cadastrar o email e a senha,
        ///iremos mandar também para o [Firestore]
        ///o nome do usuário
        _authResult = await _auth.createUserWithEmailAndPassword(
          email: newAuthData.email.trim(),
          password: newAuthData.password,
        );

        ///Para fazer upload de uma imagem para o 
        ///[Bucket] do [Firebase], usamos a instância
        ///do [FirebaseStorage], e desse objeto usamos o
        ///método [ref] para pegar a referência para o 
        ///[Bucket] padrão; que é como se fosse um espaço
        ///de armazenamento padrão. Inclusive conseguimos
        ///criar novos [Buckets]. Do resultado disso 
        ///usamos o método [child] passando como parâmetro
        ///o nome da pasta que queremos que seja salvo a 
        ///imagem lá no [Bucket], e do resultado disso usamos
        ///de novo o método [child] que irá representar o 
        ///nome do arquivo. No nosso caso, o nome do arquivo
        ///será o identificador único de cada usuário, no
        ///formato que a imagem será salva com o uid do 
        ///usuário e no fim terá .jpg
        final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child(_authResult.user.uid + '.jpg');

        ///Agora o ref será um [StorageReference] que 
        ///aponta para a referência da imagem com o uid
        ///do usuário, dentro da pasta user_images, e 
        ///a partir dele podemos usar o método [putFile]
        ///para fazer o upload de um arquivo. Precisamos
        ///disso passar o atributo [onComplete] pois ele 
        ///é quem retorna [Future] e assim podemos usar 
        ///um [await] para esperar e garantir que a imagem
        ///já foi upada para o [Bucket]
        await ref.putFile(newAuthData.image).onComplete;
        ///Agora pegamos qual URL onde foi salvo as imagens, usando o método
        ///[getDownloadUrl]
        final url = await ref.getDownloadURL();

        final userData = {
          'name': newAuthData.name,
          'email': newAuthData.email,
          'imageUrl': url,
        };

        ///Aqui caso a collection `users` não exista
        ///no [Firestore] ela será criada. E iremos 
        ///armazenar nela um documento a partir de
        ///um ID. Obtemos esse ID do usuário cadastrado
        ///que vem das requisições de criar um usuário
        ///ou de fazer o login, pois ambos retornam 
        ///um [AuthResult], e desse [AuthResult] basta
        ///pegar o [.user.uid] que será tal identificador.
        ///Então para a coleção chamaremos o método 
        ///[document] passando como parâmetro para ele esse
        ///[uid] do usuário, e do resultado disso chamamos
        ///o método [setData] passando o [Map] que criamos
        ///e que contém os dados do usuário como parâmetro
        ///para que na criação de um usuário, já salvemos
        ///seu [uid] na collection `users`, cujo documento
        ///terá como chave tal [uid]
        await Firestore.instance.collection('users')
          .document(_authResult.user.uid)
          .setData(userData);
      }
      ///Caso ocorra algum erro no Firebase, será 
      ///gerado a [Exception] [PlatformException]
    } on PlatformException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro! Verifique suas credenciais!'; 
      ///Aqui iremos mostrar a variável [msg] em uma 
      ///[SnackBar] contendo o erro encontrado. Isso 
      ///seria bem fácil se estivéssemos em uma tela que
      ///fosse filha de [Scaffold], ou seja, tivesse 
      ///um [BuildContext] próprio, fosse um [Stateless]
      ///ou um [Stateful]. Porém, não é o caso, então 
      ///para resolver isso nas versões mais antigas do a 
      ///Flutter, temos que passar para o 
      ///[Scaffold] uma [key] sendo um [GlobalKey<ScaffoldState>],
      ///aí para o objeto que tem essa instância da chave 
      ///global, pegamos o atributo [.currentState] e a 
      ///partir daqui temos acesso aos métodos referentes
      ///à [SnackBar], como [showSnackBar()], e então usamos
      ///esse objeto ao invés de usar o [Scaffold.of(context)],
      ///para acessar os métodos referentes ao [SnackBar].
      ///Já nas versões mais recentes do Flutter, 
      ///esse problema foi resolvido, 
      ///bastando usar o [ScaffoldMessenger.of(context)], 
      ///sendo que ele funciona igual ao [Scaffold.of(context)]
      ///e independente de onde será chamado a [SnackBar]
      // _scaffoldKey.currentState.showSnackBar(...)
      ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(msg),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      
      setState(() {
        _isLoading = false;
      });
    }
    catch (err) {
      print(err);

      ///Caso o login tenha dado sucesso, agora o usuário
      ///já vai para página do chat devido ao fato da 
      ///[StreamBuilder] ter o [builder] executado de novo,
      ///uma vez que o [FirebaseAuth.instance.onAuthStateChanged]
      /// irá mudar; e dá erro colocar esse
      ///[setState] no [finally] pois dá 
      ///um [setState] depois de ter executado o [dispose],
      ///logo, só iremos setar para false em caso de 
      ///erro
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      // body: AuthForm(
      //   _handleSubmit,
      // ),
      ///O [Center] será para deixar nosso formulário
      ///apenas no centro. Para que de fato a [Column]
      ///ocupe apenas o centro, temos que definir seu
      ///[mainAxisSize] como [MainAxisSize.min]
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ///E aqui será feito um Widget de forma que
              ///durante a requisição fique escurecido o
              ///formulário e com o [CircularProgressIndicator]
              ///bem no centro
              Stack(
                children: [
                  AuthForm(
                    _handleSubmit
                  ),
                  ///O [Positioned.fill] preenche toda 
                  ///a área que é ocupada da tela
                  if (_isLoading)
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5)
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}