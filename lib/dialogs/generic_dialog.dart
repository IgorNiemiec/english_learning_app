

import 'package:english_learning_app/constants/constants.dart';
import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String,T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionBuilder
})
{
  final options = optionBuilder();

  return showDialog<T?>(
    context: context,
    builder: (context)
    {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Text(title,style: TextStyle(
          color: applicationColor,
        ),textAlign: TextAlign.center,),
        content: Text(content,style: TextStyle(
          color: applicationColor,
        ),textAlign: TextAlign.center,),
        actions: options.keys.map((optionTitle)
        {
          final value = options[optionTitle];

          return TextButton(
           
            onPressed: ()
            {

              if (value != null)
              {
                Navigator.of(context).pop(value);
              }
              else
              {
                Navigator.of(context).pop();
              }

            },
             child: Text(optionTitle,style: const TextStyle(
              color: applicationColor,
             ),));
        }).toList(),
      );
    });

}