import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
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
class AppEventAddWordOfTheDayToUserLibrary implements AppEvent
{
  final UserLibrary userLibrary;

  const AppEventAddWordOfTheDayToUserLibrary({
    required this.userLibrary,
  });

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

@immutable
class AppEventGoToUserLibraryView implements AppEvent
{
  final UserLibrary userLibrary;

  const AppEventGoToUserLibraryView({required this.userLibrary});
}

@immutable
class AppEventGoToSingleWordView implements AppEvent
{
  final UserLibrary userLibrary;
  final Word word;

  const AppEventGoToSingleWordView({
    required this.userLibrary,
    required this.word,
  });
 
}

@immutable
class AppEventRemoveWordFromUserLibrary implements AppEvent
{

  final UserLibrary userLibrary;
  final Word word;
  final bool isInSingleWordView;

  const AppEventRemoveWordFromUserLibrary({
    required this.userLibrary,
    required this.word,
    required this.isInSingleWordView,
  });

}

@immutable
class AppEventGoToCommonLibrary implements AppEvent
{
  final UserLibrary userLibrary;
  const AppEventGoToCommonLibrary({required this.userLibrary});
}


@immutable
class AppEventFilterCommonLibrary implements AppEvent
{
  final UserLibrary userLibrary;
  final String wordName;

  const AppEventFilterCommonLibrary({
    required this.wordName,
    required this.userLibrary});
}

@immutable
class AppEventFilterCommonLibraryByWordLevel implements AppEvent
{
  final UserLibrary userLibrary;
  final String wordLevel;

  const AppEventFilterCommonLibraryByWordLevel({
    required this.wordLevel,
    required this.userLibrary,
  });

}

@immutable
class AppEventFilterUserLibrary implements AppEvent
{
  final UserLibrary userLibrary;
  final String wordName;

  const AppEventFilterUserLibrary({
    required this.wordName,
    required this.userLibrary});

}

@immutable
class AppEventGoToCommonSingleWord implements AppEvent
{

  final Word word;
  final UserLibrary userLibrary;

  const AppEventGoToCommonSingleWord({
    required this.word,
    required this.userLibrary});
}

@immutable
class AppEventFilterUserLibraryByWordLevel implements AppEvent
{
  final UserLibrary userLibrary;
  final String wordLevel;

  const AppEventFilterUserLibraryByWordLevel({
    required this.userLibrary,
    required this.wordLevel,
  });
}


@immutable
class AppEventAddWordToUserLibrary implements AppEvent
{
  final Word word;
  final UserLibrary userLibrary;

  const AppEventAddWordToUserLibrary({
    required this.userLibrary,
    required this.word,
  });

}

@immutable
class AppEventGoToTrainingChoiceView implements AppEvent
{

  final UserLibrary userLibrary;

  const AppEventGoToTrainingChoiceView({required this.userLibrary});
  
}


