import 'package:bloc_network/business_logic/blocs/todo_bloc/todo_bloc/todo_bloc.dart';
import 'package:bloc_network/business_logic/blocs/todo_bloc/todo_bloc/todo_event.dart';
import 'package:bloc_network/business_logic/blocs/todo_bloc/todo_bloc/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTodoScreen extends StatelessWidget {
  SearchTodoScreen({Key? key}) : super(key: key);

  final _searchNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: TextFormField(
          focusNode: _searchNode,
          decoration: InputDecoration(
            fillColor: Colors.blueGrey.shade50,
            filled: true,
            contentPadding: const EdgeInsets.all(8),
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onChanged: (val){
            BlocProvider.of<TodoBloc>(context).add(SearchTodoEvent(val));
          },
        ),
      ),
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
    );
  }
}
