

import 'package:english_learning_app/dialogs/app_dialogs.dart';
import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showAppDialog({required BuildContext context, required AppDialog dialog})

{
  return showGenericDialog(
    context: context, 
    title: dialog.dialogTitle, 
    content: dialog.dialogContent, 
    optionBuilder: () =>
    {
      "Ok" : true,
    }
    );

}