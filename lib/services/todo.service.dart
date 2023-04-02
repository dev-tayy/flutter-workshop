import 'package:dartz/dartz.dart';
import 'package:todo_app/models/todo.model.dart';
import 'package:todo_app/utils/hive.db.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:uuid/uuid.dart';

class TodoRepository {
  const TodoRepository(this.todoService);
  final HiveService<List<TodoModel>> todoService;

  Either<String, List<TodoModel>> fetchAllTodos() {
    try {
      final response = _getTodos;
      return Right(response);
    } catch (e) {
      return const Left(GENERIC_ERROR);
    }
  }

  Future<Either<String, String>> addTodo(String content) async {
    try {
      final response = _getTodos;

      response.add(TodoModel(
        content: content,
        isDone: false,
        id: const Uuid().v4(),
      ));

      await todoService.put(
        box: DbKeys.todoModel,
        collection: DbKeys.todoModel,
        data: response,
      );

      fetchAllTodos();

      return const Right('Added successfully');
    } catch (e) {
      return const Left(GENERIC_ERROR);
    }
  }

  Future<Either<String, String>> deleteTodo(String id) async {
    try {
      final response = _getTodos;
      response.removeWhere((element) => element.id == id);

      await todoService.put(
        box: DbKeys.todoModel,
        collection: DbKeys.todoModel,
        data: response,
      );

      fetchAllTodos();

      return const Right('Deleted successfully');
    } catch (e) {
      return const Left(GENERIC_ERROR);
    }
  }

  Future<Either<String, String>> updateTodoStatus({
    required String id,
    required bool isDone,
  }) async {
    try {
      final response = _getTodos;

      final todoIndex = response.indexWhere((element) => element.id == id);
      final todo = response[todoIndex];
      todo.isDone = isDone;

      response[todoIndex] = todo;

      await todoService.put(
        box: DbKeys.todoModel,
        collection: DbKeys.todoModel,
        data: response,
      );

      fetchAllTodos();

      return const Right('Updated successfully');
    } catch (e) {
      return const Left(GENERIC_ERROR);
    }
  }

  List<TodoModel> get _getTodos =>
      todoService.get(
          box: DbKeys.todoModel,
          collection: DbKeys.todoModel,
          defaultValue: []) ??
      [];
}
