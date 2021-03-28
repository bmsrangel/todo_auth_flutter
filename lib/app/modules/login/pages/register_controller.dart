import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/auth/auth_controller.dart';

class RegisterController {
  RegisterController(this._auth$);

  final TextEditingController name$ = TextEditingController();
  final TextEditingController email$ = TextEditingController();
  final TextEditingController password$ = TextEditingController();
  final TextEditingController confirmPassword$ = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final AuthController _auth$;

  String nameValidation(String value) {
    if (value.isEmpty) {
      return 'Nome é obrigatório';
    } else {
      return null;
    }
  }

  String emailValidation(String value) {
    if (value.isEmpty) {
      return 'E-mail inválido';
    } else {
      return null;
    }
  }

  String passwordValidation(String value) {
    if (value.isEmpty) {
      return 'Senha é obrigatória';
    } else {
      return null;
    }
  }

  String confirmPasswordValidation(String value) {
    if (value.isEmpty) {
      return 'Senha é obrigatória';
    } else if (value != password$.text) {
      return 'As senhas não conferem';
    } else {
      return null;
    }
  }

  Future<void> register() async {
    if (formKey.currentState.validate()) {
      await _auth$.register(name$.text, email$.text, password$.text);
      Modular.to.pop();
    }
  }
}
