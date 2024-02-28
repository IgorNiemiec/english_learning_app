

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
  bool isWordInUserLibrary;

  CommonSingleWordView({
    required this.word,
    required this.isWordInUserLibrary,
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
                      
                      child: OutlinedButton(
                        onPressed: ()
                        {

                          context.read<AppBloc>().add(
                             AppEventGoToCommonLibrary(userLibrary: userLibrary)
                          );

                        },
                        style: applicationButtonStyle(),
                        child: const Text("Go Back",style: TextStyle(color: applicationColor,fontSize: 20),),
                      ),
                    ),
                  ),
                  Container(
                    alignment: const Alignment(-0.3,0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const Text("Word",style: TextStyle(color: applicationColor,fontSize: 30),),
                  )
                ],
              ),
             ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
             ),
             Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/BritishFlag.jpeg"),
                      fit: BoxFit.scaleDown)
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(word.wordEn,style: TextStyle(color: applicationColor,fontSize: 20),textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,),
                )
              ]),
             ),
             Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/PolishFlag.jpeg"),
                      fit: BoxFit.scaleDown)
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(word.wordPl,style: TextStyle(color: applicationColor,fontSize: 20),textAlign: TextAlign.left,overflow: TextOverflow.ellipsis,),
                )
              ]),
             ),
              Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: OutlinedButton(
                      onPressed: () async
                      {
                        await showWordLevelExplanation(context: context);
                      },
                      style: applicationButtonStyle(),
                      child: const Icon(Icons.question_mark),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text("Word level: ${word.wordLevel}",style: const TextStyle(fontSize: 25,color: applicationColor),),
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
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Builder(builder: (context) {
                  if (isWordInUserLibrary)
                  {
                    return OutlinedButton(onPressed: ()
                    {

                        context.read<AppBloc>().add(
                          AppEventRemoveWordFromUserLibrary(userLibrary: userLibrary, word: word, isInSingleWordView: false)
                        );

                    },
                    style: applicationRedButtonStyle(),
                    child: const Text("Remove word from my Library",style: TextStyle(color: Colors.red,fontSize: 20),textAlign: TextAlign.center,));
                  }
                  else
                  {
                    return OutlinedButton(onPressed: ()
                    {

                      context.read<AppBloc>().add(
                        AppEventAddWordToUserLibrary(userLibrary: userLibrary, word: word)
                      );

                    },
                    style: applicationButtonStyle(),
                    child: const Text("Add word to my Library",style: TextStyle(color: applicationColor,fontSize: 20),textAlign: TextAlign.center,));
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