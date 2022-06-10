import 'package:bloc_network/business_logic/blocs/todo_bloc/todo_bloc/todo_bloc.dart';
import 'package:bloc_network/business_logic/blocs/todo_bloc/todo_bloc/todo_event.dart';
import 'package:bloc_network/data/repository/todo_repository.dart';
import 'package:bloc_network/presentation/router/app_route_names.dart';
import 'package:bloc_network/presentation/screens/home_screen.dart';
import 'package:bloc_network/presentation/screens/search_todo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {

  final TodoBloc _todoBloc = TodoBloc(TodoRepository())..add(LoadTodoEvent());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRouteNames.HOME_SCREEN:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _todoBloc,
              child: const HomeScreen(),
            ),
        );
      case AppRouteNames.SEARCH_TODO_SCREEN:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: _todoBloc,
              child: SearchTodoScreen(),
            ),
        );
      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }


  void dispose(){
    _todoBloc.close();
  }
}
