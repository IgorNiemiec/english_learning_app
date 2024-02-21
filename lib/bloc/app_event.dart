import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent
{
  const AppEvent();
}

@immutable
class AppEventLogOut implements AppEvent
{
  const AppEventLogOut();
}

@immutable
class AppEventLogIn implements AppEvent
{
  final String email;
  final String password;

  const AppEventLogIn({required this.email, required this.password});
}

@immutable
class AppEventLogInWithGoogleAuth implements AppEvent
{
  const AppEventLogInWithGoogleAuth();
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

@immutable
class AppEventInitialize implements AppEvent
{
  const AppEventInitialize();
}