import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';

class TrainingFinalizationView extends StatelessWidget
{
    final List<Word> trainingList;
    final int correctCounter;
    final int mistakesCounter;

    const TrainingFinalizationView({
      Key? key,
      required this.trainingList,
      required this.correctCounter,
      required this.mistakesCounter,
    }) : super(key: key);


  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              child: const Text("Training is finished",style: TextStyle(color: applicationColor,fontSize: 30),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                const SizedBox(),
                SizedBox(
                  child: Text("correct: $correctCounter", style: const TextStyle(color: applicationColor,fontSize: 24),),
                ),
                const SizedBox(),
                SizedBox(
                  child: Text("mistakes: $mistakesCounter", style: const TextStyle(color: Colors.red,fontSize: 24),),
                ),
                const SizedBox()
              ],),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: ()
                {

                },
                style: applicationButtonStyle(),
                child: const Text("Show training words",style: TextStyle(color: applicationColor,fontSize: 24),),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: ()
                {

                },
                style: applicationButtonStyle(),
                child: const Text("Save training words in my library",style: TextStyle(color: applicationColor,fontSize: 20),),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: ()
                {

                },
                style: applicationButtonStyle(),
                child: const Text("Leave without saving words in my library",style: TextStyle(color: applicationColor,fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }


}