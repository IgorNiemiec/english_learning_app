import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent
{
  const AppEvent();
}

@immutable
class AppEventLogIn implements AppEvent
{
  final String email;
  final String password;

  const AppEventLogIn({required this.email, required this.password});
}

@immutable
class AppEventGoToRegistration implements AppEvent
{
  const AppEventGoToRegistration();
}

@immutable
class AppEventGoToLogIn implements AppEvent
{
  const AppEventGoToLogIn();
}

@immutable
class AppEventRegister implements AppEvent
{
  final String email;
  final String password;

  const AppEventRegister({
    required this.email,
    required this.password,
  });
}