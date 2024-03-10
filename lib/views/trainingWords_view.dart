


import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';

class TrainingWordsView extends StatelessWidget
{
  List<Word> trainingWords;

  TrainingWordsView({Key? key, required this.trainingWords}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(

      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text("Training words", style: applicationTextStyle(40),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: applicationColor,width: 2),
                borderRadius: BorderRadius.circular(30)
              ),
              child: ListView.builder(
                itemCount: trainingWords.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.1,
                        
                        decoration: BoxDecoration(
                          color: applicationColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const SizedBox(),
                            Container(
                              alignment: Alignment.center,
                              child: Text(trainingWords[index].wordEn,style: applicationBlackTextStyle(20),),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text("Points: ${trainingWords[index].points}",style: applicationBlackTextStyle(20),)
                            ),
                            const SizedBox(),
                          ],),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              child: OutlinedButton(
                onPressed: ()
                {
                    // Go Back to finalizationPage
                },
                style: applicationButtonStyle(),
                child: const Text("Go back",style: TextStyle(color: applicationColor,fontSize: 24),),
              ),
            )
        ],),
      ),

    );
  }
  


}