import 'package:bloc/bloc.dart';

class RegisterPasswordCubit extends Cubit<bool> {
  RegisterPasswordCubit() : super(true);

  void showPassword() {
    emit(!state);
  }
}
