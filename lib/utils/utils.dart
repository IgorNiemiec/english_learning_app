

import 'dart:math';

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

ButtonStyle signInButtonStyle()
{
  return ElevatedButton.styleFrom(
    backgroundColor: applicationColor,
    foregroundColor: Colors.black,
    side: const BorderSide(color: Colors.black),
    shape: const CircleBorder(),
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

TextStyle applicationTextStyle(double fontSize)
{
  return TextStyle(
    color: applicationColor,
    fontSize: fontSize,
    fontFamily: 'ProtestRiot',
  );
}

TextStyle applicationBlackTextStyle(double fontSize)
{
  return TextStyle(
    color: Colors.black,
    fontSize: fontSize,
    fontFamily: 'ProtestRiot',
  );
}

InputDecoration applicationInputDecoration({required String hintText, required IconData icon})
{
  return InputDecoration(
    icon: Icon(icon,color: Colors.black,size: 30, ),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.black,
    ),
    hintFadeDuration: const Duration(milliseconds: 500),
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
  );
}