

import 'package:english_learning_app/constants/constants.dart';
import 'package:flutter/material.dart';

ButtonStyle applicationButtonStyle()
{
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: applicationColor,
    side: const BorderSide(color: applicationColor,width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
  );
}

InputDecoration applicationInputDecoration({required String hintText})
{
  return InputDecoration(
    
    hintText: hintText,
    hintStyle: const TextStyle(
      color: applicationColor,
    ),
    hintFadeDuration: const Duration(milliseconds: 500),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: applicationColor,width: 2)
    ),
    enabledBorder:const UnderlineInputBorder(
      borderSide: BorderSide(color: applicationColor,width: 2)
    ),
  );
}