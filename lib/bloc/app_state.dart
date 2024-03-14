import 'package:english_learning_app/appEnum/appEnum.dart';
import 'package:english_learning_app/auth/auth_error.dart';
import 'package:english_learning_app/dialogs/app_dialogs.dart';
import 'package:english_learning_app/models/training_unit.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppState
{
  final bool isLoading;
  final AuthError? authError;
  final AppDialog? appDialog;

  const AppState({
    required this.isLoading,
    this.authError,
    this.appDialog,
  });

}


@immutable
class AppStateLoggedIn extends AppState
{
   final User user;
   final UserLibrary userLibrary;

   const AppStateLoggedIn(
    {
      required bool isLoading,
      AuthError? authError,
      AppDialog? appDialog,
      required this.user,
      required this.userLibrary,
    }
   ) : super (isLoading: isLoading, authError: authError);


  @override
  bool operator ==(other)
  {
    final otherClass = other;

    if (otherClass is AppStateLoggedIn)
    {
      return isLoading == otherClass.isLoading &&
      user.uid == otherClass.user.uid && userLibrary == otherClass.userLibrary;
    }
    else
    {
      return false;
    }
  }


  @override
  int get hashCode => Object.hash(user, userLibrary);

  @override
  String toString() => "AppStateLoggIn";

}


@immutable
class AppStateLoggedOut extends AppState
{

  const AppStateLoggedOut({
      required bool isLoading,
      AuthError? authError,
      AppDialog? appDialog,
    }
  ) : super(isLoading: isLoading,authError: authError,appDialog: appDialog);

  @override
  String toString() => "AppStateLogOut, isLoading = $isLoading, authError = $authError";


}

@immutable
class AppStateIsInUserLibraryView extends AppState
{
   final UserLibrary userLibrary;
   final List<Word> filteredWords;

   const AppStateIsInUserLibraryView({
    required this.userLibrary,
    required this.filteredWords,
    required bool isLoading,
    AuthError? authError,
    AppDialog? appDialog,
   }) : super(isLoading: isLoading, authError: authError,appDialog: appDialog);

}

@immutable
class AppStateIsInSingleWordView extends AppState
{
  final UserLibrary userLibrary;
  final List<Word> filteredWords;

  final Word word;

  const AppStateIsInSingleWordView({
    required this.userLibrary,
    required this.filteredWords,
    required this.word,
    required bool isLoading,
    AuthError? authError,
    AppDialog? appDialog,
  }) : super(isLoading: isLoading, authError: authError,appDialog: appDialog);

}

@immutable
class AppStateIsInCommonSingleWordView extends AppState
{

  final Word word;
  final UserLibrary userLibrary;
  final List<Word> filteredWords;
  final bool isWordInUserLibrary;

  const AppStateIsInCommonSingleWordView({
    required this.word,
    required bool isLoading,
    required this.isWordInUserLibrary,
    required this.filteredWords,
    required this.userLibrary,
    AuthError? authError,
    AppDialog? appDialog,
  }) : super(
    isLoading: isLoading,
    authError: authError,
    appDialog: appDialog);

}




@immutable
class AppStateIsInCommonLibraryView extends AppState
{
  List<Word> filteredWords;
  UserLibrary userLibrary;
  
  AppStateIsInCommonLibraryView(
    {
      required this.filteredWords,
      required bool isLoading,
      required this.userLibrary,
      AuthError? authError,
      AppDialog? appDialog,
    }
  ) 
  
  : super(
    isLoading: isLoading, 
    authError: authError,
    appDialog: appDialog);
}


@immutable
class AppStateIsInRegistrationView extends AppState
{

  const AppStateIsInRegistrationView(
    {
      required bool isLoading,
      AuthError? authError,
      AppDialog? appDialog,
    }
  ) : super(
    isLoading: isLoading,
    authError: authError,
    appDialog: appDialog
  );

}

@immutable
class AppStateIsInTrainingChoiceView extends AppState
{

  final UserLibrary userLibrary;

  
  const AppStateIsInTrainingChoiceView({
    required bool isLoading,
    required this.userLibrary,
    AuthError? authError,
    AppDialog? appDialog,
    }) : super(isLoading: isLoading,authError: authError,appDialog: appDialog);

}

@immutable
class AppStateIsInCommonTrainingLevelChoiceView extends AppState
{
  final UserLibrary userLibrary;
  final TrainingModeEnum trainingMode;

  const AppStateIsInCommonTrainingLevelChoiceView({
    required this.userLibrary,
    required this.trainingMode,
    required bool isLoading,
    AuthError? authError,
    AppDialog? appDialog,
  }) : super(isLoading: isLoading , authError:authError, appDialog: appDialog);

}

@immutable
class AppStateIsInTrainingView extends AppState
{
  final DifficultyLevel level;
  final UserLibrary userLibrary;
  final TrainingModeEnum trainingMode;
  final List<Word> trainingList;
  final List<TrainingUnit> trainingUnits;
  final Word keyWord;
  final Word firstWord;
  final Word secondWord;
  final Word thirdWord;
  final int round;
  final int mistakesCounter;
  final bool? isMistake;
  final int keyWordIndex;
  final int markedIndex;

  const AppStateIsInTrainingView({
    required this.level,
    required this.userLibrary,
    required this.trainingUnits,
    required this.trainingMode,
    required this.trainingList,
    required this.keyWord,
    required this.firstWord,
    required this.secondWord,
    required this.thirdWord,
    required this.round,
    required this.mistakesCounter,
    this.isMistake,
    required this.keyWordIndex,
    required this.markedIndex,
    required bool isLoading,
    AuthError? authError,
    AppDialog? appDialog,
  }) : super(isLoading: isLoading,authError: authError, appDialog: appDialog);
  
}

@immutable
class AppStateIsInTrainingFinalizationView extends AppState
{

  final UserLibrary userLibrary;
  final List<TrainingUnit> trainingUnits;
  final List<Word> trainingList;
  final int correctCounter;
  final int mistakesCounter;

  const AppStateIsInTrainingFinalizationView({
    required this.userLibrary,
    required this.trainingUnits,
    required this.trainingList,
    required this.correctCounter,
    required this.mistakesCounter,
    required bool isLoading,
    AuthError? authError,
    AppDialog? appDialog,
  }) : super(isLoading: isLoading,authError: authError,appDialog: appDialog);

}


@immutable
class AppStateIsInTrainingWordsView extends AppState 
{
    final List<Word> trainingWords;

    const AppStateIsInTrainingWordsView({required this.trainingWords,
    required bool isLoading,
    AuthError? authError,
    AppDialog? appDialog,}) : super(isLoading: isLoading,authError: authError,appDialog: appDialog);

}

@immutable
class AppStateIsInTrainingFinalizationLibraryView extends AppState
{

  final UserLibrary userLibrary;
  final List<TrainingUnit> trainingUnits;
  final List<Word> trainingWords;
  final int mistakeCounter;

  const AppStateIsInTrainingFinalizationLibraryView({
    required this.userLibrary,
    required this.mistakeCounter,
    required this.trainingUnits,
    required this.trainingWords,
    required bool isLoading,
    AuthError? authError,
    AppDialog? appDialog,

  }) : super(isLoading: false, authError: authError,appDialog: appDialog);


}