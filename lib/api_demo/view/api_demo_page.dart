import 'package:demo_bloc/api_demo/bloc/todos_bloc.dart';
import 'package:demo_bloc/api_demo/bloc/todos_event.dart';
import 'package:demo_bloc/api_demo/bloc/todos_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../todo.dart';

class ApiDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Demo'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              context.read<TodosBloc>().add(TodoAddedEvent(
                  todo: Todo(
                      title: 'add teste', description: 'test description')));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            'Todo List',
            style: Theme.of(context).textTheme.headline4,
          ),
          Expanded(
            child: Container(
              child: TodoList(),
            ),
          )
        ],
      ),
    );
  }
}

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TodosBloc>().add(TodosLoadSuccessEvent());
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        print(state);
        if (state is TodosLoadInProgress) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TodosLoadFailure) {
          return Center(child: CircularProgressIndicator());
        } else if (state is TodosLoadSuccess) {
          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(state.todos[index].title),
                      subtitle: Text(state.todos[index].description),
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        print(state.todos[index]);
                        context
                            .read<TodosBloc>()
                            .add(TodoDeletedEvent(todo: state.todos[index]));
                      },
                    ),
                  )
                ],
              );
            },
          );
        }

        return Container();
        // return ListView.builder(

        //     )
      },
    );
  }
}
