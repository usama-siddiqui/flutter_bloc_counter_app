import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/logic/cubit/internet_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  final InternetCubit internetCubit;

  //StreamSubscription _internetSteamSubscription;

  CounterCubit({@required this.internetCubit})
      : super(CounterState(counterValue: 0)) {
    // monitorInternetCubit();
  }

  // StreamSubscription<InternetState> monitorInternetCubit() {
  //   return _internetSteamSubscription = internetCubit.listen((internetState) {
  //     if (internetState is InternetConnected &&
  //         internetState.connectionType == ConnectionType.Wifi) {
  //       increment();
  //     } else if (internetState is InternetConnected &&
  //         internetState.connectionType == ConnectionType.Mobile) {
  //       decrement();
  //     }
  //   });
  // }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));

  @override
  CounterState fromJson(Map<String, dynamic> json) {
    // Called every time the App needs Stored Data
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(CounterState state) {
    // Called for Every State emitted by Counter Cubit
    //addError(Exception("Could not write to the storage"), StackTrace.current);

    return state.toMap();
  }

  // @override
  // Future<void> close() {
  //   _internetSteamSubscription.cancel();
  //   return super.close();
  // }

  // For Single Bloc or Cubit Debugging

  // @override
  // void onChange(Change<CounterState> change) {
  //   // Called before a new state is dispatched to the stream of states
  //   print(change);
  //   // print("current: " +
  //   //     change.currentState.counterValue.toString() +
  //   //     " next: " +
  //   //     change.nextState.counterValue.toString());
  //   super.onChange(change);
  // }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print("$error $stackTrace");
  //   super.onError(error, stackTrace);
  // }

  /* 
   *For Bloc debuggging:
   *  1) onEvent : Called before a new event is dispatched to the stream of events
   *  2) onTransition: Combination of onChange and onEvent
   */

}
