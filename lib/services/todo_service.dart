import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:demo_bloc/api_demo/todo.dart';

class TodoService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:3000',
    ),
  );

  Future<List<Todo>> fetchAll() async {
    try {
      final Response<dynamic> response = await dio.get('/todos',
          options: Options(
              headers: {"content-type": "text/plain", "accept": "text/plain"},
              contentType: "text"));

      print(response);
      // print('$response');
      // var result = (jsonDecode(response.data) as List);
      // print(result);
      return [];
      // var result = (jsonDecode(response.data) as List)
      //     .map((data) => Todo.fromJson(data))
      //     .toList();

      // return result;
    } on DioError catch (e) {
      print('${e.message} : ${e.stackTrace}');
      throw e;
    }
  }

  Future<Todo> addTodo({required Todo todo}) async {
    final data = todo;
    // print(encodedTodo);
    try {
      final Response response = await dio.post('/todos',
          data: data,
          options: Options(headers: {"Content-Type": "application/json"}));

      print('add todo response: ${response.data}');
      final todo = Todo.fromJson(response.data);
      print('todo: $todo');
      return Todo.fromJson(response.data);
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      throw e;
    }
  }

  Future<Todo> deleteTodo({required Todo todo}) async {
    try {
      final Response response = await dio.delete('/todos/${todo.id}');
      print('deleted response : $response');
      return Todo.fromJson(response.data);
    } on DioError catch (e) {
      throw e;
    }
  }
}
