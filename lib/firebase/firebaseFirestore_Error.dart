import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_learning_app/auth/auth_error.dart';
import 'package:flutter/foundation.dart' show immutable;


const Map<String,FirebaseFirestoreError> firebaseFirestoreMapping = 
{
  's' : FirebaseFirestoreUnknownError(),

};

@immutable
abstract class FirebaseFirestoreError
{
  final String dialogTitle;
  final String dialogContent;

  const FirebaseFirestoreError({
    required this.dialogTitle,
    required this.dialogContent,
  });

  factory FirebaseFirestoreError.fromError(FirebaseException exception) => firebaseFirestoreMapping[exception.code.toLowerCase().trim()] ?? const FirebaseFirestoreUnknownError();

}

@immutable
class FirebaseFirestoreUnknownError extends FirebaseFirestoreError
{
  const FirebaseFirestoreUnknownError() : super(
    dialogTitle: "Unknown Error",
    dialogContent: "Unknown error has occured",
  );
}



