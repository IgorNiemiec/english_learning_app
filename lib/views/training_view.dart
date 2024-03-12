

import 'package:english_learning_app/appEnum/appEnum.dart';
import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/bloc/app_state.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/training_unit.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingView extends StatelessWidget
{
  final UserLibrary userLibrary;
  final List<Word> trainingList;
  final List<TrainingUnit> trainingUnits;
  final DifficultyLevel difficultyLevel;
  final TrainingModeEnum trainingModeEnum;
  final int round;
  final int mistakeCounter;
  final Word firstWord;
  final Word secondWord;
  final Word thirdWord;
  final int keyWordIndex;

  Word keyWord;

  TrainingView({
    Key? key,
    required this.userLibrary,
    required this.trainingUnits,
    required this.trainingList,
    required this.trainingModeEnum,
    required this.difficultyLevel,
    required this.keyWord,
    required this.firstWord,
    required this.secondWord,
    required this.thirdWord,
    required this.keyWordIndex,
    required this.mistakeCounter,
    required this.round,
  
  }) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text("Training",style: applicationTextStyle(30),)
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: applicationColor,width: 2),
                      shape: BoxShape.circle
                    ),
                    child: Text("$round/50",style: applicationTextStyle(25),),
                  ),
                  const SizedBox(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: applicationColor,
                    ),
                    child: Text("${round-mistakeCounter-1}", style: applicationBlackTextStyle(30),),
                  ),
                  const SizedBox(),
                  Container(
                     width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    alignment: Alignment.center,
                    decoration:const  BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text("$mistakeCounter",style: applicationBlackTextStyle(30),),
                  ),
                  const SizedBox()
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.12,
              child: Text(keyWord.wordPl,style: applicationTextStyle(35),textAlign: TextAlign.center,),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Text("Choose a right word",style: applicationTextStyle(25),textAlign: TextAlign.center,),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(children: 
              <Widget>[
                 SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        if(keyWordIndex==1)
                        {
                          context.read<AppBloc>().add(
                            AppEventUpdateTrainingView(
                              trainingMode: trainingModeEnum,
                              trainingUnits: trainingUnits,
                              userLibrary: userLibrary, 
                              trainingList: trainingList, 
                              difficultyLevel: difficultyLevel, 
                              round: round, 
                              mistakes: mistakeCounter, 
                              isMistake: false, 
                              keyWordIndex: keyWordIndex, 
                              markedIndex: 1, 
                              keyWord: keyWord, 
                              firstWord: firstWord, 
                              secondWord: secondWord, 
                              thirdWord: thirdWord)
                          );
                        }
                        else
                        {

                          context.read<AppBloc>().add(
                            AppEventUpdateTrainingView(
                              trainingMode: trainingModeEnum,
                              trainingUnits: trainingUnits,
                              userLibrary: userLibrary, 
                              trainingList: trainingList, 
                              difficultyLevel: difficultyLevel, 
                              round: round, 
                              mistakes: mistakeCounter, 
                              isMistake: true, 
                              keyWordIndex: keyWordIndex, 
                              markedIndex: 1, 
                              keyWord: keyWord, 
                              firstWord: firstWord, 
                              secondWord: secondWord, 
                              thirdWord: thirdWord)
                          );

                        }


                      },
                      style: applicationGreenButtonStyle(),
                      child: Text(firstWord.wordEn,style: applicationBlackTextStyle(30),),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                     width: MediaQuery.of(context).size.width * 0.95,
                    child: OutlinedButton(
                      onPressed: ()
                      {

                        if(keyWordIndex==2)
                        {

                           context.read<AppBloc>().add(
                            AppEventUpdateTrainingView(
                              trainingMode: trainingModeEnum,
                              trainingUnits: trainingUnits,
                              userLibrary: userLibrary, 
                              trainingList: trainingList, 
                              difficultyLevel: difficultyLevel, 
                              round: round, 
                              mistakes: mistakeCounter, 
                              isMistake: false, 
                              keyWordIndex: keyWordIndex, 
                              markedIndex: 2, 
                              keyWord: keyWord, 
                              firstWord: firstWord, 
                              secondWord: secondWord, 
                              thirdWord: thirdWord)
                          );

                        }
                        else
                        {

                           context.read<AppBloc>().add(
                            AppEventUpdateTrainingView(
                              trainingMode: trainingModeEnum,
                              trainingUnits: trainingUnits,
                              userLibrary: userLibrary, 
                              trainingList: trainingList, 
                              difficultyLevel: difficultyLevel, 
                              round: round, 
                              mistakes: mistakeCounter, 
                              isMistake: true, 
                              keyWordIndex: keyWordIndex, 
                              markedIndex: 2, 
                              keyWord: keyWord, 
                              firstWord: firstWord, 
                              secondWord: secondWord, 
                              thirdWord: thirdWord)
                          );

                        }

                      },
                      style: applicationGreenButtonStyle(),
                      child: Text(secondWord.wordEn,style: applicationBlackTextStyle(30),),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                     width: MediaQuery.of(context).size.width * 0.95,
                    child: OutlinedButton(
                      onPressed: ()
                      {

                        if(keyWordIndex==3)
                        {
                           context.read<AppBloc>().add(
                            AppEventUpdateTrainingView(
                              trainingMode: trainingModeEnum,
                              trainingUnits: trainingUnits,
                              userLibrary: userLibrary, 
                              trainingList: trainingList, 
                              difficultyLevel: difficultyLevel, 
                              round: round, 
                              mistakes: mistakeCounter, 
                              isMistake: false, 
                              keyWordIndex: keyWordIndex, 
                              markedIndex: 3, 
                              keyWord: keyWord, 
                              firstWord: firstWord, 
                              secondWord: secondWord, 
                              thirdWord: thirdWord)
                          );
                        }
                        else
                        {
                           context.read<AppBloc>().add(
                            AppEventUpdateTrainingView(
                              trainingMode: trainingModeEnum,
                              trainingUnits: trainingUnits,
                              userLibrary: userLibrary, 
                              trainingList: trainingList, 
                              difficultyLevel: difficultyLevel, 
                              round: round, 
                              mistakes: mistakeCounter, 
                              isMistake: true, 
                              keyWordIndex: keyWordIndex, 
                              markedIndex: 3, 
                              keyWord: keyWord, 
                              firstWord: firstWord, 
                              secondWord: secondWord, 
                              thirdWord: thirdWord)
                          );
                        }

                      },
                      style: applicationGreenButtonStyle(),
                      child: Text(thirdWord.wordEn,style: applicationBlackTextStyle(30),),
                    ),
                  ),

              ],),
            )
          ],
        ),
      ),
    );

  }

}