import 'package:flutter_modular/flutter_modular.dart';

import '../../shared/auth/auth_controller.dart';
import 'hide_password_cubit.dart';
import 'login_cubit.dart';
import 'login_page.dart';
import 'pages/cubits/confirm_register_password_cubit.dart';
import 'pages/cubits/register_password_cubit.dart';
import 'pages/register_controller.dart';
import 'pages/register_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => ConfirmRegisterPasswordCubit()),
    Bind.factory((i) => RegisterPasswordCubit()),
    Bind.factory((i) => RegisterController(i.get<AuthController>())),
    Bind.lazySingleton((i) => LoginCubit(i.get<AuthController>())),
    Bind.factory((i) => HidePasswordCubit()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => LoginPage()),
    ChildRoute(
      RegisterPage.route,
      child: (context, args) => RegisterPage(),
    )
  ];
}
