


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
              child: Text("Choose level",style: TextStyle(color: applicationColor,fontSize: 26),),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.A)
                        );

                      },
                      style: applicationButtonStyle(),
                      child: Text("A",style: TextStyle(color: applicationColor,fontSize: 25),),
                    ),
                  ),
                  SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.B)
                        );
                      },
                      style: applicationButtonStyle(),
                      child: Text("B",style: TextStyle(color: applicationColor,fontSize: 25),),
                    ),
                  ),
                  SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.C)
                        );
                      },
                      style: applicationButtonStyle(),
                      child: Text("C",style: TextStyle(color: applicationColor,fontSize: 25),),
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
                  SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.MixedAB)
                        );

                      },
                      style: applicationButtonStyle(),
                      child: Text("mixed A-B",style: TextStyle(color: applicationColor,fontSize: 25),),
                    ),
                  ),
                  SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.MixedBC)
                        );
                      },
                      style: applicationButtonStyle(),
                      child: Text("mixed B-C",style: TextStyle(color: applicationColor,fontSize: 25),),
                    ),
                  ),
                  SizedBox()
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child:  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                         context.read<AppBloc>().add(
                          AppEventGoToTrainingView(userLibrary: userLibrary, difficultyLevel: DifficultyLevel.MixedABC)
                        );
                      },
                      style: applicationButtonStyle(),
                      child: Text("mixed A-B-C",style: TextStyle(color: applicationColor,fontSize: 25),),
                    ),
                  ),
            ),

          ],
        ),



      ),
    );
  }

}