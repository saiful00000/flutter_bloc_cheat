import 'dart:convert';

import 'package:bloc_network/data/models/todo.dart';
import 'package:http/http.dart' as http;

class TodoRepository{
  Future<List<Todo>> getDotos() async {
    try{
      final List<Todo> todoList = [];

      final Uri url = Uri.parse('https://jsonplaceholder.typicode.com/todos');
      final response = await http.get(url);

      if(response.statusCode == 200){
        final decodedBody = jsonDecode(response.body);
        for(var json in decodedBody){
          todoList.add(Todo.fromJson(json));
        }
      }
      return todoList;
    }catch(err){
      throw Exception(err);
    }
  }
}