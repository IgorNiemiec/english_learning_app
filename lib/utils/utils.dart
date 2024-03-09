

import 'package:english_learning_app/constants/constants.dart';
import 'package:flutter/material.dart';

ButtonStyle applicationButtonStyle()
{
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: applicationColor,
    side: const BorderSide(color: applicationColor,width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
  );
}

ButtonStyle applicationRedButtonStyle()
{
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: applicationColor,
    side: const BorderSide(color: Colors.red,width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
  );

}

InputDecoration applicationInputDecoration({required String hintText})
{
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.black,
    ),
    hintFadeDuration: const Duration(milliseconds: 500),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: applicationColor,width: 2)
    ),
    enabledBorder:const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black,width: 2)
    ),
  );
}