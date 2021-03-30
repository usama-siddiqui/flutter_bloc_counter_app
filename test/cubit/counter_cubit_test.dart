import 'package:bloc_counter_app/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter_app/logic/cubit/internet_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("CounterCubit", () {
    CounterCubit _counterCubit;
    setUp(() {
      _counterCubit = CounterCubit(
          internetCubit: InternetCubit(connectivity: Connectivity()));
    });

    tearDown(() {
      _counterCubit.close();
    });

    test(
        "the initial state for the CounterCubit is CounterState(counterValue:0)",
        () {
      expect(_counterCubit.state, CounterState(counterValue: 0));
    });
    blocTest(
        "the cubit should emit a CounterState(counterValue: 1, wasIncremented: true) when cubit.increment() function is called",
        build: () => _counterCubit,
        act: (cubit) => cubit.increment(),
        expect: [CounterState(counterValue: 1, wasIncremented: true)]);

    blocTest(
        "the cubit should emit a CounterState(counterValue: -1, wasIncremented: false) when cubit.decrement() function is called",
        build: () => _counterCubit,
        act: (cubit) => cubit.decrement(),
        expect: [CounterState(counterValue: -1, wasIncremented: false)]);
  });
}
