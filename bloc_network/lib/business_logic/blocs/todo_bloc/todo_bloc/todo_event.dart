import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class TodoEvent extends Equatable {}

class LoadTodoEvent extends TodoEvent{
  @override
  List<Object?> get props => [];
}

class SearchTodoEvent extends TodoEvent{
  final String searchKey;

  SearchTodoEvent(this.searchKey);

  @override
  List<Object?> get props => [];

}