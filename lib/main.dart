import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wear/wear.dart';

// Eventos
abstract class CounterEvent {}

class IncrementEvent extends CounterEvent {}

class DecrementEvent extends CounterEvent {}

// Cubit
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0); //STADO INICIAL EN 0

//PARA CONTADOR INCREMENTAR
  void increment() {
    if (state < 15) {
      emit(state + 1);
    } else {
      Fluttertoast.showToast(msg: '¡Límite máximo alcanzado!');
    }
  }

//PARA CONTADOR DECREMENTAR
  void decrement() {
    if (state > 0) {
      emit(state - 1);
    } else {
      Fluttertoast.showToast(msg: '¡Límite mínimo alcanzado!');
    }
  }

  //PARA REINICIAR EL CONTADOR
  void reset() {
    emit(0);
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AmbientMode(
      child: BlocProvider(
        create: (_) =>
            CounterCubit(), //  ´ROPORCIONA UNA INSTANCIA A TODAS LAS APPS
        child: const MyHomePage(title: 'Flutter Demo'),
      ),
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final counterCubit = BlocProvider.of<CounterCubit>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          const Text(
            'Contador:',
          ),
          const SizedBox(height: 1),
          Expanded(
            child: Center(
              // SE AGREGA EL CONTADOR
              child: BlocBuilder<CounterCubit, int>(
                builder: (context, state) {
                  return Text(
                    '$state',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
            ),
          ),
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: FloatingActionButton(
              // se agrega la funcion de CUBIT CON EL DECREMENTO
              onPressed: () => counterCubit.decrement(),
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ),
          const SizedBox(height: 7),
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: FloatingActionButton(
              // se agrega el cubit con el reinicio del contador
              onPressed: () => counterCubit.reset(),
              tooltip: 'Reset',
              child: const Icon(Icons.refresh),
            ),
          ),
          const SizedBox(height: 7),
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: FloatingActionButton(
              // SE AGREGA EL CONTADOR DE INCREMENTO CON EL EVENTO DE CUBIT
              onPressed: () => counterCubit.increment(),
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
