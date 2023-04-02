part of 'todo.bloc.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  AddTodoEvent({required this.content});
  final String content;
  @override
  List<Object> get props => [content];
}

class DeleteTodoEvent extends TodoEvent {
  DeleteTodoEvent({required this.id});
  final String id;
  @override
  List<Object> get props => [id];
}

class UpdateTodoStatusEvent extends TodoEvent {
  UpdateTodoStatusEvent({required this.id, required this.isChecked});
  final bool isChecked;
  final String id;
  @override
  List<Object> get props => [id, isChecked];
}
