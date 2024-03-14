


import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<bool> showRemoveWordDialog(
  {
    required BuildContext context,
  }
)
{

   return showGenericDialog<bool>(
    context: context, 
    title: "Remove word", 
    content: "Are you sure you want to delete this word from your library?", 
    optionBuilder: () =>
    {
      "Remove" : true,
      "Cancel" : false,
    }
    ).then((value) => value ?? false);

}