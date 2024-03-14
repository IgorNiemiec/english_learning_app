

import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/dialogs/points_explanation_dialog.dart';
import 'package:english_learning_app/dialogs/removeWord_dialog.dart';
import 'package:english_learning_app/dialogs/wordLevel_explanation_dialog.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonSingleWordView extends StatelessWidget
{
  Word word;
  UserLibrary userLibrary;
  List<Word> filteredWords;
  bool isWordInUserLibrary;

  CommonSingleWordView({
    required this.word,
    required this.isWordInUserLibrary,
    required this.filteredWords,
    required this.userLibrary});


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
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: OutlinedButton(
                        onPressed: ()
                        {

                          context.read<AppBloc>().add(
                             AppEventGoToCommonLibrary(userLibrary: userLibrary)
                          );

                        },
                        style: roundedButtonStyle(),
                        child: Icon(Icons.navigate_before,size: 50,),
                      ),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(-0.3,0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text("Word",style: applicationTextStyle(50),),
                  )
                ],
              ),
             ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
             ),
             Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width* 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: applicationColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                const SizedBox(),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(image: AssetImage("assets/BritishFlag.jpeg"),
                      fit: BoxFit.scaleDown)
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(word.wordEn,style: applicationBlackTextStyle(25),textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,),
                ),
                const SizedBox(),
              ]),
             ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
             Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width* 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: applicationColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                const SizedBox(),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(image: AssetImage("assets/PolishFlag.jpeg"),
                      fit: BoxFit.scaleDown)
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(word.wordPl,style: applicationBlackTextStyle(25),textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,),
                ),
                const SizedBox(),
              ]),
             ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
             Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: applicationColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: OutlinedButton(
                      onPressed: () async
                      {
                        await showWordLevelExplanation(context: context);
                      },
                      style: roundedButtonBlackStyle(),
                      child: const Icon(Icons.question_mark),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text("Word level: ${word.wordLevel}",style: applicationBlackTextStyle(30),),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              ),
             ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
             ),
             Container(
               alignment: Alignment.center,
               height: MediaQuery.of(context).size.height * 0.18,
               child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Builder(builder: (context) {
                  if (isWordInUserLibrary)
                  {
                    return OutlinedButton(onPressed: ()
                    {

                        context.read<AppBloc>().add(
                          AppEventRemoveWordFromUserLibrary(
                            userLibrary: userLibrary, 
                            filteredWords: filteredWords,
                            word: word, 
                            isInSingleWordView: false)
                        );

                    },
                    style: applicationRedButtonStyle(),
                    child: Text("Remove word from my Library",style: applicationBlackTextStyle(20),textAlign: TextAlign.center,));
                  }
                  else
                  {
                    return OutlinedButton(onPressed: ()
                    {

                      context.read<AppBloc>().add(
                        AppEventAddWordToUserLibrary(
                          filteredWords: filteredWords,
                          userLibrary: userLibrary, 
                          word: word)
                      );

                    },
                    style: applicationButtonStyle(),
                    child: Text("Add word to my Library",style: applicationTextStyle(20),textAlign: TextAlign.center,));
                  }
                },)
               )
             ),
             


          ],
        ),
      ),
    );
  }

}