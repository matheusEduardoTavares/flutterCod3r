void main(List<String> args){
  var notas = [8.2, 7.1, 6.2, 4.4, 3.9, 8.8, 9.1, 5.1];

  bool Function(double) notasBoasFn = (double nota) => nota >= 7;
  var notasMuitoBoasFn = (double nota) => nota >= 8.8;

  //Dentro da função where temos um laço for 
  //que irá percorrer cada um dos elementos.
  //Teremos um teste, um if para saber se passando 
  //o elemento para função irá retornar verdadeiro ou
  //falso, e se retornar verdadeiro ela será 
  //adicionada no resultado o elemento.
  var notasBoas = notas.where(notasBoasFn).toList(); 
  var notasMuitoBoas = notas.where(notasMuitoBoasFn).toList(); 

  //Com apenas duas linhas de código fizemos tudo 
  //que foi feito na aula passada e terá o mesmo
  //resultado.
  print(notas);
  print(notasBoas);
  print(notasMuitoBoas);
//   [8.2, 7.1, 6.2, 4.4, 3.9, 8.8, 9.1, 5.1]
//   [8.2, 7.1, 8.8, 9.1]
//   [8.8, 9.1]

  //Utilizando o where resolvemos o problema de 
  //filtragem de uma forma mais funcional usando
  //métodos da própria API do dart.
}