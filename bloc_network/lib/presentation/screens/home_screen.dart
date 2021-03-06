import 'package:bloc_network/data/repository/todo_repository.dart';
import 'package:bloc_network/presentation/router/app_route_names.dart';

import '../../business_logic/blocs/todo_bloc/todo_bloc/todo_bloc.dart';
import '../../business_logic/blocs/todo_bloc/todo_bloc/todo_event.dart';
import '../../business_logic/blocs/todo_bloc/todo_bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TodoErrorState) {
            return Center(
              child: Text(
                state.errMessage.toString(),
              ),
            );
          } else if (state is TodoLoadedState) {
            return ListView.builder(
              itemCount: state.todoList.length,
              itemBuilder: (context, index) {
                bool completed = state.todoList[index].completed ?? false;

                return ListTile(
                  title: Text(state.todoList[index].title ?? ''),
                  trailing: Icon(
                    Icons.circle,
                    color: completed ? Colors.green : Colors.red,
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AppRouteNames.SEARCH_TODO_SCREEN);
        },
        backgroundColor: Colors.purple.shade900,
        child: const Icon(Icons.search),
      ),
    );
  }
}
