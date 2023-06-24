import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wear/wear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AmbientMode(
      child: const MyHomePage(title: 'Flutter Demo'),
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // PARA LOS COLORES
            visualDensity: VisualDensity.compact,
            colorScheme: mode == WearMode.active
                ? const ColorScheme.dark(
                    primary: Color(0xFF00B5FF),
                  )
                : const ColorScheme.dark(
                    primary: Color.fromARGB(179, 144, 140, 140),
                    onBackground: Color.fromARGB(168, 152, 144, 144),
                    onSurface: Color.fromARGB(184, 174, 168, 168),
                  ),
          ),
          home: child,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //VARIABLE
  int _counter = 0;

//PARA CONTADOR INCREMENTAR
  void _incrementCounter() {
    if (_counter < 15) {
      setState(() {
        _counter++;
      });
    } else {
      Fluttertoast.showToast(msg: '¡Límite máximo alcanzado!'); // MENSAJE
    }
  }

//PARA CONTADOR DECREMENTAR
  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    } else {
      Fluttertoast.showToast(msg: '¡Límite mínimo alcanzado!'); //MENSAJE
    }
  }

  // para reiniciar el contador
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          const Text(
            'Contador:', // TEXTO DEL CONTADOR
          ),
          const SizedBox(height: 1),
          Expanded(
            child: Center(
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          SizedBox(
            //PARA EL BOTON DEL CONTADOR
            width: 30.0,
            height: 30.0,
            child: FloatingActionButton(
              onPressed: _decrementCounter, //VARIABLE
              tooltip: 'Decrement', //ICONO
              child: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(height: 7),
          //PARA REINICIAR
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: FloatingActionButton(
              onPressed: _resetCounter,
              tooltip: 'Reset',
              child: const Icon(Icons.refresh),
            ),
          ),
          const SizedBox(height: 7),
          //PARA DECREMENTAR
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
