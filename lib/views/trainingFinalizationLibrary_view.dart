
import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingFinalizationLibraryView extends StatelessWidget
{
  final UserLibrary userLibrary;
  final List<Word> trainingWords;


  const TrainingFinalizationLibraryView({
    Key? key,
    required this.userLibrary,
    required this.trainingWords,
  }) : super(key: key);


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
              child: Text("Training words", style: applicationTextStyle(35),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                border: Border.all(color: applicationColor,width: 2),
                borderRadius: BorderRadius.circular(30),
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
                          border: Border.all(color: applicationColor,width: 2),
                          borderRadius: BorderRadius.circular(30),
                          color: applicationColor
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              child: Text(trainingWords[index].wordEn,style: applicationBlackTextStyle(24),),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text("Points: ${trainingWords[index].points}",style: applicationBlackTextStyle(24),)
                            ),
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
                    context.read<AppBloc>().add(
                      AppEventFinishLibraryTraining(trainingWords: trainingWords, userLibrary: userLibrary)
                    );
                },
                style: applicationButtonStyle(),
                child: const Text("Save and finish training",style: TextStyle(color: applicationColor,fontSize: 24),),
              ),
            )
        ],),
      ),

    );
  }

}