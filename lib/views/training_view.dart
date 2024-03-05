

import 'package:english_learning_app/appEnum/appEnum.dart';
import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/bloc/app_state.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingView extends StatelessWidget
{
  final UserLibrary userLibrary;
  final List<Word> trainingList;
  final DifficultyLevel difficultyLevel;
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
    required this.trainingList,
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
              child: const Text("Training",style: TextStyle(color: applicationColor,fontSize: 30),)
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Round: ${round}",style: const TextStyle(color: applicationColor,fontSize: 15),),
                  ),
                  SizedBox(),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Correct: ${round-mistakeCounter}", style: const TextStyle(color: applicationColor, fontSize: 15),),
                  ),
                  SizedBox(),
                  Container(
                    alignment: Alignment.center,
                    child: Text("Mistakes: ${mistakeCounter}",style: const TextStyle(color: applicationColor,fontSize: 15),),
                  ),
                  SizedBox()
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Text(keyWord.wordPl,style: const TextStyle(color: applicationColor,fontSize: 30),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child: const Text("Choose a right word",style: TextStyle(color: applicationColor,fontSize: 24),),
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
                      style: applicationButtonStyle(),
                      child: Text(firstWord.wordEn,style: const TextStyle(color: applicationColor,fontSize: 25),),
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
                      style: applicationButtonStyle(),
                      child: Text(secondWord.wordEn,style: const TextStyle(color: applicationColor,fontSize: 25),),
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
                      style: applicationButtonStyle(),
                      child: Text(thirdWord.wordEn,style: const TextStyle(color: applicationColor,fontSize: 25),),
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