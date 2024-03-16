import 'package:english_learning_app/appEnum/appEnum.dart';
import 'package:english_learning_app/models/training_unit.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

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
  final String confirmPassword;


  const AppEventRegister({
    required this.email,
    required this.password,
    required this.confirmPassword,
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
  final List<Word> filteredList;

  const AppEventGoToUserLibraryView({
    required this.userLibrary,
    required this.filteredList});
}

@immutable
class AppEventGoToSingleWordView implements AppEvent
{
  final UserLibrary userLibrary;
  final List<Word> filteredWords;
  final Word word;

  const AppEventGoToSingleWordView({
    required this.userLibrary,
    required this.filteredWords,
    required this.word,
  });
 
}

@immutable
class AppEventRemoveWordFromUserLibrary implements AppEvent
{

  final UserLibrary userLibrary;
  final List<Word> filteredWords;
  final Word word;
  final bool isInSingleWordView;

  const AppEventRemoveWordFromUserLibrary({
    required this.userLibrary,
    required this.filteredWords,
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
  final WordLevelEnum wordLevel;

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
  final List<Word> filteredList;
  final UserLibrary userLibrary;

  const AppEventGoToCommonSingleWord({
    required this.filteredList,
    required this.word,
    required this.userLibrary});
}

@immutable
class AppEventFilterUserLibraryByWordLevel implements AppEvent
{
  final UserLibrary userLibrary;
  final WordLevelEnum wordLevel;

  const AppEventFilterUserLibraryByWordLevel({
    required this.userLibrary,
    required this.wordLevel,
  });
}


@immutable
class AppEventAddWordToUserLibrary implements AppEvent
{
  final Word word;
  final List<Word> filteredWords;
  final UserLibrary userLibrary;

  const AppEventAddWordToUserLibrary({
    required this.filteredWords,
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

@immutable
class AppEventGoToCommonTrainingChoieView implements AppEvent
{
  final UserLibrary userLibrary;
  final TrainingModeEnum trainingMode;

  const AppEventGoToCommonTrainingChoieView({
    required this.userLibrary,
    required this.trainingMode});

}


@immutable
class AppEventGoToTrainingView implements AppEvent
{

  final UserLibrary userLibrary;
  final DifficultyLevel difficultyLevel;
  final TrainingModeEnum trainingModeEnum;

  const AppEventGoToTrainingView({
    required this.userLibrary,
    required this.difficultyLevel,
    required this.trainingModeEnum,
  });

}

@immutable
class AppEventUpdateTrainingView implements AppEvent
{
  final UserLibrary userLibrary;
  final TrainingModeEnum trainingMode;
  final List<Word> trainingList;
  final List<TrainingUnit> trainingUnits;
  final DifficultyLevel difficultyLevel;
  final Word keyWord;
  final Word firstWord;
  final Word secondWord;
  final Word thirdWord;
  final int round;
  final int mistakes;
  final bool isMistake;
  final int keyWordIndex;
  final int markedIndex;

  const AppEventUpdateTrainingView({
    required this.userLibrary,
    required this.trainingUnits,
    required this.trainingMode,
    required this.trainingList,
    required this.difficultyLevel,
    required this.round,
    required this.mistakes,
    required this.isMistake,
    required this.keyWordIndex,
    required this.markedIndex,
    required this.keyWord,
    required this.firstWord,
    required this.secondWord,
    required this.thirdWord,
  });


}


@immutable
class AppEventGoToTrainingFinalizationView implements AppEvent
{
  final UserLibrary userLibrary;
  final TrainingModeEnum trainingMode;
  final List<Word> trainingList;
  final List<TrainingUnit> trainingUnits;
  final int correctCounter;
  final int mistakesCounter;

  const AppEventGoToTrainingFinalizationView({
    required this.userLibrary,
    required this.trainingUnits,
    required this.trainingMode,
    required this.trainingList,
    required this.correctCounter,
    required this.mistakesCounter,
  });
} 




@immutable
class AppEventGoToTrainingWordsView implements AppEvent
{ 
  final List<Word> trainingList;

  const AppEventGoToTrainingWordsView({
    required this.trainingList,
  });

}

@immutable
class AppEventSaveTrainingWordsInUserLibrary implements AppEvent
{
  final UserLibrary userLibrary;
  final List<Word> trainingWords;

  const AppEventSaveTrainingWordsInUserLibrary({
    required this.trainingWords,
    required this.userLibrary,
    });
}

@immutable
class AppEventFinishLibraryTraining implements AppEvent
{

  final UserLibrary userLibrary;
  final List<TrainingUnit> trainingUnits;
  final List<Word> trainingWords;
  final int mistakeCounter;

  const AppEventFinishLibraryTraining({
    required this.mistakeCounter,
    required this.trainingWords,
    required this.trainingUnits,
    required this.userLibrary,
  });
}

@immutable
class AppEventGoToUserPanelView implements AppEvent
{
  final UserLibrary userLibrary;

  const AppEventGoToUserPanelView({required this.userLibrary});
}


// AppDialogsExperiment

@immutable
class AppEventShowWordPointsExplanation implements AppEvent
{
  final UserLibrary userLibrary;
  final List<Word> filteredWords;
  final Word word;

  const AppEventShowWordPointsExplanation({
    required this.userLibrary, 
    required this.word,
    required this.filteredWords,});
} 

@immutable
class AppEventShowWordLevelExplanation implements AppEvent
{
  final UserLibrary userLibrary;
  final List<Word> filteredWords;
  final Word word;

  const AppEventShowWordLevelExplanation({
    required this.userLibrary, 
    required this.word,
    required this.filteredWords,});

}


