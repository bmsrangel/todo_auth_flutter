import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_auth/app/modules/splash/splash_cubit.dart';
 
void main() {

  blocTest<SplashCubit, int>('emits [1] when increment is added',
    build: () => SplashCubit(),
    act: (cubit) => cubit.increment(),
    expect: () => [1],
  );
}