import 'package:demo_bloc/api_demo/todo.dart';
import 'package:demo_bloc/services/todo_service.dart';

class TodoRepository {
  final TodoService todoService;

  TodoRepository({required this.todoService});

  Future<List<Todo>> fetchAll() async {
    return await todoService.fetchAll();
  }

  Future<Todo> addTodo({required Todo todo}) async {
    return await todoService.addTodo(todo: todo);
  }

  Future<Todo> deleteTodo({required Todo todo}) async {
    return await todoService.deleteTodo(todo: todo);
  }
}
