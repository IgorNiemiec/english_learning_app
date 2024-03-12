

import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPanelView extends StatelessWidget
{
  final UserLibrary userLibrary;

  const UserPanelView({
    required this.userLibrary,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: applicationColor,width: 2),
              ),
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(),
                        Container(
                          alignment: Alignment.center,
                          child:  Text("WORD OF THE DAY",style: applicationTextStyle(30),
                          textAlign: TextAlign.center,),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text("${userLibrary.wordOfTheDay.wotd.wordEn} - ${userLibrary.wordOfTheDay.wotd.wordPl}",
                          style: applicationTextStyle(20),
                          textAlign: TextAlign.center,),
                        ),
                        const SizedBox(),
                      ],
                    ),
              ),
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const SizedBox(),
                          userPanelViewButton(
                            context: context, 
                            appEvent:   AppEventAddWordOfTheDayToUserLibrary(userLibrary: userLibrary), 
                            icon: const Icon(Icons.add_box,size: 50,), 
                            title: "Add WOTD"),
                          const SizedBox(),
                          userPanelViewButton(
                            context: context, 
                            appEvent: AppEventGoToUserLibraryView(userLibrary: userLibrary), 
                            icon: const Icon(Icons.person,size: 50,), 
                            title: "User library"),
                          const SizedBox(),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const SizedBox(),
                          userPanelViewButton(
                            context: context, 
                            appEvent: AppEventGoToCommonLibrary(userLibrary: userLibrary), 
                            icon: const Icon(Icons.library_books,size: 50,), 
                            title: "Dictionary"),
                          const SizedBox(),
                          userPanelViewButton(
                            context: context, 
                            appEvent:  const AppEventLogOut(), 
                            icon: const Icon(Icons.logout,size: 50,), 
                            title: "Logout"),
                          const SizedBox(),
                        ],
                      ),
                    ),
                    const SizedBox(),

                  ],

                )
              ),
              const SizedBox(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                style: applicationGreenButtonStyle(),
                onPressed: ()
                {
                  context.read<AppBloc>().add(
                      AppEventGoToTrainingChoiceView(userLibrary: userLibrary)
                    );

                },
                child: Text("Train",style: applicationBlackTextStyle(30)),

              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
          ],
        ),
      ),
    );

  }
}