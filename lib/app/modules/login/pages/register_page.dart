import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../shared/widgets/header_widget.dart';
import '../widgets/custom_form_field.dart';
import 'cubits/confirm_register_password_cubit.dart';
import 'cubits/register_password_cubit.dart';
import 'register_controller.dart';

class RegisterPage extends StatefulWidget {
  static final String route = 'register';
  final String title;
  const RegisterPage({Key key, this.title = "RegisterPage"}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final RegisterController _register$ = Modular.get<RegisterController>();

  final RegisterPasswordCubit _registerPassword$ =
      Modular.get<RegisterPasswordCubit>();
  final ConfirmRegisterPasswordCubit _confirmRegisterPassword$ =
      Modular.get<ConfirmRegisterPasswordCubit>();

  @override
  void dispose() {
    _registerPassword$.close();
    _confirmRegisterPassword$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      body: Column(
        children: [
          buildHeader(primaryColor),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _register$.formKey,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 10.0),
                    buildNameField(primaryColor),
                    const SizedBox(height: 15.0),
                    buildEmailField(primaryColor),
                    const SizedBox(height: 15.0),
                    BlocBuilder<RegisterPasswordCubit, bool>(
                      bloc: _registerPassword$,
                      builder: (context, state) =>
                          buildPasswordField(primaryColor, state),
                    ),
                    const SizedBox(height: 15.0),
                    BlocBuilder<ConfirmRegisterPasswordCubit, bool>(
                      bloc: _confirmRegisterPassword$,
                      builder: (context, state) =>
                          buildConfirmPasswordField(primaryColor, state),
                    ),
                    const SizedBox(height: 25.0),
                    buildRegisterButton(),
                    const SizedBox(height: 20.0),
                    buildBackButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader(Color primaryColor) {
    return HeaderWidget(
      backgroundColor: primaryColor,
      child: Text(
        'Registro de usuário',
        style: TextStyle(
          fontSize: 32.0,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildNameField(Color primaryColor) {
    return CustomFormField(
      controller: _register$.name$,
      labelText: 'Nome',
      cursorColor: primaryColor,
      validationFunction: _register$.nameValidation,
    );
  }

  Widget buildEmailField(Color primaryColor) {
    return CustomFormField(
      controller: _register$.email$,
      labelText: 'E-mail',
      cursorColor: primaryColor,
      keyboardType: TextInputType.emailAddress,
      validationFunction: _register$.emailValidation,
    );
  }

  Widget buildPasswordField(Color primaryColor, bool state) {
    return CustomFormField(
      controller: _register$.password$,
      labelText: 'Senha',
      cursorColor: primaryColor,
      obscureText: state,
      suffixIcon: state ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: _registerPassword$.showPassword,
      validationFunction: _register$.passwordValidation,
    );
  }

  Widget buildConfirmPasswordField(Color primaryColor, bool state) {
    return CustomFormField(
      controller: _register$.confirmPassword$,
      labelText: 'Confirmação da senha',
      cursorColor: primaryColor,
      obscureText: state,
      suffixIcon: state ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: _confirmRegisterPassword$.showPassword,
      validationFunction: _register$.confirmPasswordValidation,
    );
  }

  Widget buildRegisterButton() {
    return Container(
      height: 50.0,
      child: ElevatedButton(
        onPressed: _register$.register,
        child: Text('Registrar'),
      ),
    );
  }

  Widget buildBackButton() {
    return Container(
      height: 50.0,
      child: OutlinedButton(
        onPressed: Modular.to.pop,
        child: Text('Voltar'),
      ),
    );
  }
}
