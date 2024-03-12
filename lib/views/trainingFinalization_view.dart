import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/training_unit.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:english_learning_app/widgets/guess_ratio_container.dart';
import 'package:english_learning_app/widgets/unit_block.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingFinalizationView extends StatelessWidget
{
    final UserLibrary userLibrary;
    final List<Word> trainingList;
    final List<TrainingUnit> trainingUnits;
    final int correctCounter;
    final int mistakeCounter;

    const TrainingFinalizationView({
      Key? key,
      required this.userLibrary,
      required this.trainingUnits,
      required this.trainingList,
      required this.correctCounter,
      required this.mistakeCounter,
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
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text("Finish!",style: applicationTextStyle(50),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.95,
              child: buildGrid(trainingUnits),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            guessRatioContainer(context, correctCounter, mistakeCounter),
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