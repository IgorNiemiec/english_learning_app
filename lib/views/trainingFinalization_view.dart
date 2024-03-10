import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingFinalizationView extends StatelessWidget
{
   final UserLibrary userLibrary;
    final List<Word> trainingList;
    final int correctCounter;
    final int mistakesCounter;

    const TrainingFinalizationView({
      Key? key,
      required this.userLibrary,
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
              child: Text("Training is finished",style: applicationTextStyle(30),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                const SizedBox(),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: applicationColor
                  ),
                  child: Text("correct: $correctCounter", style: applicationBlackTextStyle(20),),
                ),
                const SizedBox(),
                Container(
                  
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red
                  ),
                  child: Text("mistakes: $mistakesCounter", style: applicationBlackTextStyle(20),),
                ),
                const SizedBox()
              ],),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: ()
                {
                  context.read<AppBloc>().add(
                    AppEventGoToTrainingWordsView(trainingList: trainingList)
                  );
                },
                style: applicationGreenButtonStyle(),
                child: Text("Show training words",style: applicationBlackTextStyle(30),),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
           
                  SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: ()
                {

                  context.read<AppBloc>().add(
                    AppEventSaveTrainingWordsInUserLibrary(
                      trainingWords: trainingList, 
                      userLibrary: userLibrary)
                  );



                },
                style: applicationGreenButtonStyle(),
                child: Text("Save training words in my library",style: applicationBlackTextStyle(18),),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: ()
                {

                  context.read<AppBloc>().add(
                    AppEventGoToTrainingChoiceView(userLibrary: userLibrary)
                  );

                },
                style: applicationGreenButtonStyle(),
                child: Text("Leave without saving words in my library",style: applicationBlackTextStyle(15),),
              ),
            ),
            const SizedBox(),
                ],
              ),
            )
            
            
            
          
        
      
    );
  }


}