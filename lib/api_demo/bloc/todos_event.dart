import 'package:demo_bloc/api_demo/todo.dart';
import 'package:equatable/equatable.dart';

abstract class TodosEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TodosLoadSuccessEvent extends TodosEvent {}

class TodoAddedEvent extends TodosEvent {
  final Todo todo;

  TodoAddedEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodoUpdatedEvent extends TodosEvent {
  final Todo todo;

  TodoUpdatedEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class TodoDeletedEvent extends TodosEvent {
  final Todo todo;

  TodoDeletedEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
