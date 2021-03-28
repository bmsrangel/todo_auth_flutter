import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/models/todo_model.dart';
import 'repositories/dtos/todo_dto.dart';
import 'repositories/todos_repository.dart';
import 'todos_states.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit(this._todosRepository) : super(InitTodosState());

  final TodosRepository _todosRepository;

  final TextEditingController description$ = TextEditingController();
  final GlobalKey<FormState> modalBottomSheetFormKey = GlobalKey<FormState>();

  List<TodoModel> allTodos;

  Future<void> getAllTodos() async {
    try {
      emit(LoadingTodosState());
      allTodos = await _todosRepository.getAllTodos();
      emit(LoadedTodosState(allTodos));
    } catch (e) {
      emit(ErrorTodosState('Failed to load Todos'));
    }
  }

  Future<void> updateTodo(TodoModel currentTodo, bool newValue) async {
    final TodoModel updatedTodo = await _todosRepository
        .updateTodo(currentTodo.copyWith(isCompleted: newValue));
    int indexOfTodo = allTodos.indexWhere((todo) => todo.id == updatedTodo.id);
    allTodos[indexOfTodo] = updatedTodo;
    emit(LoadedTodosState(allTodos));
  }

  Future<void> addTodo() async {
    if (modalBottomSheetFormKey.currentState.validate()) {
      final TodoDto todoDto = TodoDto(description: description$.text);
      try {
        final TodoModel newTodo = await _todosRepository.addTodo(todoDto);
        allTodos.add(newTodo);
        emit(LoadedTodosState(allTodos));
        description$.clear();
        Modular.to.pop();
      } catch (e) {}
    }
  }

  String descriptionValidator(String value) {
    if (value.isEmpty) {
      return 'Campo obrigatório';
    } else {
      return null;
    }
  }
}
