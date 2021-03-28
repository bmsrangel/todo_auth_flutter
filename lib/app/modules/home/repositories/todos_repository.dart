import 'package:dio/dio.dart';

import '../../../shared/models/todo_model.dart';
import 'dtos/todo_dto.dart';

class TodosRepository {
  TodosRepository(this._client);

  final Dio _client;

  Future<List<TodoModel>> getAllTodos() async {
    final Response response = await _client.get('/todos');
    if (response.data == null) {
      return null;
    } else {
      return (response.data as List)
          .map((todoMap) => TodoModel.fromMap(todoMap))
          .toList();
    }
  }

  Future<TodoModel> updateTodo(TodoModel updatedTodo) async {
    final Response response = await _client.patch(
      '/todos/${updatedTodo.id}',
      data: updatedTodo.toMap(),
    );
    return TodoModel.fromMap(response.data);
  }

  Future<TodoModel> addTodo(TodoDto newTodo) async {
    final Response response =
        await _client.post('/todos', data: newTodo.toMap());
    return TodoModel.fromMap(response.data);
  }
}
