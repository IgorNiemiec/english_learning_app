


import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showPointExplanationDialog({
  required BuildContext context
})
{
  return showGenericDialog(
    context: context, 
    title: "What is a word point?", 
    content: "Every time you guess the word you get one point. In the same way for missing word you are loosing one. Amount of the point represents your knowledge of the word", 
    optionBuilder: () => 
    {
      "Ok" : true
    });
}