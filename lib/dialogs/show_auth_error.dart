

import 'package:english_learning_app/auth/auth_error.dart';
import 'package:english_learning_app/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showAuthError({
    required BuildContext context,
    required AuthError authError,
  }
)
{
  return showGenericDialog(
    context: context, 
    title: authError.dialogTitle, 
    content: authError.dialogText, 
    optionBuilder: () =>
    {
      "Ok" : true,
    }
    );

}