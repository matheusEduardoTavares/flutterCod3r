package com.example.nativo

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine 
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    //val permite criar variáveis somente de leitura,
    //e é opcional colocar ; no fim das sentenças
    private val CHANNEL = "cod3r.com.br/nativo"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        //Do método setMethodCallHandler, recebe-se 2 
        //parâmetros em que o primeiro é a chamada em si, 
        //onde é possível pegar o nome do método chamado e 
        //os parâmetros passados por exemplo, enquanto o 
        //segundo parâmetro é o resultado que queremos 
        //gerar e devolver para a aplicação em flutter
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger, CHANNEL
        ).setMethodCallHandler {
            call, result ->

            if (call.method == "calcSum") {
                //Aqui estamos pegando o parâmetro com a 
                //chave a que foi passado, e o operador ?
                //é igual no Dart, caso não tenha a chave a
                //será null e com o ? não irá quebrar, e
                //o ?: é um operador do Kotlin para definir
                //um valor padrão que no caso é 0
                val a = call.argument<Int>("a")?.toInt() ?: 0;
                val b = call.argument<Int>("b")?.toInt() ?: 0;

                //Usando o método success do result
                //conseguimos retornar um valor lá para 
                //o Flutter
                result.success(a + b)
            } else {
                result.notImplemented()
            }
        }
    }
}
