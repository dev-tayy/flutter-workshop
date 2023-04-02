part of 'todo.bloc.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class GetAllTodosLoading extends TodoState {}

class GetAllTodosSuccess extends TodoState {
  GetAllTodosSuccess({required this.todos});
  final List<TodoModel> todos;
  @override
  List<Object> get props => [todos];
}

class GetAllTodosError extends TodoState {
  GetAllTodosError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class AddTodoLoading extends TodoState {}

class AddTodoSuccess extends TodoState {
  AddTodoSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class AddTodoError extends TodoState {
  AddTodoError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class DeleteTodoLoading extends TodoState {}

class DeleteTodoSuccess extends TodoState {
  DeleteTodoSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class DeleteTodoError extends TodoState {
  DeleteTodoError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}

class UpdateTodoStatusLoading extends TodoState {}

class UpdateTodoStatusSuccess extends TodoState {
  UpdateTodoStatusSuccess({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}

class UpdateTodoStatusError extends TodoState {
  UpdateTodoStatusError({required this.error});
  final String error;
  @override
  List<Object> get props => [error];
}
