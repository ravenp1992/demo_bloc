import 'package:demo_bloc/api_demo/bloc/todos_bloc.dart';
import 'package:demo_bloc/api_demo/view/api_demo_page.dart';
import 'package:demo_bloc/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/api':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => TodosBloc(),
                  child: ApiDemoPage(),
                ));
      default:
        throw Exception('route not found');
    }
  }
}
