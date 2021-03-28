import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_auth/app/modules/login/login_states.dart';
import 'package:todo_auth/app/shared/mixins/messages_mixin.dart';

import '../../shared/mixins/loader_mixin.dart';
import '../../shared/widgets/header_widget.dart';
import 'hide_password_cubit.dart';
import 'login_cubit.dart';
import 'pages/register_page.dart';
import 'widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  static final String route = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoaderMixin, MessagesMixin {
  final LoginCubit login$ = Modular.get<LoginCubit>();
  final HidePasswordCubit hidePassword$ = Modular.get<HidePasswordCubit>();
  Color primaryColor;

  @override
  void initState() {
    login$.listen((state) {
      if (state is LoggingInState) {
        showHideLoaderHelper(context, true);
      } else if (state is LoginErrorState) {
        showHideLoaderHelper(context, false);
        showError(
          message: 'Falha no login. Verifique usuário ou senha.',
          context: context,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    login$.close();
    hidePassword$.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          HeaderWidget(
            backgroundColor: primaryColor,
            height: screenHeight * .15,
            child: Text(
              'Bem-vindo ao F-Tasks',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: login$.formKey,
                child: ListView(
                  children: [
                    buildEmailField(),
                    const SizedBox(height: 20.0),
                    BlocBuilder<HidePasswordCubit, bool>(
                      bloc: hidePassword$,
                      builder: (context, state) => buildPasswordField(state),
                    ),
                    const SizedBox(height: 20.0),
                    buildLoginButton(context),
                    const SizedBox(height: 20.0),
                    buildSignInButton(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignInButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .2),
      height: 50.0,
      child: OutlinedButton(
        child: Text(
          'Registrar',
        ),
        onPressed: () {
          Modular.to.pushNamed(RegisterPage.route);
        },
      ),
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .2),
      height: 50.0,
      child: ElevatedButton(
        child: Text('Entrar'),
        onPressed: () {
          if (login$.formKey.currentState.validate()) {
            login$.login();
          }
        },
      ),
    );
  }

  Widget buildPasswordField(bool state) {
    return CustomFormField(
      cursorColor: primaryColor,
      controller: login$.password$,
      validationFunction: login$.passwordValidation,
      labelText: 'Password',
      obscureText: state,
      suffixIcon: state ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: hidePassword$.showPassword,
    );
  }

  Widget buildEmailField() {
    return CustomFormField(
      cursorColor: primaryColor,
      controller: login$.email$,
      keyboardType: TextInputType.emailAddress,
      validationFunction: login$.emailValidation,
      labelText: 'E-mail',
    );
  }
}
