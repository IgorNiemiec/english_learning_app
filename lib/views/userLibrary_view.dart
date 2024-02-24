

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
  List<Word> filteredWors;

  UserLibraryView({
    Key? key,
    required this.userLibrary,
    required this.filteredWors}) : super(key: key);


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
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              padding: EdgeInsets.all(8.0),
              child: Text("User Library",style: TextStyle(color: applicationColor,fontSize: 20),textAlign: TextAlign.center,),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.07,
                child: TextField(
                onChanged: (word) {
                  context.read<AppBloc>().add(
                    AppEventFilterUserLibrary(wordName: word, userLibrary: userLibrary)
                  );
                },
                decoration: applicationInputDecoration(hintText: "Search word"),
               ),
              ),
            ), 
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: filteredWors.length,
                    itemBuilder: (context, index) {
                      final word = filteredWors[index];
                      return Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.07,
                            decoration: BoxDecoration(
                              border: Border.all(color: applicationColor,width: 3),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Text("${word.wordEn} : ${word.wordPl}",style: TextStyle(color: applicationColor,fontSize: 20,overflow: TextOverflow.ellipsis),),
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
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          AppEventFilterUserLibraryByWordLevel(userLibrary: userLibrary, wordLevel: "A")
                        );

                      },
                      style: applicationButtonStyle(),
                      child: const Text("A",style: TextStyle(color: applicationColor,fontSize: 20),),
                    ),
                  ),
                     SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          AppEventFilterUserLibraryByWordLevel(userLibrary: userLibrary, wordLevel: "B")
                        );

                      },
                      style: applicationButtonStyle(),
                      child: const Text("B",style: TextStyle(color: applicationColor,fontSize: 20),),
                    ),
                  ),
                     SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          AppEventFilterUserLibraryByWordLevel(userLibrary: userLibrary, wordLevel: "C")
                        );

                      },
                      style: applicationButtonStyle(),
                      child: const Text("C",style: TextStyle(color: applicationColor,fontSize: 20),),
                    ),
                  ),
                ],
              ),
            )
            

          ],
        ),
      ),
    );
  }

}


