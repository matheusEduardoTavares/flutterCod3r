import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/providers/auth.dart';

enum AuthMode {
  Signup,
  Login
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  var _authMode = AuthMode.Login;
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  ///Faremos a animação de forma manual nessa aula, e nas
  ///próximas aulas usaremos alguns Widgets para facilitar 
  ///a criação de animações
  AnimationController _controller;
  ///Iremos fazer uma animação de tamanho, baseado na altura
  ///do [Card]
  Animation<Size> _heightAnimation;

  @override 
  void initState() {
    super.initState();

    _controller = AnimationController(
      ///O [vsync] pede um [TickerProvider]. O Flutter é um 
      ///framework que opera a 60 quadros por segundo, 60 frames
      ///por segundo. Cada [Ticker] é capaz de detectar quando há
      ///uma mudança de quadro. Irá conseguir chamar 60 vezes por
      ///segundo. A classe [Ticker] conseguimos registrar uma 
      ///função callback e esta callback será executada sempre que
      ///houver uma atualização do quadro. O [vsync] precisa desse
      ///[TickerProvider] para fazer a sincronia da animação. Para
      ///usar um [TickerProvider], precisamos que nossa classe 
      ///faça um [with] do mixin [SingleTickerProviderStateMixin].
      ///O Single é devido ao fato de que iremos usar apenas uma
      ///animação, o [TickerProvider] é o que o [vsync] precisa, 
      ///e o [StateMixin] significa que estará relacionado ao 
      ///estado do componente, ou seja, sempre que houver uma 
      ///mudança no estado será chamado esse [TickerProvider] para
      ///dizer que houve uma mudança no estado. Por exemplo
      ///mudamos a altura de 300 até 400. Entre esse intervalo
      ///ele irá conseguir fazer tal mudança de forma gradativa
      ///que é exatamente o que a animação irá fazer, não irá
      ///pular de uma vez, pode por exemplo pular de 10 em 10.
      ///E cada mudança gera uma mudança de quadro, assim a 
      ///animação será injetada e será fluída de forma natural.
      ///A classe que é [TickerProvider] é essa própria classe,
      ///o [_AuthCardState] que passou a se tornar um [TickerProvider]
      ///após fazer o with do [SingleTickerProviderStateMixin].
      vsync: this,
      ///Duração da animação
      duration: Duration(
        ///300 millisegundos é quase 1/3 de segundo, então
        ///se o flutter faz 60 quadros por segundo e faremos
        ///uma animação de 1/3 de segundo, teremos 
        ///aproximadamente 20 quadros de animação para sair 
        ///da altura mínima até a máxima.
        milliseconds: 300,
      ),
    );

    ///Agora para o objeto do [Animation] usaremos o 
    ///[Tween] que vem de between, entre duas coisas.
    ///Com o [Tween] definimos o início e fim da animação, 
    ///que devido ao generics explicitamos que é [Size]. E
    ///logo após passar essa instância do [Tween] com o 
    ///intervalo, já chamamos seu método [animate] pois é
    ///essa [animate] que de fato retornará uma animação para
    ///ser atribuído para o [_heightAnimation]. O
    ///[animate] recebe como parâmetro um
    ///[Animation<double>], que é o tipo de animação
    ///que queremos fazer para sair do início e ir até o 
    ///final. No caso usaremos o [CurvedAnimation] passando
    ///para o seu atribvuto [parent] que é 
    ///quem irá controlar a nossa animação, 
    ///que no caso é o [_controller]. Passamos para ele também
    ///o [curve] que é exatamente o tipo de curva, o tipo de
    ///algoritmo que será usado para fazer a animação. O 
    ///valor que ele irá receber provém do enum [Curves], 
    ///sendo que cada elemento desse enum é um algoritmo 
    ///diferente para fazer a animação. No caso usaremos um
    ///que a velocidade é constante do começo até o fim, 
    ///que é o [Curves.linear]
    _heightAnimation = Tween(
      ///Passamos a largura e a altura para o [Size], mas 
      ///como não estamos interessados na largura, passamos
      ///simplesmente um [double.infinity] para largura
      begin: Size(double.infinity, 290),
      end: Size(double.infinity, 371)
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    ///Mais para frente tiraremos isso, mas precisamos 
    ///registrar a partir do [_heightAnimation] um listener
    ///para que seja chamado o [setState] para que o seu 
    ///valor do [Size] seja atualizado de forma a refletir 
    ///na UI.
    ///A partir do momento que usamos o [AnimatedBuilder]
    ///não precisamos mais do [setState]
    // _heightAnimation.addListener(() {
    //   setState(() {});
    // });
  }

  final _authData = <String, String>{
    'email': '',
    'password': ''
  };

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro!'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('FECHAR'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey?.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState.save();

    final auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await auth.login(
          _authData['email'], 
          _authData['password']
        );
      } else {
        await auth.signup(
          _authData['email'], 
          _authData['password']
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      ///Aqui chamamos o [_controller] que é quem 
      ///controla a animação, e usaremos para ele o método
      ///[forward], pois ele fará a animação normalmente,
      ///para que ela vá do [begin] até o [end] que foi 
      ///definido no [_heightAnimation]
      _controller.forward();
    }
    else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      ///Já aqui usamos o [reversed] para que seja feito
      ///o contrário, ir do [end] até o [begin] estipulado
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Flexible(
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SingleChildScrollView(
            ///Como só queremos animar o [Container], 
            ///mas não animar seu child que é o [Form],
            ///passamos o que não será animado como
            ///[child] e podemos recupar isso na
            ///função do [builder]. Sua animação
            ///seŕa o [_heightAnimation]
            child: AnimatedBuilder(
              builder: (ctx, child) => Container(
                ///Agora aqui para nos usufruirmos da 
                ///animação criada, temos que usar o [height]
                ///do [Animation] aqui, pegando o [height] que
                ///é provido do seu [value]. É isso que é 
                ///responsável por alterar o valor da altura
                ///de forma animada. Porém só isso não é o 
                ///suficiente, pois estamos dentro de um 
                ///componente [StatefulWidget] e precisamos 
                ///chamar o [setState] para que seja detectado
                ///as mudanças.
                height: _heightAnimation.value.height,
                width: deviceSize.width * 0.75,
                padding: const EdgeInsets.all(16),
                child: child
              ),
              animation: _heightAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail'
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Informe um e-mail válido!';
                        }

                        return null;
                      },
                      onSaved: (value) => _authData['email'] = value,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha'
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Informe uma senha válida!';
                        }

                        return null;
                      },
                      onSaved: (value) => _authData['password'] = value,
                    ),
                    if (_authMode == AuthMode.Signup)
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirmar Senha'
                        ),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup ? (value) {
                          if (value != _passwordController.text) {
                            return 'Senhas são diferentes!';
                          }
                          else if (value.isEmpty) {
                            return 'Senha vazia!';
                          }

                          return null;
                        } : null,
                      ),
                    const SizedBox(height: 40),
                    if (_isLoading)
                      CircularProgressIndicator()
                    else
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryTextTheme.button.color,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 8,
                        ),
                        child: Text(
                          _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                        ),
                        onPressed: _submit,
                      ),
                    ///Adicionaremos uma animação para quando o 
                    ///usuário clicar nesse [FlatButton] aparecer o 
                    ///novo [TextFormField] de forma mais suave, e 
                    ///não de forma bruta.
                    ///No momento a animação dá um bug que ao
                    ///clicar em ALTERNAR P/ REGISTRAR é mostrado
                    ///o erro de tamanho overflow, mas isso ocorre
                    ///pois é mostrado o terceiro campo e estava
                    ///fazendo o processo de animação ainda. Mas
                    ///em produção isso não irá ocorrer.
                    FlatButton(
                      onPressed: _switchAuthMode,
                      child: Text(
                        'ALTERNAR P/ '
                        '${_authMode == AuthMode.Login ? 'REGISTRAR' : 'LOGIN'}'
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override 
  void dispose() {
    // _heightAnimation.removeListener(() {});
    _controller.dispose();

    super.dispose();
  }
}