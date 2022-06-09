import 'package:bloc_network/data/models/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class TodoState extends Equatable {}

class TodoLoadingState extends TodoState {
  @override
  List<Object?> get props => [];
}

class TodoLoadedState extends TodoState {
  final List<Todo> todoList;

  TodoLoadedState(this.todoList);

  @override
  List<Object?> get props => [];
}

class TodoErrorState extends TodoState {
  final String errMessage;

  TodoErrorState(this.errMessage);

  @override
  List<Object?> get props => [];
}
