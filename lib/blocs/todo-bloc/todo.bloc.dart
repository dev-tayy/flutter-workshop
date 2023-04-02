import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/todo.model.dart';
import 'package:todo_app/services/todo.service.dart';

part 'todo.event.dart';
part 'todo.state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this._todoRepository) : super(TodoInitial()) {
    on<GetAllTodosEvent>((event, emit) {
      emit(GetAllTodosLoading());
      final response = _todoRepository.fetchAllTodos();
      response.fold(
        (error) => emit(GetAllTodosError(error: error)),
        (data) => emit(GetAllTodosSuccess(todos: data)),
      );
    });
    on<AddTodoEvent>((event, emit) async {
      emit(AddTodoLoading());
      final response = await _todoRepository.addTodo(event.content);
      response.fold(
        (error) => emit(AddTodoError(error: error)),
        (data) => emit(AddTodoSuccess(message: data)),
      );
    });
    on<DeleteTodoEvent>((event, emit) async {
      emit(DeleteTodoLoading());
      final response = await _todoRepository.deleteTodo(event.id);
      response.fold(
        (error) => emit(DeleteTodoError(error: error)),
        (data) => emit(DeleteTodoSuccess(message: data)),
      );
    });
    on<UpdateTodoStatusEvent>((event, emit) async {
      emit(UpdateTodoStatusLoading());
      final response = await _todoRepository.updateTodoStatus(
        id: event.id,
        isDone: event.isChecked,
      );
      response.fold(
        (error) => emit(UpdateTodoStatusError(error: error)),
        (data) => emit(UpdateTodoStatusSuccess(message: data)),
      );
    });
  }
  final TodoRepository _todoRepository;
}
