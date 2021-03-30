import 'package:bloc_counter_app/logic/cubit/counter_cubit.dart';
import 'package:bloc_counter_app/logic/cubit/internet_cubit.dart';
import 'package:bloc_counter_app/presentation/router/app_router.dart';
import 'package:bloc_counter_app/utility/app_bloc_observer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'logic/cubit/settings_cubit.dart';

void main() async {
  // To execute Native Code
  WidgetsFlutterBinding.ensureInitialized();

  // Links Hydrated bloc with Storage
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  // Attaching Bloc Observer to debug  Bloc/Cubit
  Bloc.observer = AppBlocObserver();

  runApp(MyApp(appRouter: AppRouter(), connectivity: Connectivity()));
}

class MyApp extends StatelessWidget {
  //final CounterCubit _counterCubit = CounterCubit();
  final AppRouter appRouter;
  final Connectivity connectivity;

  MyApp({@required this.appRouter, @required this.connectivity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivity)),
        BlocProvider<CounterCubit>(
            create: (context) => CounterCubit(
                internetCubit: BlocProvider.of<InternetCubit>(context))),
        BlocProvider<SettingsCubit>(
            create: (counterCubitContext) => SettingsCubit(),
            lazy:
                false // By default lazy is true, if its true that means Create cubit/ bloc when needed
            ),
      ],
      child: MaterialApp(
        // routes: {
        //   "/": (context) => BlocProvider.value(
        //         value: _counterCubit,
        //         child: HomeScreen(title: 'Home Screen', color: Colors.blueAccent),
        //       ),
        //   "/second": (context) => BlocProvider.value(
        //       value: _counterCubit,
        //       child:
        //           SecondScreen(title: 'Second Screen', color: Colors.redAccent)),
        //   "/third": (context) => BlocProvider.value(
        //       value: _counterCubit,
        //       child:
        //           ThirdScreen(title: 'Third Screen', color: Colors.greenAccent)),
        // },
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
        // home: BlocProvider<CounterCubit>(
        //   create: (context) => CounterCubit(),
        //   child: HomeScreen(title: 'Home Screen', color: Colors.blueAccent),
        // )
      ),
    );
  }

  // @override
  // void dispose() {
  //   _counterCubit.close();
  //   super.dispose();
  // }
}
