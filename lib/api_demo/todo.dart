// class TodosResponse {
//   final List<Todo> todos;

//   TodosResponse({required this.todos});

//   TodosResponse.fromJson(Map<String, dynamic> json) : todos = json['todos'];

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['todos'] = this.todos.map((e) => e.toJson());
//     return data;
//   }
// }

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool completed;

  Todo({
    String? id,
    required this.title,
    required this.description,
    this.completed = false,
  }) : id = id ?? Uuid().v4();

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        completed = json['completed'] == 'true';

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['completed'] = this.completed;
    return data;
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, completed: $completed)';
  }

  @override
  List<Object?> get props => [id, title, description, completed];
}
