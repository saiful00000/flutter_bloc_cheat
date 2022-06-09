import 'package:bloc_network/business_logic/blocs/todo_bloc/todo_bloc/todo_event.dart';
import 'package:bloc_network/business_logic/blocs/todo_bloc/todo_bloc/todo_state.dart';
import 'package:bloc_network/data/repository/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc(this._repository) : super(TodoLoadingState()) {
    on<LoadTodoEvent>((event, emit) async {
      emit(TodoLoadingState());
      try {
        final todoList = await _repository.getDotos();
        emit(TodoLoadedState(todoList));
      } catch (err) {
        emit(TodoErrorState(err.toString()));
      }
    });
  }
}
