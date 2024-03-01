
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning_app/auth/auth_error.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/bloc/app_state.dart';
import 'package:english_learning_app/dialogs/add_wotd_dialog.dart';
import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:english_learning_app/dialogs/show_auth_error.dart';
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
          AppStateIsInCommonSingleWordView(word: event.word, isLoading: false, isWordInUserLibrary: true,userLibrary: event.userLibrary)
        );
      }
      else
      {
        emit(
          AppStateIsInCommonSingleWordView(word: event.word, isLoading: false, isWordInUserLibrary: false, userLibrary: event.userLibrary)
        );
      }

        

    },);

    on<AppEventRemoveWordFromUserLibrary>((event, emit) async {

      try
      {

        final user = FirebaseAuth.instance.currentUser;

        if(event.isInSingleWordView)
        {       
         emit(AppStateIsInSingleWordView(userLibrary: event.userLibrary, word: event.word, isLoading: true));
        }
        else
        {
          emit(AppStateIsInCommonSingleWordView(word: event.word, isLoading: true, isWordInUserLibrary: true, userLibrary: event.userLibrary));
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
          emit(AppStateIsInCommonSingleWordView(word: event.word, isLoading: false, isWordInUserLibrary: false, userLibrary: newLibrary));
        }


      }
      catch(ex)
      {
             emit(AppStateIsInSingleWordView(userLibrary: event.userLibrary, word: event.word, isLoading: false,
             authError: const AuthErrorUnknown()));
      }
       


    },);

    on<AppEventGoToSingleWordView>((event, emit) {
      emit( AppStateIsInSingleWordView(userLibrary: event.userLibrary, word: event.word, isLoading: false));
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
      if (event.wordLevel == "A")
      {
        emit(
          AppStateIsInCommonLibraryView(filteredWords: wordsA, isLoading: false,userLibrary: event.userLibrary )
        );
      }
      else if (event.wordLevel == "B")
      {
        emit(
          AppStateIsInCommonLibraryView(filteredWords: words, isLoading: false,userLibrary: event.userLibrary )
        );
      }
      else if (event.wordLevel == "C")
      {
        emit(
          AppStateIsInCommonLibraryView(filteredWords: wordsC, isLoading: false,userLibrary: event.userLibrary)
        );
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
            AppStateIsInCommonSingleWordView(word: event.word, isLoading: true, isWordInUserLibrary: false, userLibrary: event.userLibrary)
           );

          try
          {

            UserLibrary newUserLibrary = event.userLibrary;

            newUserLibrary.words.add(event.word);

            await _updateUserLibrary(user.uid, newUserLibrary);

            emit(
              AppStateIsInCommonSingleWordView(word: event.word, isLoading: false, isWordInUserLibrary: true, userLibrary: newUserLibrary)
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
              AppStateIsInCommonSingleWordView(word: event.word, isLoading: false, isWordInUserLibrary: false, userLibrary: event.userLibrary)
            );
          }





         }







      

     


   },);



   on<AppEventAddWordOfTheDayToUserLibrary>((event, emit) async {

     if (_isWordInUserLibrary(event.userLibrary.wordOfTheDay.wotd, event.userLibrary))
     {

      

     }
     else
     {

        
      final user = FirebaseAuth.instance.currentUser;

      if (user!= null)
      {

         emit(
          AppStateLoggedIn(isLoading: true, user: user, userLibrary: event.userLibrary)
        );


        try
        {

          UserLibrary newUserLibrary = event.userLibrary;

          newUserLibrary.words.add(event.userLibrary.wordOfTheDay.wotd);

          await _updateUserLibrary(user.uid, newUserLibrary);
        
          emit(
            AppStateLoggedIn(isLoading: false, user: FirebaseAuth.instance.currentUser!, userLibrary: newUserLibrary)
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
      else
      {
        emit(
          const AppStateLoggedOut(isLoading: false,
           authError: AuthErrorNoCurrentUser())
        );
      }

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

      final filteredWords = event.userLibrary.words.where((word) => word.wordLevel.toLowerCase() == event.wordLevel.toLowerCase()).toList();

      emit(
        AppStateIsInUserLibraryView(
          userLibrary: event.userLibrary, 
          filteredWords: filteredWords,
          isLoading: false)
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

  WordOfTheDay _generateWordOfTheDay()
  {
     Random random = Random();

    int wotdIndex = random.nextInt(words.length);

    int timestamp = DateTime.now().millisecondsSinceEpoch;

    return WordOfTheDay(
      wotd: words[wotdIndex],
      timestamp: timestamp);

  }






  


}