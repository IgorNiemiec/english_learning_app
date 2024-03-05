


import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/models/user_library.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingChoiceView extends StatelessWidget
{

  final UserLibrary userLibrary;

  const TrainingChoiceView({Key? key,
  required this.userLibrary}) : super(key: key);

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
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              child: const Text("Training mode",style: TextStyle(color: applicationColor,fontSize: 25),),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              child: const Text("Choose training mode",style: TextStyle(color: applicationColor,fontSize: 20),textAlign: TextAlign.center,),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          AppEventGoToCommonTrainingChoieView(userLibrary: userLibrary)
                        );
                      },
                      style: applicationButtonStyle(),
                      child: Text("Common Training"),
                    ),
                  ),
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: OutlinedButton(
                      onPressed: ()
                      {

                      },
                      style: applicationButtonStyle(),
                      child: Text("User library training"),
                    ),
                  ),
                  const SizedBox()

                ],
              ),
            )
            
          ],
        ),
      ),
    );

  }

}