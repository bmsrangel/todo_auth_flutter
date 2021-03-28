import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_auth/app/modules/home/todos_cubit.dart';
 
void main() {

  blocTest<TodosCubit, int>('emits [1] when increment is added',
    build: () => TodosCubit(),
    act: (cubit) => cubit.increment(),
    expect: () => [1],
  );
}