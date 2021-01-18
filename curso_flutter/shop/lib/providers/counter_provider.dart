import 'package:flutter/material.dart';
//Toda classe que extender a classe InheritedWidget precisa
//implementar o método updateShouldNotify

//Criaremos uma classe que irá representar o estado da 
//aplicação
class CounterState {
  int _value = 1;

  void inc() => _value++;
  void dec() => _value--;
  int get value => _value;

  //Método para verificar se o estado mudou, se um estado
  //é diferente de outro. Com esse método validamos se 
  //o value é diferente e se o old é null. Usaremos esse
  //método diff no updateShouldDiff para sabermos se 
  //deve notificar uma atualização ou não.
  bool diff(CounterState old) {
    return old == null || old._value != _value;
  }
}

//O CounterProvider é um widget que precisa ser constante, 
//todos os valores dele tem que ser final, assim como no 
//stateless e assim também como no stateful (o stateful tem
//os valores finais, já o state é a classe que vai evoluir
//com o tempo)
class CounterProvider extends InheritedWidget {
  //Preferimos não passar como parâmetro o state por 
  //enquanto.
  final CounterState state = CounterState();

  //Aqui no CounterProvider recebemos um widget e o 
  //passamos para o child do super.
  CounterProvider({Widget child}) : super(child: child);

  //Agora iremos criar o método estático of. Não somos 
  //obrigados a criá-lo. E como já dito não precisa ser um
  //Widget herdado para ter o método estático of, por 
  //exemplo temos o método Theme.of(context) que é um 
  //StatelessWidget. Mas iremos criar para facilitar o 
  //acesso a variável state que criamos na linha 32.

  static CounterProvider of(BuildContext context){
    //Antes usávamos esse método para trabalhar com isso,
    //o método inheritFromWidgetOfExactType, mas que foi 
    //depreciado.Agora usamos o dependOnInheritedWidgetOfExactType(); 
    // return context.inheritFromWidgetOfExactType(targetType)

    //Não somos obrigado a colocar o generics. 
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();

    //Agora a partir deste método iremos obter uma instância
    //do componente CounterProvider, isso se esse componente
    //estiver presente na árvore de componentes. Se não 
    //introduzirmos esse componente na nossa árvore de 
    //componentes, a resposta será nula. Quando fizermos 
    //um CounterProvider.of qualquer context o resultado 
    //será nulo, pois não está presente na árvore.
  }

  //Depois adequaremos certo esse método.
  @override 
  bool updateShouldNotify(InheritedWidget inheritedWidget) => true;
}