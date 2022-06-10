import 'package:bloc_network/data/models/todo.dart';

import 'todo_event.dart';
import 'todo_state.dart';
import '../../../../data/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc(this._repository) : super(TodoLoadingState()) {
    List<Todo> todoList = [];
    List<Todo> searchedList = [];


    on<LoadTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      try {
        todoList = await _repository.getDotos();
        emit(TodoLoadedState(todoList));
      } catch (err) {
        emit(TodoErrorState(err.toString()));
      }
    });

    on<SearchTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      //await Future.delayed(const Duration(seconds: 3));
      try {
        searchedList.clear();
        for(var v in todoList){
          String title = v.title ?? '';
          if(title.contains(event.searchKey)){
            searchedList.add(v);
          }
        }

        if(searchedList.isEmpty) {
          searchedList.addAll(todoList);
        }
        emit(TodoLoadedState(searchedList));
      } catch (err) {
        emit(TodoErrorState(err.toString()));
      }
    });
  }
}
