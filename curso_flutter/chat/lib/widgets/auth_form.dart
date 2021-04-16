import 'package:chat/models/auth_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isVisiblePassword = true;
  final AuthData _authData = AuthData();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey?.currentState?.validate() ?? false;
    if (isValid) {
      FocusScope.of(context).unfocus();
      print(_authData.name);
      print(_authData.email);
    }
    else {
      print('inválido');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup)
                    TextFormField(
                      key: ValueKey('name'),
                      initialValue: _authData.name,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      ///Para vincular os campos do 
                      ///formulário ao objeto que
                      ///terá todos os dados necessários, 
                      ///que no caso é o [_authData], temos
                      ///2 formas, uma delas é usando o 
                      ///[onSaved] para quando chamarmos o
                      ///método [save] do formulário 
                      ///conseguirmos salvar os dados 
                      ///uma única vez no objeto de forma
                      ///que o método [save] do [Form] 
                      ///executa todos os [onSaved] de 
                      ///cada um dos [TextFormField] dentro
                      ///do [Form]. Outra alternativa é 
                      ///usar o [onChanged], ou seja, sempre
                      ///que o usuário digitar algo,
                      ///a função passada para o [onChanged]
                      ///recebe um parâmetro que é o valor 
                      ///digitado no momento, aí é só 
                      ///alterar o valor do atributo do 
                      ///[_authData], e nem precisamos do 
                      ///[setState] pois não precisamos
                      ///atualizar em tela os valores já 
                      ///que já estarão aparecendo no 
                      ///formulário (os valores do objeto 
                      ///[_authData] não são renderizados, 
                      ///por isso não precisamos do [setState]
                      ///para atualizá-los)
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Nome deve ter no mínimo 4 caracteres';
                        }

                        return null;
                      }
                    ),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      ///Podemos aplicar uma Regex para verificar se
                      ///é um e-mail válido
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um e-mail válido';
                      }

                      return null;
                    }
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: _isVisiblePassword,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Senha deve ter no mínimo 7 caracteres';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(_isVisiblePassword ? 
                          Icons.visibility : Icons.visibility_off
                        ),
                        onPressed: () => setState(() { _isVisiblePassword = !_isVisiblePassword; }),
                        color: _isVisiblePassword ? 
                          Theme.of(context).accentColor : Colors.grey,
                      ),
                    ),
                    onChanged: (value) => _authData.password = value,
                  ),
                  const SizedBox(height: 12),
                  RaisedButton(
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                    onPressed: _submit,
                  ),
                  ///No momento ao clicar nesse botão para criar uma conta
                  ///ou fazer o login, o [TextFormField] do nome some. E
                  ///acontece que se não passarmos uma [key] para cada um
                  ///dos [TextFormField] e já tivéssemos digitado os 
                  ///valores, acontece que o que tinha sido digitado no 
                  ///nome vai para o E-mail e o que estava no E-mail vai
                  ///para a senha devido ao que já vimos das árvores do 
                  ///Flutter. Com a [key], passamos a identificar cada 
                  ///um dos elementos e este problema deixa de ocorrer. 
                  ///Ao passar a [key], após preencher os campos e trocar
                  ///para o login, o campo E-mail fica com o conteúdo do 
                  ///E-mail, e da senha com a senha corretamente, e o 
                  ///nome é perdido, na verdade ele se mantém no 
                  ///[_authData], mas o [TextFormField] passa a ser 
                  ///renderizado de novo então ele aparece vazio. Para fazer
                  ///continuar com o nome que estava inserido, é só adicionar
                  ///um [initialValue] sendo o [_authData.name]
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(_authData.isLogin ? 'Criar uma nova conta?' :
                      'Já possui uma conta?'),
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}