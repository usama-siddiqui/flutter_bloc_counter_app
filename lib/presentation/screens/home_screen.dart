import 'package:bloc_counter_app/constants/enums.dart';
import 'package:bloc_counter_app/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter_app/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return
        // BlocListener<InternetCubit, InternetState>(
        //     listener: (context, state) {
        //       if (state is InternetConnected &&
        //           state.connectionType == ConnectionType.Wifi) {
        //         BlocProvider.of<CounterCubit>(context).increment();
        //       } else if (state is InternetConnected &&
        //           state.connectionType == ConnectionType.Mobile) {
        //         BlocProvider.of<CounterCubit>(context).decrement();
        //       }
        //     },
        //     child:
        Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () => Navigator.pushNamed(context, '/settings')),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _internetBlocBuilder(),
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  _counterConsumer(),
                  SizedBox(height: 24),
                  _internetAndCounterBuilder(),
                  SizedBox(height: 24),
                  _counterBuilder(),
                  SizedBox(height: 24),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/second");
                    },
                    color: Colors.redAccent,
                    child: Text("Go to Second Screen"),
                  ),
                  SizedBox(height: 24),
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/third");
                    },
                    color: Colors.greenAccent,
                    child: Text("Go to Third Screen"),
                  )
                ],
              ),
            ),
            floatingActionButton: _floatingActionButton()
            //)
            );
  }

  _internetBlocBuilder() {
    return BlocBuilder<InternetCubit, InternetState>(builder: (context, state) {
      if (state is InternetConnected &&
          state.connectionType == ConnectionType.Wifi) {
        return Text("Wifi");
      } else if (state is InternetConnected &&
          state.connectionType == ConnectionType.Mobile) {
        return Text("Mobile");
      } else if (state is InternetDisconnected) {
        return Text("Disconnected");
      }
      return CircularProgressIndicator();
    });
  }

  _floatingActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: Text("${widget.title}"),
          onPressed: () {
            context.read<CounterCubit>().increment();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
        SizedBox(width: 20),
        FloatingActionButton(
          heroTag: Text("${widget.title} # 2"),
          onPressed: () {
            context.read<CounterCubit>().decrement();
          },
          tooltip: 'Decrement',
          child: Icon(Icons.remove),
        ),
      ],
    );
  }

  _internetAndCounterBuilder() {
    return Builder(builder: (context) {
      final counterState = context.watch<CounterCubit>().state;
      final internetState = context.watch<InternetCubit>().state;
      if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Wifi) {
        return Text(
          'Counter: ' +
              counterState.counterValue.toString() +
              ' Internet: Wifi',
        );
      } else if (internetState is InternetConnected &&
          internetState.connectionType == ConnectionType.Mobile) {
        return Text(
          'Counter: ' +
              counterState.counterValue.toString() +
              ' Internet: Mobile',
        );
      } else {
        return Text(
          'Counter: ' +
              counterState.counterValue.toString() +
              ' Internet: Disconnected',
        );
      }
    });
  }

  _counterConsumer() {
    return BlocConsumer<CounterCubit, CounterState>(
      listener: (context, state) {
        if (state.wasIncremented) {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Incremented!"),
              duration: Duration(milliseconds: 300)));
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Decremented!"),
              duration: Duration(milliseconds: 300)));
        }
      },
      builder: (context, state) {
        return Text(
          '${state.counterValue}',
          style: Theme.of(context).textTheme.headline4,
        );
      },
    );
  }

  _counterBuilder() {
    return Builder(builder: (context) {
      final counterValue = context.select(
          (CounterCubit counterCubit) => counterCubit.state.counterValue);
      return Text(
        'Counter: ' + counterValue.toString(),
      );
    });
  }
}
