import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_auth/app/modules/login/pages/name_cubit.dart';
 
void main() {

  blocTest<NameCubit, int>('emits [1] when increment is added',
    build: () => NameCubit(),
    act: (cubit) => cubit.increment(),
    expect: () => [1],
  );
}