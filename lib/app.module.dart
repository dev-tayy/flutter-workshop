import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/todo.model.dart';
import 'package:todo_app/services/auth.service.dart';
import 'package:todo_app/utils/hive.db.dart';
import 'package:todo_app/services/todo.service.dart';
import 'package:todo_app/utils/constants.dart';

final GetIt getIt = GetIt.instance;

class AppManager {
  static Future<void> initializeDependencies() async {
    //initialize hive
    await Hive.initFlutter();
    Hive.registerAdapter(TodoModelAdapter());

    getIt
      ..registerLazySingleton<Dio>(Dio.new)
      ..registerLazySingleton<AuthRepository>(AuthRepository.new)
      ..registerLazySingleton<TodoRepository>(() => TodoRepository(getIt()))
      ..registerSingletonAsync<HiveService<List<TodoModel>>>(() async {
        final hiveService = HiveService<List<TodoModel>>();
        await hiveService.open(DbKeys.todoModel);
        return hiveService;
      });
  }
}
