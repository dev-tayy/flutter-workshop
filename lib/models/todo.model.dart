import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/app.module.dart';
import 'package:todo_app/utils/hive.db.dart';
import 'package:todo_app/utils/constants.dart';
part 'todo.model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String content;
  @HiveField(2)
  bool isDone;
  TodoModel({required this.content, required this.isDone, required this.id});
}

List<TodoModel> get todos {
  final storage = getIt.get<HiveService<List<TodoModel>>>();
  return storage.get(
        box: DbKeys.todoModel,
        collection: DbKeys.todoModel,
        defaultValue: [],
      ) ??
      [];
}
