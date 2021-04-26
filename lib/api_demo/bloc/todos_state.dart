import 'package:demo_bloc/api_demo/todo.dart';
import 'package:equatable/equatable.dart';

abstract class TodosState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodosLoadInProgress extends TodosState {}

class TodosLoadSuccess extends TodosState {
  final List<Todo> todos;

  TodosLoadSuccess({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodosLoadFailure extends TodosState {
  final String message;

  TodosLoadFailure({required this.message});

  @override
  List<Object> get props => [message];
}
