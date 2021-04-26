import 'package:demo_bloc/api_demo/bloc/todos_event.dart';
import 'package:demo_bloc/api_demo/bloc/todos_state.dart';
import 'package:demo_bloc/repositories/todo_repository.dart';
import 'package:demo_bloc/services/todo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../todo.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository todoRepository =
      TodoRepository(todoService: TodoService());

  TodosBloc() : super(TodosLoadInProgress());

  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is TodosLoadSuccessEvent) {
      yield* _mapTodosLoadedToState();
    } else if (event is TodoAddedEvent) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoDeletedEvent) {
      yield* _mapTodoDeletedToState(event);
    } else {
      throw UnimplementedError();
    }
  }

  Stream<TodosState> _mapTodosLoadedToState() async* {
    try {
      final todos = await this.todoRepository.fetchAll();
      yield TodosLoadSuccess(todos: todos);
    } catch (_) {
      yield TodosLoadFailure(message: 'fetchall request failed');
    }
  }

  Stream<TodosState> _mapTodoAddedToState(TodoAddedEvent event) async* {
    try {
      final todo = await todoRepository.addTodo(todo: event.todo);
      print(todo);
      if (state is TodosLoadSuccess) {
        final List<Todo> updatedTodos =
            List.from((state as TodosLoadSuccess).todos)..add(todo);
        yield TodosLoadSuccess(todos: updatedTodos);
      }
    } catch (_) {
      yield TodosLoadFailure(message: 'request on adding todo failed');
    }
  }

  Stream<TodosState> _mapTodoDeletedToState(TodoDeletedEvent event) async* {
    try {
      final data = await todoRepository.deleteTodo(todo: event.todo);
      if (state is TodosLoadSuccess) {
        final updatedTodos = (state as TodosLoadSuccess)
            .todos
            .where((todo) => todo.id != data.id)
            .toList();
        yield TodosLoadSuccess(todos: updatedTodos);
      }
    } catch (_) {
      yield TodosLoadFailure(message: 'required on delete todo failed');
    }
  }
}
