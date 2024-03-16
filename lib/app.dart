
import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/bloc/app_state.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/dialogs/show_appdialog.dart';
import 'package:english_learning_app/loading/loading_screen.dart';
import 'package:english_learning_app/views/commonLibrary_view.dart';
import 'package:english_learning_app/views/commonSingleWord_View.dart';
import 'package:english_learning_app/views/commonTrainingLevelChoice_View.dart';
import 'package:english_learning_app/views/login_view.dart';
import 'package:english_learning_app/views/register_view.dart';
import 'package:english_learning_app/views/singleWord_view.dart';
import 'package:english_learning_app/views/trainingChoice_View.dart';
import 'package:english_learning_app/views/trainingFinalizationLibrary_view.dart';
import 'package:english_learning_app/views/trainingFinalization_view.dart';
import 'package:english_learning_app/views/trainingWords_view.dart';
import 'package:english_learning_app/views/training_view.dart';
import 'package:english_learning_app/views/userLibrary_view.dart';
import 'package:english_learning_app/views/userPanel_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()..add(const AppEventInitialize()),
      child: MaterialApp(
        title: "English Learning App",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AppBloc,AppState>(
          listener: (context, appState) async {

            

              if (appState.isLoading)
              {
                LoadingScreen.instance().show(
                  context: context,
                  text: "Loading");
              }
              else
              {
                LoadingScreen.instance().hide();
              }


             


               final appDialog = appState.appDialog;

              if (appDialog!=null)
              {
                showAppDialog(context: context, dialog: appDialog);
              }

             
              
              
          },
          builder: (context, appState) {

            if(appState is AppStateLoggedOut)
            {
              return LoginView();
            }
            else if (appState is AppStateLoggedIn)
            {
              return UserPanelView(userLibrary: appState.userLibrary);
            }
            else if (appState is AppStateIsInRegistrationView)
            {
              return RegisterView();
            }
            else if (appState is AppStateIsInUserLibraryView)
            {
              return UserLibraryView(
                userLibrary: appState.userLibrary, 
                filteredWords: appState.filteredWords);
            }
            else if (appState is AppStateIsInSingleWordView)
            {
              return SingleWordView(
                userLibrary: appState.userLibrary, 
                filteredWords: appState.filteredWords,
                word: appState.word,);
            }
            else if (appState is AppStateIsInCommonLibraryView)
            {
              return CommonLibraryView(filteredWords: appState.filteredWords, userLibrary: appState.userLibrary);
            }
            else if (appState is AppStateIsInCommonSingleWordView)
            {
              return CommonSingleWordView(
                word: appState.word, 
                filteredWords: appState.filteredWords,
                isWordInUserLibrary: appState.isWordInUserLibrary,
                userLibrary: appState.userLibrary,
                );
            }
            else if(appState is AppStateIsInTrainingChoiceView)
            {
              return TrainingChoiceView(userLibrary: appState.userLibrary,);
            }
            else if (appState is AppStateIsInCommonTrainingLevelChoiceView)
            {
              return CommonTrainingLevelChoiceView(
                userLibrary: appState.userLibrary,
                trainingModeEnum: appState.trainingMode,
                );
            }
            else if (appState is AppStateIsInTrainingView)
            {
              return TrainingView(
                trainingModeEnum: appState.trainingMode,
                keyWordIndex: appState.keyWordIndex,
                userLibrary: appState.userLibrary,
                trainingList: appState.trainingList,
                trainingUnits: appState.trainingUnits,
                keyWord: appState.keyWord, 
                round: appState.round,
                mistakeCounter: appState.mistakesCounter,
                difficultyLevel: appState.level,
                firstWord: appState.firstWord, 
                secondWord: appState.secondWord, 
                thirdWord: appState.thirdWord);
            }
            else if (appState is AppStateIsInTrainingFinalizationView)
            {
              return TrainingFinalizationView(
                trainingUnits: appState.trainingUnits,
                trainingList: appState.trainingList, 
                correctCounter: appState.correctCounter, 
                mistakeCounter: appState.mistakesCounter,
                userLibrary: appState.userLibrary,);
            }
            else if (appState is AppStateIsInTrainingWordsView)
            {
              return TrainingWordsView(trainingWords: appState.trainingWords);
            }
            else if (appState is AppStateIsInTrainingFinalizationLibraryView)
            {
              return TrainingFinalizationLibraryView(
                mistakeCounter: appState.mistakeCounter,
                correctCounter: 50-appState.mistakeCounter,
                userLibrary: appState.userLibrary, 
                trainingUnits: appState.trainingUnits,
                trainingWords: appState.trainingWords);
            }
            else
            {
              return Container();
            }
            
          },
        ),
      ),
      
   
   
   );
  }
}