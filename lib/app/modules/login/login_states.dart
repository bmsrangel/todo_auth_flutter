abstract class LoginState {
  const LoginState();
}

class InitLoginState extends LoginState {
  const InitLoginState();
}

class LoggingInState extends LoginState {
  const LoggingInState();
}

class LoginErrorState extends LoginState {
  const LoginErrorState();
}
