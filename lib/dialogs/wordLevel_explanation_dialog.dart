


import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showWordLevelExplanation({
  required BuildContext context,
})
{

  return showGenericDialog(
    context: context, 
    title: "What is word level", 
    content: "Level of the word represents its advance level. A is the lowest and C is the highest", 
    optionBuilder: () => 
    {
      "Ok" : true
    });

}