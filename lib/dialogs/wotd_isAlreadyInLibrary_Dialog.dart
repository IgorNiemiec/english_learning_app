

import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showWotdIsCurrentlyInLibraryDialog({
  required BuildContext context,
})
{
  return showGenericDialog(
    context: context, 
    title: "Word of the day",
    content: "Word of the day is already in your library",
    optionBuilder: () => 
    {
      "Ok" : true,
    }
   );

}