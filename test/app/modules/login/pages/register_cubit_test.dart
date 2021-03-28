import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_auth/app/modules/login/pages/register_cubit.dart';
 
void main() {

  blocTest<RegisterCubit, int>('emits [1] when increment is added',
    build: () => RegisterCubit(),
    act: (cubit) => cubit.increment(),
    expect: () => [1],
  );
}