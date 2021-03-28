import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_auth/app/modules/auth/auth_cubit.dart';
 
void main() {

  blocTest<AuthCubit, int>('emits [1] when increment is added',
    build: () => AuthCubit(),
    act: (cubit) => cubit.increment(),
    expect: () => [1],
  );
}