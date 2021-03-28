import '../../shared/models/todo_model.dart';

class TodosState {
  const TodosState();
}

class InitTodosState extends TodosState {
  const InitTodosState();
}

class LoadingTodosState extends TodosState {
  const LoadingTodosState();
}

class LoadedTodosState extends TodosState {
  const LoadedTodosState(this.todos);

  final List<TodoModel> todos;
}

class ErrorTodosState extends TodosState {
  const ErrorTodosState(this.message);

  final String message;
}
