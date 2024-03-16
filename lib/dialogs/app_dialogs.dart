import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;


const Map<String,AppDialog> appDialogErrorMapping = {
  "user-not-found" : AppDialogUserNotFound(),
  "weak-password" : AppDialogPasswordIsWeak(),
  "invalid-email" : AppDialogInvalidEmail(),
  "operation-not-allowed" : AppDialogOpperationNotAllowed(),
  "email-already-in-use" : AppDialogEmailAlreadyInUse(),
  "requires-recent-login" : AppDialogRequiresRecentLogin(),
  "no-current-user" : AppDialogNoCurrentUser(),
};



@immutable
abstract class AppDialog
{
  final String dialogTitle;
  final String dialogContent;

  const AppDialog({required this.dialogTitle, required this.dialogContent});


  factory AppDialog.fromError(FirebaseAuthException exception) => appDialogErrorMapping[
    exception.code.toLowerCase().trim()] ?? const AppDialogUnknownError();
}


@immutable
class AppDialogWordOfTheDayIsCurrentlyInUserLibrary extends AppDialog
{
  const AppDialogWordOfTheDayIsCurrentlyInUserLibrary() : super(
    dialogTitle: "Word of the day",
    dialogContent: "Word of the day is already in your library"
    );

}

@immutable
class AppDialogWordOfTheDayHasBeenAddedToUserLibrary extends AppDialog
{
  const AppDialogWordOfTheDayHasBeenAddedToUserLibrary() : super(
    dialogTitle: "Word of the day",
    dialogContent: "Word of the day has been succesfully added to my Library"
    );
}

@immutable
class AppDialogPointsExplanation extends AppDialog
{
  const AppDialogPointsExplanation() : super(
    dialogTitle: "What is a word point?",
    dialogContent: "Every time you guess the word you get one point. In the same way for missing word you are loosing one. Amount of the point represents your knowledge of the word",
  );
}

@immutable
class AppDialogWordLevelExplanation extends AppDialog
{
  const AppDialogWordLevelExplanation() : super(
    dialogTitle: "What is word level",
    dialogContent: "Level of the word represents its advance level. A is the lowest and C is the highest",
  );
}

@immutable
class AppDialogRemoveWordDialog extends AppDialog
{
  const AppDialogRemoveWordDialog() : super(
    dialogTitle: "Remove word",
    dialogContent: "Are you sure you want to delete this word from your library?",
  );


}


@immutable
class AppDialogConfirmPasswordIsDifferent extends AppDialog
{
  const AppDialogConfirmPasswordIsDifferent() : super(dialogTitle: "Register error",dialogContent: "Passwords do not match");
}


@immutable
class AppDialogUnknownError extends AppDialog
{
  const AppDialogUnknownError() : super(dialogTitle: "Error",dialogContent: "Unknown Error");
}

@immutable
class AppDialogUserNotFound extends AppDialog
{
  const AppDialogUserNotFound() : super(dialogTitle: "User not found",dialogContent: "We cannot find user");
}

@immutable
class AppDialogPasswordIsWeak extends AppDialog
{
  const AppDialogPasswordIsWeak() : super(dialogTitle: "Password Error",dialogContent: "Password is weak! It has to have at least 6 characters");
}

@immutable
class AppDialogInvalidEmail extends AppDialog
{
  const AppDialogInvalidEmail() : super(dialogTitle: "Problem with email",dialogContent: "Your email is invalid. Make sure you wrote it correctly");
}


@immutable
class AppDialogOpperationNotAllowed extends AppDialog
{
  const AppDialogOpperationNotAllowed() : super(dialogTitle: "Error",dialogContent: "This opperation is not allowed.");
}


@immutable
class AppDialogEmailAlreadyInUse extends AppDialog
{
  const AppDialogEmailAlreadyInUse() : super(dialogTitle: "Problem with email",dialogContent: "This email is currently in use.");
}

@immutable
class AppDialogRequiresRecentLogin extends AppDialog
{
  const AppDialogRequiresRecentLogin() : super(dialogTitle: "Error",dialogContent: "Required recent login");
}

@immutable
class AppDialogNoCurrentUser extends AppDialog
{
  const AppDialogNoCurrentUser() : super(dialogTitle: "Problem with user",dialogContent: "We cannot find user. You are probably logged out");
}
