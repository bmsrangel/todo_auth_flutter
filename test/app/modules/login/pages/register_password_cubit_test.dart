import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_auth/app/modules/login/pages/cubits/register_password_cubit.dart';

void main() {
  blocTest<RegisterPasswordCubit, int>(
    'emits [1] when increment is added',
    build: () => RegisterPasswordCubit(),
    act: (cubit) => cubit.increment(),
    expect: () => [1],
  );
}
