


import 'package:english_learning_app/appEnum/appEnum.dart';
import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonTrainingLevelChoiceView extends StatelessWidget
{
  
  UserLibrary userLibrary;

  CommonTrainingLevelChoiceView({Key? key, required this.userLibrary}) : super(key: key);

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
              height: MediaQuery.of(context).size.height * 0.15,
              child: Text("Choose level",style: applicationTextStyle(40),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.A)
                        );

                      },
                      style: roundedButtonStyle(),
                      child: Text("A",style: applicationBlackTextStyle(30),),
                    ),
                  ),
                  SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.B)
                        );
                      },
                      style: roundedButtonStyle(),
                      child: Text("B",style: applicationBlackTextStyle(30),),
                    ),
                  ),
                  SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.C)
                        );
                      },
                      style: roundedButtonStyle(),
                      child: Text("C",style: applicationBlackTextStyle(30),),
                    ),
                  ),
                  SizedBox()
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.MixedAB)
                        );

                      },
                      style: roundedButtonStyle(),
                      child: Text("A-B",style: applicationBlackTextStyle(30),),
                    ),
                  ),
                
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.MixedBC)
                        );
                      },
                      style: roundedButtonStyle(),
                      child: Text("B-C",style:applicationBlackTextStyle(30),),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child:  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.MixedABC)
                        );
                      },
                      style: roundedButtonStyle(),
                      child: Text("A-B-C",style: applicationBlackTextStyle(30),),
                    ),
                  ),
            ),

          ],
        ),



      ),
    );
  }

}