import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todo_app/app.module.dart';
import 'package:todo_app/blocs/auth-bloc/auth.bloc.dart';
import 'package:todo_app/blocs/observer.dart';
import 'package:todo_app/blocs/todo-bloc/todo.bloc.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/screens/auth/login.dart';
import 'package:todo_app/services/auth.service.dart';
import 'package:todo_app/services/todo.service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await AppManager.initializeDependencies();
  await getIt.allReady();

  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final authRepo = getIt.get<AuthRepository>();
    final todoRepo = getIt.get<TodoRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(authRepo),
        ),
        BlocProvider<TodoBloc>(
          create: (BuildContext context) => TodoBloc(todoRepo),
        ),
      ],
      child: OverlaySupport.global(
        toastTheme: ToastThemeData(
          textColor: Colors.white,
          background: Colors.red,
          alignment: Alignment.topCenter,
        ),
        child: MaterialApp(
          title: 'Todo App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const LoginScreen(),
        ),
      ),
    );
  }
}
