import 'package:english_learning_app/appEnum/appEnum.dart';
import 'package:english_learning_app/auth/auth_error.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
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
   final UserLibrary userLibrary;

   const AppStateLoggedIn(
    {
      required bool isLoading,
      AuthError? authError,
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
    }
  ) : super(isLoading: isLoading,authError: authError);

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
   }) : super(isLoading: isLoading, authError: authError);

}

@immutable
class AppStateIsInSingleWordView extends AppState
{
  final UserLibrary userLibrary;
  final Word word;

  const AppStateIsInSingleWordView({
    required this.userLibrary,
    required this.word,
    required bool isLoading,
    AuthError? authError,
  }) : super(isLoading: isLoading, authError: authError);

  
}

@immutable
class AppStateIsInCommonSingleWordView extends AppState
{

  final Word word;
  final UserLibrary userLibrary;
  final bool isWordInUserLibrary;

  const AppStateIsInCommonSingleWordView({
    required this.word,
    required bool isLoading,
    required this.isWordInUserLibrary,
    required this.userLibrary,
    AuthError? authError,
  }) : super(
    isLoading: isLoading,
    authError: authError);

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
    }
  ) 
  
  : super(
    isLoading: isLoading, 
    authError: authError);
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

@immutable
class AppStateIsInTrainingChoiceView extends AppState
{

  final UserLibrary userLibrary;

  
  const AppStateIsInTrainingChoiceView({
    required bool isLoading,
    required this.userLibrary,
    AuthError? authError}) : super(isLoading: isLoading,authError: authError);

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
  }) : super(isLoading: isLoading , authError:authError );

}

@immutable
class AppStateIsInTrainingView extends AppState
{
  final DifficultyLevel level;
  final UserLibrary userLibrary;
  final TrainingModeEnum trainingMode;
  final List<Word> trainingList;
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
  }) : super(isLoading: isLoading,authError: authError);
  
}

@immutable
class AppStateIsInTrainingFinalizationView extends AppState
{

  final UserLibrary userLibrary;
  final List<Word> trainingList;
  final int correctCounter;
  final int mistakesCounter;

  const AppStateIsInTrainingFinalizationView({
    required this.userLibrary,
    required this.trainingList,
    required this.correctCounter,
    required this.mistakesCounter,
    required bool isLoading,
    AuthError? authError,
  }) : super(isLoading: isLoading,authError: authError);

}


@immutable
class AppStateIsInTrainingWordsView extends AppState 
{
    final List<Word> trainingWords;

    const AppStateIsInTrainingWordsView({required this.trainingWords,
    required bool isLoading,
    AuthError? authError}) : super(isLoading: isLoading,authError: authError);

}

@immutable
class AppStateIsInTrainingFinalizationLibraryView extends AppState
{

  final UserLibrary userLibrary;
  final List<Word> trainingWords;

  const AppStateIsInTrainingFinalizationLibraryView({
    required this.userLibrary,
    required this.trainingWords,
    required bool isLoading,
    AuthError? authError,
  }) : super(isLoading: false, authError: authError);


}