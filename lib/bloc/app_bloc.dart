
import 'dart:collection';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning_app/appEnum/appEnum.dart';
import 'package:english_learning_app/auth/auth_error.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/bloc/app_state.dart';
import 'package:english_learning_app/dialogs/app_dialogs.dart';
import 'package:english_learning_app/dialogs/wotd_isAlreadyInLibrary_Dialog.dart';
import 'package:english_learning_app/extensions/extensions.dart';
import 'package:english_learning_app/models/training_unit.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/models/wotd.dart';
import 'package:english_learning_app/wordStorage/words.dart';
import 'package:english_learning_app/wordStorage/words_A.dart';
import 'package:english_learning_app/wordStorage/words_C.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AppBloc extends Bloc<AppEvent,AppState>
{

  AppBloc() : super(const AppStateLoggedOut(isLoading: false))
  {

    on<AppEventLogOut>((event, emit) {
      emit(const AppStateLoggedOut(isLoading: false));
      },
    );


    on<AppEventInitialize>((event, emit) async {
      
      final user = FirebaseAuth.instance.currentUser;

      if (user == null)
      {
        emit(const AppStateLoggedOut(isLoading: false));
      }
      else
      {

        // Cache!!!!
        
        try
        {

          final userLibrary = await _getUserLibrary(user.uid);

          final wotd = await _updateWordOfTheDay(user.uid, userLibrary!.wordOfTheDay);

          emit(AppStateLoggedIn(
            isLoading: false, 
            user: user,
            userLibrary: UserLibrary(words: userLibrary!.words,wordOfTheDay: wotd)));
 

        }
        on FirebaseAuthException catch (e)
        {

          emit(AppStateLoggedOut(isLoading: false,
          authError: AuthError.from(e)));

        }
        on FirebaseException catch (e)
        {
          emit(const AppStateLoggedOut(isLoading: false,
          authError: AuthErrorUnknown()));
        }

      
      }



    },);

    on<AppEventGoToRegistration>((event, emit) {
      
      emit(const AppStateIsInRegistrationView(isLoading: false));

    },);

    on<AppEventGoToUserLibraryView>((event, emit) {
      emit( AppStateIsInUserLibraryView(
        userLibrary: event.userLibrary, 
        filteredWords: event.userLibrary.words,
        isLoading: false));
    },);

    on<AppEventGoToTrainingView>((event, emit) {

        late List<Word> trainingList;
        Random rnd = Random();


        if (event.trainingModeEnum == TrainingModeEnum.COMMON_TRAINING)
        {
              trainingList = _getTrainingList(event.userLibrary, event.difficultyLevel);
        }
        else if (event.trainingModeEnum == TrainingModeEnum.USER_LIBRARY_TRAINING)
        {
            if (event.userLibrary.words.length < 31)
            {

              // Should be Dialog concerning inappropriate length

              emit(AppStateIsInTrainingChoiceView(
                isLoading: false, 
                userLibrary: event.userLibrary));

              return;
            }
            
              trainingList = _generateTrainingListFromUserLibrary(event.userLibrary, rnd);
        }

    
        

        Word keyWord = trainingList[rnd.nextInt(trainingList.length)];

        late Word w1;
        late Word w2;
        late Word w3;

        int keyWordIndex = rnd.nextInt(3)+1;

        (Word fakeWord1, Word fakeWord2) fakeWords = _getFakeWords(keyWord: keyWord, level: event.difficultyLevel);

        switch(keyWordIndex)
        {
          case 1:
          w1 = keyWord;
          w2 = fakeWords.$1;
          w3 = fakeWords.$2;
          case 2:
          w1 = fakeWords.$1;
          w2 = keyWord;
          w3 = fakeWords.$2;
          case 3:
          w1 = fakeWords.$1;
          w2 = fakeWords.$2;
          w3 = keyWord;
        }

        emit(
          AppStateIsInTrainingView(
            trainingMode: event.trainingModeEnum,
            trainingUnits: [],
            markedIndex: 1,
            keyWordIndex: keyWordIndex,
            level: event.difficultyLevel,
            userLibrary: event.userLibrary,
            trainingList: trainingList,
            keyWord: keyWord, 
            firstWord: w1, 
            secondWord: w2, 
            thirdWord: w3,
            round: 1,
            mistakesCounter: 0,
            isMistake: false,
            isLoading: false
            
            )
        );
        
    },);

    on<AppEventUpdateTrainingView>((event, emit) 
    {

        List<TrainingUnit> trainingUnits = event.trainingUnits;
        List<Word> trainingList = event.trainingList;
        final Word updatedWord;
        int mistakesCounter = event.mistakes;

        if(event.isMistake)
        {
          trainingUnits.add(TrainingUnit(word: event.keyWord, isPointGained: false));
          updatedWord = Word.updatePoints(keyWord: event.keyWord, points: event.keyWord.points-1);
          mistakesCounter++;
        }
        else
        {
          trainingUnits.add(TrainingUnit(word: event.keyWord, isPointGained: true));
          updatedWord = Word.updatePoints(keyWord: event.keyWord, points: event.keyWord.points+1);
          mistakesCounter--;
        }

         trainingList.remove(event.keyWord);
         trainingList.add(updatedWord);


        if(event.round==50)
        {

          if(event.trainingMode == TrainingModeEnum.COMMON_TRAINING)
          {

             emit(
              AppStateIsInTrainingFinalizationView(
                userLibrary: event.userLibrary, 
                trainingUnits: trainingUnits, 
                trainingList: trainingList, 
                correctCounter: 50-mistakesCounter, 
                mistakesCounter: mistakesCounter, 
                isLoading: false)
             );

          }
          else if (event.trainingMode == TrainingModeEnum.USER_LIBRARY_TRAINING)
          {

              emit(
                AppStateIsInTrainingFinalizationLibraryView(
                  mistakeCounter: event.mistakes,
                  trainingUnits: event.trainingUnits,
                  userLibrary: event.userLibrary, 
                  trainingWords: event.trainingList, 
                  isLoading: false)
              );

          }

          return;

        }

        Random rnd = Random();

        Word keyWord = trainingList[rnd.nextInt(trainingList.length)];
        late Word w1;
        late Word w2;
        late Word w3;

        int keyWordIndex = rnd.nextInt(3)+1;

        (Word fakeWord1, Word fakeWord2) fakeWords = _getFakeWords(keyWord: keyWord, level: event.difficultyLevel);

        switch(keyWordIndex)
        {
          case 1:
          w1 = keyWord;
          w2 = fakeWords.$1;
          w3 = fakeWords.$2;
          case 2:
          w1 = fakeWords.$1;
          w2 = keyWord;
          w3 = fakeWords.$2;
          case 3:
          w1 = fakeWords.$1;
          w2 = fakeWords.$2;
          w3 = keyWord;
        }


        if(event.isMistake)
        {

           emit(
             AppStateIsInTrainingView(
               trainingMode: event.trainingMode,
               trainingUnits: trainingUnits,
               markedIndex: event.markedIndex,
               keyWordIndex: keyWordIndex,
               level: event.difficultyLevel,
               userLibrary: event.userLibrary,
               trainingList: trainingList, 
               keyWord: keyWord, 
               firstWord: w1, 
               secondWord: w2, 
               thirdWord: w3, 
               round: event.round+1, 
               mistakesCounter: event.mistakes+1, 
               isMistake: false, 
               isLoading: false));

        }
        else
        {

          emit(
            AppStateIsInTrainingView(
              trainingMode: event.trainingMode,
              trainingUnits: trainingUnits,
              markedIndex: 1,
              keyWordIndex: keyWordIndex,
              level: event.difficultyLevel,
              userLibrary: event.userLibrary, 
              trainingList: trainingList, 
              keyWord: keyWord, 
              firstWord: w1, 
              secondWord: w2, 
              thirdWord: w3, 
              round: event.round+1, 
              mistakesCounter: event.mistakes, 
              isLoading: false));

        }

    },);


    on<AppEventLogIn>((event, emit) async {

      emit(const AppStateLoggedOut(isLoading: true));

      try
      {

        final email = event.email;

        final password = event.password;

        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

        final user = userCredential.user!;

        final userLibrary = await _getUserLibrary(user.uid);

        final wotd = await _updateWordOfTheDay(user.uid, userLibrary!.wordOfTheDay);

        userLibrary.wordOfTheDay = wotd;

        emit(AppStateLoggedIn(
          isLoading: false,
          user: user,
          userLibrary: userLibrary!,
          ));


      }
      on FirebaseAuthException catch(e)
      {
        emit(
          AppStateLoggedOut(isLoading: false,
          authError: AuthError.from(e))
        );
      }
      on FirebaseException catch(e)
      {
        emit(
          const  AppStateLoggedOut(isLoading: false,
          authError: AuthErrorUnknown())
        );
      }


    },);


    on<AppEventLogInWithGoogleAuth>((event, emit) async {
        emit(const AppStateLoggedOut(isLoading: true));

        try
        {
          await GoogleSignIn().signOut();
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

         final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

         final user = userCredential.user!;

         UserLibrary? userLibrary;


         if(await isUserDocumentCreated(user.uid))
         {
            userLibrary = await _getUserLibrary(user.uid);
         }
         else
         {
            WordOfTheDay wordOfTheDay = _generateWordOfTheDay();

            await _createUserLibrary(user.uid,wordOfTheDay);

      
      
            userLibrary = UserLibrary(words: [],wordOfTheDay: wordOfTheDay);
         }


         emit(AppStateLoggedIn(isLoading: false, user: user,userLibrary: userLibrary!));
          

        }
        on FirebaseAuthException catch(e)
        {
          emit(AppStateLoggedOut(isLoading: false,
          authError: AuthError.from(e)));
        }
        on FirebaseException catch(e)
        {
          emit(
            const  AppStateLoggedOut(isLoading: false,
            authError: AuthErrorUnknown())
          );
        }

    },);

    on<AppEventGoToLogIn>((event, emit) {
      emit(const AppStateLoggedOut(isLoading: false));
    },);

    on<AppEventGoToCommonSingleWord>((event, emit) {

      if(event.userLibrary.words.contains(event.word))
      {
        emit(
          AppStateIsInCommonSingleWordView(
            word: event.word, 
            isLoading: false, 
            isWordInUserLibrary: true,
            filteredWords: event.filteredList,
            userLibrary: event.userLibrary)
        );
      }
      else
      {
        emit(
          AppStateIsInCommonSingleWordView(
            word: event.word, 
            isLoading: false, 
            isWordInUserLibrary: false, 
            filteredWords: event.filteredList,
            userLibrary: event.userLibrary)
        );
      }

        

    },);

    on<AppEventRemoveWordFromUserLibrary>((event, emit) async {

      try
      {

        final user = FirebaseAuth.instance.currentUser;

        if(event.isInSingleWordView)
        {       
         emit(AppStateIsInSingleWordView(
          userLibrary: event.userLibrary, 
          filteredWords: event.filteredWords,
          word: event.word, 
          isLoading: true));
        }
        else
        {
          emit(AppStateIsInCommonSingleWordView(
            word: event.word, 
            isLoading: true, 
            isWordInUserLibrary: true, 
            filteredWords: event.filteredWords,
            userLibrary: event.userLibrary));
        }


        UserLibrary newLibrary = event.userLibrary;

        newLibrary.words.remove(event.word);

        await _updateUserLibrary(user!.uid, newLibrary);

        if(event.isInSingleWordView)
        { 
          emit(AppStateIsInUserLibraryView(userLibrary: newLibrary, filteredWords: newLibrary.words, isLoading: false));
        }
        else
        {
          emit(AppStateIsInCommonSingleWordView(
            word: event.word, 
            isLoading: false, 
            isWordInUserLibrary: false, 
            filteredWords: event.filteredWords,
            userLibrary: newLibrary));
        }


      }
      catch(ex)
      {
             emit(AppStateIsInSingleWordView(
              userLibrary: event.userLibrary, 
              word: event.word, 
              isLoading: false,
              filteredWords: event.filteredWords,
             authError: const AuthErrorUnknown()));
      }
       


    },);

    on<AppEventGoToSingleWordView>((event, emit) {

      emit( AppStateIsInSingleWordView(
        userLibrary: event.userLibrary, 
        filteredWords: event.filteredWords,
        word: event.word, 
        isLoading: false));
    },);

    on<AppEventRegister>((event, emit) async {
      
      emit(const AppStateIsInRegistrationView(isLoading: true));

      final email = event.email;
      final password = event.password;

      try
      {
        final credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        WordOfTheDay wordOfTheDay = _generateWordOfTheDay();


        _createUserLibrary(credentials.user!.uid,wordOfTheDay);


        


        emit(AppStateLoggedIn(
          isLoading: false, 
          user: credentials.user!,
          userLibrary: UserLibrary(words: [],wordOfTheDay: wordOfTheDay)));

      }
      on FirebaseAuthException catch (e)
      {
        emit(AppStateIsInRegistrationView(
        isLoading: false,
        authError: AuthError.from(e)));
      }

    },);

   on<AppEventFilterUserLibrary>((event, emit) {

      emit(
        AppStateIsInUserLibraryView(
          userLibrary: event.userLibrary, 
          filteredWords: event.userLibrary.words,
          isLoading: true)
      );

       final filteredWords =  event.userLibrary.words.where((word) => word.wordEn.toLowerCase().contains(event.wordName.toLowerCase()) || word.wordPl.toLowerCase().contains(event.wordName.toLowerCase())).toList(); 

       emit(
        AppStateIsInUserLibraryView(
          userLibrary: event.userLibrary,
          filteredWords: filteredWords,
          isLoading: false));

   },);

   on<AppEventGoToCommonLibrary>((event, emit) {

      List<Word> wordInitialList = wordsA + wordsC + words;
      
      emit(
        AppStateIsInCommonLibraryView(filteredWords: wordInitialList, isLoading: false,userLibrary: event.userLibrary)
      );

   },);

   on<AppEventFilterCommonLibrary>((event, emit) {

     final filteredList = wordsA.where((word) => word.wordEn.contains(event.wordName) || word.wordPl.contains(event.wordName)).toList() + 
     words.where((word) => word.wordEn.contains(event.wordName) || word.wordPl.contains(event.wordName)).toList() +
     wordsC.where((word) => word.wordEn.contains(event.wordName) || word.wordPl.contains(event.wordName)).toList();

     emit(
      AppStateIsInCommonLibraryView(filteredWords: filteredList, isLoading: false,userLibrary: event.userLibrary)
     );
     
   },);

   

   on<AppEventFilterCommonLibraryByWordLevel>((event, emit) {

      emit(
        AppStateIsInCommonLibraryView(
          filteredWords: [], 
          isLoading: true, 
          userLibrary: event.userLibrary)
      );

      switch(event.wordLevel)
      {
        case WordLevelEnum.A:
        emit(
          AppStateIsInCommonLibraryView(
            filteredWords: wordsA, 
            isLoading: false, 
            userLibrary: event.userLibrary)
        );
        break;
        case WordLevelEnum.B:
         emit(
          AppStateIsInCommonLibraryView(
            filteredWords: words, 
            isLoading: false, 
            userLibrary: event.userLibrary)
        );
        break;
        case WordLevelEnum.C:
         emit(
          AppStateIsInCommonLibraryView(
            filteredWords: wordsC, 
            isLoading: false, 
            userLibrary: event.userLibrary)
        );
        break;
        case WordLevelEnum.ALL:
         emit(
          AppStateIsInCommonLibraryView(
            filteredWords: words + wordsA+ wordsC, 
            isLoading: false, 
            userLibrary: event.userLibrary)
        );
        break;
        default:
         emit(
          AppStateIsInCommonLibraryView(
            filteredWords: wordsA+words+wordsC, 
            isLoading: false, 
            userLibrary: event.userLibrary)
        );
        break;
      }

   },);

   on<AppEventAddWordToUserLibrary>((event, emit) async {

    
         final user = FirebaseAuth.instance.currentUser;

         if (user== null)
         {
           emit(
            const AppStateLoggedOut(isLoading: false,authError: AuthErrorNoCurrentUser())
           );
         }
         else
         {


            emit(
            AppStateIsInCommonSingleWordView(
              word: event.word, 
              isLoading: true, 
              isWordInUserLibrary: false, 
              filteredWords: event.filteredWords,
              userLibrary: event.userLibrary)
           );

          try
          {

            UserLibrary newUserLibrary = event.userLibrary;

            newUserLibrary.words.add(event.word);

            await _updateUserLibrary(user.uid, newUserLibrary);

            emit(
              AppStateIsInCommonSingleWordView(
                word: event.word, 
                isLoading: false, 
                isWordInUserLibrary: true, 
                filteredWords: event.filteredWords,
                userLibrary: newUserLibrary)
            );

          }
          on FirebaseAuthException catch(e)
          {
            emit(
             AppStateLoggedOut(isLoading: false,authError: AuthError.from(e))
           );
          }
          on FirebaseException catch (e)
          {
            emit(
              AppStateIsInCommonSingleWordView(
                word: event.word, 
                isLoading: false, 
                isWordInUserLibrary: false, 
                filteredWords: event.filteredWords,
                userLibrary: event.userLibrary)
            );
          }
         }


   },);

   on<AppEventGoToCommonTrainingChoieView>((event, emit) {
      emit(AppStateIsInCommonTrainingLevelChoiceView(
        userLibrary: event.userLibrary, 
        isLoading: false,
        trainingMode: event.trainingMode));
   },);


   on<AppEventAddWordOfTheDayToUserLibrary>((event, emit) async {

      final user = FirebaseAuth.instance.currentUser;

      if (user != null)
      {

        if(_isWordInUserLibrary(event.userLibrary.wordOfTheDay.wotd, event.userLibrary))
        {
            emit(AppStateLoggedIn(isLoading: false, user: user, userLibrary: event.userLibrary,appDialog: const AppDialogWordOfTheDayIsCurrentlyInUserLibrary()));
        }
        else
        {

            emit(AppStateLoggedIn(isLoading: true, user: user, userLibrary: event.userLibrary));

        try
        {

          UserLibrary newUserLibrary = event.userLibrary;

          newUserLibrary.words.add(event.userLibrary.wordOfTheDay.wotd);

          await _updateUserLibrary(user.uid, newUserLibrary);
        
          emit(
            AppStateLoggedIn(isLoading: false, user: FirebaseAuth.instance.currentUser!, userLibrary: newUserLibrary,appDialog: const AppDialogWordOfTheDayHasBeenAddedToUserLibrary())
          );

  
          }
          on FirebaseAuthException catch(e)
          {
            emit(AppStateLoggedIn(isLoading: false, user: user, userLibrary: event.userLibrary,
            authError: AuthError.from(e)));
          }
          on FirebaseAuth catch(e)
          {
            emit(
              AppStateLoggedIn(isLoading: false, user: user, userLibrary: event.userLibrary,authError: const AuthErrorUnknown())
            );
          }


        }



      }
      else
      {

        emit(const AppStateLoggedOut(isLoading: false,authError: AuthErrorNoCurrentUser()));

      }





    
    

   },);


    on<AppEventGoToTrainingChoiceView>((event, emit) {
      emit(AppStateIsInTrainingChoiceView(isLoading: false, userLibrary: event.userLibrary));
    },);



   on<AppEventFilterUserLibraryByWordLevel>((event, emit) {

      emit(
        AppStateIsInUserLibraryView(
          userLibrary: event.userLibrary, 
          filteredWords: event.userLibrary.words,
          isLoading: true)
      );

      late List<Word> filteredWords;


      
      switch(event.wordLevel)
      {
        case WordLevelEnum.A:
        filteredWords = event.userLibrary.words.where((word) => word.wordLevel == 'A').toList();
        case WordLevelEnum.B:
        filteredWords = event.userLibrary.words.where((word) => word.wordLevel == 'B').toList();
        case WordLevelEnum.C:
        filteredWords = event.userLibrary.words.where((word) => word.wordLevel == 'C').toList();
        case WordLevelEnum.ALL:
        filteredWords = event.userLibrary.words;
        default:
        filteredWords = event.userLibrary.words;
      }


        emit(
             AppStateIsInUserLibraryView(
          userLibrary: event.userLibrary, 
          filteredWords: filteredWords,
          isLoading: false));
   

   },);

   on<AppEventGoToTrainingFinalizationView>((event, emit) {

      if(event.trainingMode == TrainingModeEnum.COMMON_TRAINING)
      {
           emit(
           AppStateIsInTrainingFinalizationView(
             userLibrary: event.userLibrary,
             trainingUnits: event.trainingUnits,
             trainingList: event.trainingList, 
             correctCounter: event.correctCounter, 
             mistakesCounter: event.mistakesCounter, 
             isLoading: false)
             );
      }
      else if (event.trainingMode == TrainingModeEnum.USER_LIBRARY_TRAINING)
      {

           emit(
             AppStateIsInTrainingFinalizationLibraryView(
              mistakeCounter: event.mistakesCounter,
              trainingUnits: event.trainingUnits,
               userLibrary: event.userLibrary, 
               trainingWords: event.trainingList, 
               isLoading: false)
           );

      }




      

   },);

   on<AppEventGoToTrainingWordsView>((event, emit) {

    emit(AppStateIsInTrainingWordsView(trainingWords: event.trainingList, isLoading: false));

   },);

  on<AppEventSaveTrainingWordsInUserLibrary>((event, emit) async {

    User? user = FirebaseAuth.instance.currentUser;

    if(user!= null)
    {


      try
      { 

        emit(AppStateIsInTrainingWordsView(trainingWords: event.trainingWords, isLoading: true));

        UserLibrary newUserLibrary = event.userLibrary;

        await _addTrainingWordsToUserLibrary(user.uid, event.trainingWords);

        newUserLibrary.words.addAll(event.trainingWords);

        emit(
          AppStateLoggedIn(isLoading: false, user: user, userLibrary: newUserLibrary)
        );

      }
      catch(ex)
      {

        emit(
          AppStateIsInTrainingWordsView(trainingWords: event.trainingWords, isLoading: false, authError: AuthErrorUnknown())

        );

      }

    }
    else
    {

      emit(
        const AppStateLoggedOut(isLoading: false,authError: AuthErrorNoCurrentUser())
      );

    }

  

  },);

  on<AppEventFinishLibraryTraining>((event, emit) async
  {

      emit(
        AppStateIsInTrainingFinalizationLibraryView(
          mistakeCounter: event.mistakeCounter,
          trainingUnits: event.trainingUnits,
          userLibrary: event.userLibrary, 
          trainingWords: event.trainingWords, 
          isLoading: true)
      );
    
    User? user = FirebaseAuth.instance.currentUser;

    if(user!=null)
    {

  
      UserLibrary newUserLibrary = event.userLibrary;

      for(var word in event.trainingWords)
      {
  
         newUserLibrary.words.where((element) => element==word).first.setPoints(word.points);
  
      }

       await _updateUserLibrary(user.uid, newUserLibrary);

       emit(
        AppStateLoggedIn(
          isLoading: false, 
          user: user, 
          userLibrary: newUserLibrary)
       );

    }
    else
    {


      emit(
        AppStateIsInTrainingFinalizationLibraryView(
          mistakeCounter: event.mistakeCounter,
          trainingUnits: event.trainingUnits,
          userLibrary: event.userLibrary, 
          trainingWords: event.trainingWords, 
          isLoading: false)
      );


    }


  },);


   on<AppEventGoToUserPanelView>((event, emit) {
     
      User? user = FirebaseAuth.instance.currentUser;

      if (user!=null)
      {
        emit(
          AppStateLoggedIn(isLoading: false, user: user, userLibrary: event.userLibrary)
        );
      }
      else
      {
        emit(
          const AppStateLoggedOut(isLoading: false,authError: AuthErrorNoCurrentUser())
        );
      }


   },);

   // AppDialogsExperiment


    on<AppEventShowWordPointsExplanation>((event, emit) {
      
      emit(AppStateIsInSingleWordView(
        userLibrary: event.userLibrary, 
        filteredWords: event.filteredWords,
        word: event.word, 
        isLoading: false,
        appDialog: const AppDialogPointsExplanation()
        ));

    },);

    on<AppEventShowWordLevelExplanation>((event, emit) {
      
      emit(
        AppStateIsInSingleWordView(
          userLibrary: event.userLibrary,
          filteredWords: event.filteredWords, 
          word: event.word, 
          isLoading: false,
          appDialog: const AppDialogWordLevelExplanation())
      );

    },);




    

  }





  Future<UserLibrary?> _getUserLibrary(String userId) async
  {
      final userDoc = await FirebaseFirestore.instance.collection("UserLibrary").doc(userId).get();

      return UserLibrary.fromJson(userDoc.data()!);
  }

  Future<WordOfTheDay> _updateWordOfTheDay(String userId,WordOfTheDay wotd) async
  {

    final DateTime wotdTimestamp = DateTime.fromMillisecondsSinceEpoch(wotd.timestamp);

    final difference = DateTime.now().difference(wotdTimestamp).inDays;

    if (difference > 1)
    {

      
      WordOfTheDay wordOfTheDay = _generateWordOfTheDay();

      while(wotd.wotd==wordOfTheDay.wotd)
      {
        wotd = _generateWordOfTheDay();
      }


      FirebaseFirestore database = FirebaseFirestore.instance;

      CollectionReference collectionReference = database.collection('UserLibrary');

      await collectionReference.doc(userId).update({"wordOfTheDay" : wordOfTheDay.toJson()});

      return wordOfTheDay;

    }

    return wotd;

  }




  Future<bool> isUserDocumentCreated(String userId) async
  {
      final userDoc =  await FirebaseFirestore.instance.collection("UserLibrary").doc(userId).get();
    
      if (userDoc.exists)
      {
        return true;
      }
      else
      {
        return false;
      }
  }

  Future<void> _createUserLibrary(String userId,WordOfTheDay wotd) async
  {
    
    FirebaseFirestore database = FirebaseFirestore.instance;

    CollectionReference collectionReference = database.collection('UserLibrary');

  

    UserLibrary userLibrary = UserLibrary(words: [],wordOfTheDay: wotd);

    await collectionReference.doc(userId).set(userLibrary.toJson());

  }

  bool _isWordInUserLibrary(Word word,UserLibrary userLibrary)
  {
   return userLibrary.words.contains(word);
  }

  Future<void> _updateUserLibrary(String userId, UserLibrary userLibrary) async
  {

    FirebaseFirestore database = FirebaseFirestore.instance;

    CollectionReference collectionReference = database.collection("UserLibrary");

    await collectionReference.doc(userId).update(userLibrary.toJson());

  }



  Future<void> _addTrainingWordsToUserLibrary(String userId, List<Word> trainingWords) async
  {

     FirebaseFirestore database = FirebaseFirestore.instance;

     CollectionReference collectionReference = database.collection("UserLibrary");

     var words = [];

     for(var word in trainingWords)
     {
      words.add(word.toJson());
     }

     await collectionReference.doc(userId).update({"words": FieldValue.arrayUnion(words)});

  }

  


  WordOfTheDay _generateWordOfTheDay()
  {
    
    Random random = Random();

    int wotdIndex = random.nextInt(words.length);

    int timestamp = DateTime.now().millisecondsSinceEpoch;

    return WordOfTheDay(
      wotd: words[wotdIndex],
      timestamp: timestamp);

  }

  List<Word> _getTrainingList(UserLibrary userLibrary, DifficultyLevel level)
  {
    Random rnd = Random();
    List<Word> trainingList = [];

    List<Word> wordSource;

    switch(level)
    {
      case DifficultyLevel.A:
      wordSource = wordsA;
      case DifficultyLevel.B:
      wordSource = words;
      case DifficultyLevel.C:
      wordSource = wordsC;
      case DifficultyLevel.MixedAB:
      wordSource = wordsA + words;
      case DifficultyLevel.MixedBC:
      wordSource = words + wordsC;
      case DifficultyLevel.MixedABC:
      wordSource = words + wordsA + wordsC;
      default:
      wordSource = [];
    }

    int i =0;
    int j = 0;

    while(i<30)
    {
      Word word = wordSource[rnd.nextInt(wordSource.length)];
      j++;

      if(trainingList.contains(word)==false && userLibrary.words.contains(word)==false)
      {
        trainingList.add(word);
        i++;
      }

      if(j>100)
      {
        break;
      }


    }

    return trainingList;


  }

  (Word w1, Word w2) _getFakeWords({
    required Word keyWord,
    required DifficultyLevel level,
  })
  {

    Random rnd = Random();

    switch(level)
    {
      case DifficultyLevel.A:
      return _getRandomWords(wordsA, rnd, keyWord);
      case DifficultyLevel.B:
      return _getRandomWords(words, rnd, keyWord);
      case DifficultyLevel.C:
      return _getRandomWords(wordsC, rnd, keyWord);
      case DifficultyLevel.MixedAB:
      return _getRandomWords(wordsA+words, rnd, keyWord);
      case DifficultyLevel.MixedBC:
      return _getRandomWords(words+wordsC, rnd, keyWord);
      case DifficultyLevel.MixedABC:
      return _getRandomWords(words+wordsA+wordsC, rnd, keyWord);
    }


  }


  
  (Word w1,Word w2) _getRandomWords(List<Word> listOfWords,Random rnd,Word keyWord)
  {
    Word word1 = listOfWords[rnd.nextInt(listOfWords.length)];
    while(word1==keyWord)
    {
      word1 = listOfWords[rnd.nextInt(listOfWords.length)];
    }

    Word word2 = listOfWords[rnd.nextInt(listOfWords.length)];
    while(word2==keyWord || word2==word1)
    {
      word2 = listOfWords[rnd.nextInt(listOfWords.length)];
    }

    return (word1,word2);
  }



  List<Word> _generateTrainingListFromUserLibrary(UserLibrary userLibrary,Random rnd)
  {

    Set<Word> list = {};

    while(list.length<=30)
    {

      int randomToken = rnd.nextInt(100);

      late Word? word;


       if(randomToken < 30)
        {
          word = userLibrary.words.where((word) => word.points < 5).toList().getRandomElement(rnd);
        }
        else if(randomToken >= 30 && randomToken < 50)
        {
          word = userLibrary.words.where((word) => word.points >= 5 && word.points < 8).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 50 && randomToken < 60)
        {
          word = userLibrary.words.where((word) => word.points >= 8 && word.points < 11).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 60 && randomToken < 69)
        {
          word = userLibrary.words.where((word) => word.points >= 11 && word.points < 13).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 69 && randomToken < 77)
        {
          word = userLibrary.words.where((word) => word.points >= 13 && word.points < 16).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 77 && randomToken < 83)
        {
          word = userLibrary.words.where((word) => word.points >= 16 && word.points < 18).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 83 && randomToken < 88)
        {
          word = userLibrary.words.where((word) => word.points >= 18 && word.points < 20).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 88 && randomToken < 92)
        {
          word = userLibrary.words.where((word) => word.points >= 20 && word.points < 22).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 92 && randomToken < 95)
        {
          word = userLibrary.words.where((word) => word.points >= 22 && word.points < 25).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 95 && randomToken < 97)
        {
          word = userLibrary.words.where((word) => word.points >= 25 && word.points < 27).toList().getRandomElement(rnd);
        }
        else if (randomToken >= 97 && randomToken < 99)
        {
          word = userLibrary.words.where((word) => word.points >= 27 && word.points < 30).toList().getRandomElement(rnd);
        }
        else 
        {
          word = userLibrary.words.where((word) => word.points >= 30).toList().getRandomElement(rnd);
        }

        if(word!= null)
        {
          
        list.add(word);

        }


    }

    return list.toList();

  }

}