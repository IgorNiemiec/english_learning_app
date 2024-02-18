

import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showAddWotdDialog({
  required BuildContext context,
})
{
  return showGenericDialog(
    context: context, 
    title: "Word of the day",
    content: "Word of the day has been added to my Library",
    optionBuilder: () => 
    {
      "Ok" : true,
    }
   );

}