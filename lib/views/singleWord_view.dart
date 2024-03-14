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

class SingleWordView extends StatelessWidget
{

  UserLibrary userLibrary;
  List<Word> filteredWords;
  Word word;


   SingleWordView({
    Key? key,
    required this.userLibrary,
    required this.filteredWords,
    required this.word}) : super(key: key);

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
                            AppEventGoToUserLibraryView(
                              filteredList: filteredWords,
                              userLibrary: userLibrary)
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
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Text(word.wordEn,style: applicationBlackTextStyle(20),textAlign: TextAlign.center,),
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
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: Text(word.wordPl,style: applicationBlackTextStyle(20),textAlign: TextAlign.center,),
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
                color: applicationColor,
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
                      onPressed: ()
                      {

                         context.read<AppBloc>().add(
                          AppEventShowWordPointsExplanation(
                            userLibrary: userLibrary, 
                            word: word,
                            filteredWords: filteredWords)
                         );

                      },
                      style: roundedButtonBlackStyle(),
                      child: const Icon(Icons.question_mark),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text("Word points: ${word.points}",style: applicationBlackTextStyle(25),),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                ],
              ),
             ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
              Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: applicationColor,
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
                      onPressed: () 
                      {

                        context.read<AppBloc>().add(
                          AppEventShowWordLevelExplanation(
                            userLibrary: userLibrary, 
                            filteredWords: filteredWords,
                            word: word)
                        );
                     
                      },
                      style: roundedButtonBlackStyle(),
                      child: const Icon(Icons.question_mark),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text("Word level: ${word.wordLevel}",style: applicationBlackTextStyle(25),),
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
               height: MediaQuery.of(context).size.height * 0.15,
               child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                child: OutlinedButton(
                  onPressed: () async
                  {
                     if (await showRemoveWordDialog(context: context))
                     {
                        context.read<AppBloc>().add(
                          AppEventRemoveWordFromUserLibrary(
                            userLibrary: userLibrary, 
                            filteredWords: filteredWords,
                            word: word,
                            isInSingleWordView: true)
                        );
                     }
                  },
                  style: applicationRedButtonStyle(),
                  child: Text("Remove word from my library",style:applicationBlackTextStyle(20),textAlign: TextAlign.center,),
                ),
               )
             ),
             


          ],
        ),
      ),
    );
  }

}