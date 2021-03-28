import 'package:bloc/bloc.dart';

class ConfirmRegisterPasswordCubit extends Cubit<bool> {
  ConfirmRegisterPasswordCubit() : super(true);

  void showPassword() {
    emit(!state);
  }
}
