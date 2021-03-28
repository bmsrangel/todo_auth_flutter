import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_auth/app/modules/login/login_states.dart';

import '../../shared/auth/auth_controller.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._auth$) : super(InitLoginState());

  final TextEditingController email$ = TextEditingController();
  final TextEditingController password$ = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthController _auth$;

  String emailValidation(String value) {
    if (value.isEmpty) {
      return 'E-mail inválido';
    } else {
      return null;
    }
  }

  String passwordValidation(String value) {
    if (value.isEmpty) {
      return 'A senha é obrigatória';
    } else {
      return null;
    }
  }

  Future login() async {
    try {
      emit(LoggingInState());
      await Future.delayed(Duration(seconds: 2));
      await this._auth$.login(email$.text, password$.text);
      if (_auth$.user != null) {
        email$.clear();
        password$.clear();
        Modular.to.navigate('/home', replaceAll: true);
      }
    } catch (e) {
      emit(LoginErrorState());
    }
  }
}
