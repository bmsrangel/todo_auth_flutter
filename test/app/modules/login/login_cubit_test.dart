import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_auth/app/modules/login/login_cubit.dart';
 
void main() {

  blocTest<LoginCubit, int>('emits [1] when increment is added',
    build: () => LoginCubit(),
    act: (cubit) => cubit.increment(),
    expect: () => [1],
  );
}