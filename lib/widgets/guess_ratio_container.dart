

import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';

Container guessRatioContainer(BuildContext context,int correctCounter, int mistakeCounter)
{
  return  Container(
     alignment: Alignment.center,
     height: MediaQuery.of(context).size.height * 0.1,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: <Widget>[
       const SizedBox(),
       Container(
         alignment: Alignment.center,
         width: MediaQuery.of(context).size.width * 0.4,
         height: MediaQuery.of(context).size.height * 0.08,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
           color: applicationColor
         ),
         child: Text("correct: $correctCounter", style: applicationBlackTextStyle(22),),
       ),
       const SizedBox(),
       Container(
         alignment: Alignment.center,
         width: MediaQuery.of(context).size.width * 0.4,
         height: MediaQuery.of(context).size.height * 0.08,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),
           color: Colors.red
         ),
         child: Text("mistakes: $mistakeCounter", style: applicationBlackTextStyle(22),),
       ),
       const SizedBox()
     ],),
    );

}