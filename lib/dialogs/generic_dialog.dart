

import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/utils/utils.dart';
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
        backgroundColor: applicationColor,
        title: Text(title,style: applicationBlackTextStyle(20), textAlign:  TextAlign.center,),
        content: Text(content,style: TextStyle(
          color: Colors.black,
          fontFamily: 'ProtestRiot',
          fontSize: 15,
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
              color: Colors.black,
             ),));
        }).toList(),
      );
    });

}