

import 'package:english_learning_app/appEnum/appEnum.dart';
import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/models/word.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLibraryView extends StatelessWidget
{

  UserLibrary userLibrary;
  List<Word> filteredWords;

  UserLibraryView({
    Key? key,
    required this.userLibrary,
    required this.filteredWords}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.all(8.0),
              child: Row(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          const AppEventInitialize()
                        );
                        
                      },
                      style: roundedButtonStyle(),
                      child: Icon(Icons.navigate_before,size: 50,),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text("User Library",style: applicationTextStyle(30) ,textAlign: TextAlign.center,),
                )
              ]),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: applicationColor,
              ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextField(
                style: applicationBlackTextStyle(25),
                onChanged: (word) {
                  context.read<AppBloc>().add(
                    AppEventFilterUserLibrary(wordName: word, userLibrary: userLibrary)
                  );
                },
                decoration: applicationInputDecoration(hintText: "Search word",
                icon: Icons.search),
               ),
              ),
            ), 
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
                border: Border.all(color: applicationColor,width: 2)
              ),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  
                ),
                child: Expanded(
                  child: ListView.builder(
                    itemCount: filteredWords.length,
                    itemBuilder: (context, index) {
                      final word = filteredWords[index];
                      
                        return Column(
                        children: <Widget>[

                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: OutlinedButton(
                              onPressed: ()
                              {
                                context.read<AppBloc>().add(
                                  AppEventGoToSingleWordView(userLibrary: userLibrary, word: word)
                                );
                              },
                              style: applicationGreenButtonStyle(),
                              child: Text("${word.wordEn} : ${word.wordPl}",style: applicationBlackTextStyle(18)),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02,)
                        ],
                      );
                      
                    },
                  ),
                ),
                
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            levelChoiceBarContainer(
              context: context, 
              appEventA: AppEventFilterUserLibraryByWordLevel(userLibrary: userLibrary, wordLevel: WordLevelEnum.A),
              appEventB: AppEventFilterUserLibraryByWordLevel(userLibrary: userLibrary, wordLevel: WordLevelEnum.B),
              appEventC: AppEventFilterUserLibraryByWordLevel(userLibrary: userLibrary, wordLevel: WordLevelEnum.C),
              appEventAll: AppEventFilterUserLibraryByWordLevel(userLibrary: userLibrary, wordLevel: WordLevelEnum.ALL),)
            

          ],
        ),
      ),
    );
  }

}


