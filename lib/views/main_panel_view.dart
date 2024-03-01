import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/bloc/app_state.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/dialogs/add_wotd_dialog.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPanelView extends StatelessWidget
{
  UserLibrary userLibrary;

   MainPanelView({Key? key,
  required this.userLibrary}) : super(key: key);

  
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
       body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              child: Text("Main Panel",style: TextStyle(
                color: applicationColor,
                fontSize: 30
              ),),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: const Text("WORD OF THE DAY",style: TextStyle(
                            color: applicationColor,
                            fontSize: 25
                          ),
                          textAlign: TextAlign.center,),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text("${userLibrary.wordOfTheDay.wotd.wordEn} - ${userLibrary.wordOfTheDay.wotd.wordPl}",
                          style: TextStyle(
                            color: applicationColor,
                            fontSize: 20
                          ),
                          textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Container(
                         alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[ 
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const SizedBox(),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    child: OutlinedButton(
                                      style: applicationButtonStyle(),
                                      onPressed: ()
                                      {

                                        context.read<AppBloc>().add(
                                          AppEventAddWordOfTheDayToUserLibrary(userLibrary: userLibrary)
                                        );
                                        
                                      },
                                      child: Text("ADD WORD",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                    ),
                                  ),
                                  
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    child: OutlinedButton(
                                      style: applicationButtonStyle(),
                                      onPressed: ()
                                      {
                                       
                                          context.read<AppBloc>().add(
                                          AppEventGoToUserLibraryView(userLibrary: userLibrary)
                                        );
                                       
                                      },
                                      child: Text("MY LIBRARY",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),),
                                    ),
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const SizedBox(),
                                 SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    child: OutlinedButton(
                                      style: applicationButtonStyle(),
                                      onPressed: ()
                                      {

                                        context.read<AppBloc>().add(
                                          AppEventGoToCommonLibrary(userLibrary: userLibrary)
                                        );

                                      },
                                      child: const Text("LIBRARY",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                    ),
                                  ),
                                 SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    child: OutlinedButton(
                                      style: applicationButtonStyle(),
                                      onPressed: ()
                                      {
                                        context.read<AppBloc>().add(
                                          const AppEventLogOut()
                                        );
                                      },
                                      child: Text("...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                    ),
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                            ),


                          ],
                        ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: OutlinedButton(
                  style: applicationButtonStyle(),
                  onPressed: ()
                  {
                    context.read<AppBloc>().add(
                      AppEventGoToTrainingChoiceView(userLibrary: userLibrary)
                    );
                  },
                  child: Text("Train",style: TextStyle(
                    color: applicationColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),),
                ),
              ),
            )
          ]),
       ),
    );
  }

}