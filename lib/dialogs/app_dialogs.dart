import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppDialog
{
  final String dialogTitle;
  final String dialogContent;

  const AppDialog({required this.dialogTitle, required this.dialogContent});
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

