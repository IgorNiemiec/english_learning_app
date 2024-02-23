
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning_app/auth/auth_error.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/bloc/app_state.dart';
import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:english_learning_app/dialogs/show_auth_error.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AppBloc extends Bloc<AppEvent,AppState>
{

  AppBloc() : super(const AppStateLoggedOut(isLoading: false))
  {


    on<AppEventInitialize>((event, emit) {
      
      final user = FirebaseAuth.instance.currentUser;

      if (user == null)
      {
        emit(const AppStateLoggedOut(isLoading: false));
      }
      else
      {
        emit(AppStateLoggedIn(isLoading: false, user: user));
      }



    },);

    on<AppEventGoToRegistration>((event, emit) {
      
      emit(const AppStateIsInRegistrationView(isLoading: false));

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
          
          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

          final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

         final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

         final user = userCredential.user!;

         final userLibrary = await _getUserLibrary(user.uid);

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


    on<AppEventRegister>((event, emit) async {
      
      emit(const AppStateIsInRegistrationView(isLoading: true));

      final email = event.email;
      final password = event.password;

      try
      {
        final credentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        emit(AppStateLoggedIn(
          isLoading: false, 
          user: credentials.user!));

      }
      on FirebaseAuthException catch (e)
      {
        emit(AppStateIsInRegistrationView(
        isLoading: false,
        authError: AuthError.from(e)));
      }

    },);


    

  }



  Future<UserLibrary?> _getUserLibrary(String userId) async
  {
      final userDoc = await FirebaseFirestore.instance.collection("UserLibrary").doc(userId).get();

      return UserLibrary.fromJson(userDoc.data()!);
  } 

  Future<void> _createUserLibrary(String userId) async
  {
    FirebaseFirestore database = FirebaseFirestore.instance;

    final CollectionReference userLibraryRef =  database.collection('UserLibrary');

    UserLibrary userLibrary = UserLibrary(words: []);

    await userLibraryRef.doc(userId).set(userLibrary.toJson());

  }


}