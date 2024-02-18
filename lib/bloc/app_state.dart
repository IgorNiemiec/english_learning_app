import 'package:english_learning_app/auth/auth_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppState
{
  final bool isLoading;
  final AuthError? authError;


  const AppState({
    required this.isLoading,
    this.authError,
  });

}


@immutable
class AppStateLoggedIn extends AppState
{
   final User user;

   const AppStateLoggedIn(
    {
      required bool isLoading,
      AuthError? authError,
      required this.user,
    }
   ) : super (isLoading: isLoading, authError: authError);


  @override
  bool operator ==(other)
  {
    final otherClass = other;

    if (otherClass is AppStateLoggedIn)
    {
      return isLoading == otherClass.isLoading &&
      user.uid == otherClass.user.uid;
    }
    else
    {
      return false;
    }
  }

  // There is no hashCode

  @override
  String toString() => "AppStateLoggIn";

}


@immutable
class AppStateLoggedOut extends AppState
{

  const AppStateLoggedOut({
      required bool isLoading,
      AuthError? authError,
    }
  ) : super(isLoading: isLoading,authError: authError);

  @override
  String toString() => "AppStateLogOut, isLoading = $isLoading, authError = $authError";


}


@immutable
class AppStateIsInRegistrationView extends AppState
{

  const AppStateIsInRegistrationView(
    {
      required bool isLoading,
      AuthError? authError,
    }
  ) : super(
    isLoading: isLoading,
    authError: authError,
  );

}
