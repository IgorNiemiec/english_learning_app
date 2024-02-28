


import 'package:english_learning_app/constants/constants.dart';
import 'package:flutter/material.dart';

class TrainingChoiceView extends StatelessWidget
{

  const TrainingChoiceView({Key? key}) : super(key: key);

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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: OutlinedButton(
                      onPressed: ()
                      {

                      },
                      child: Text("Common Training"),
                    ),
                  ),
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: OutlinedButton(
                      onPressed: ()
                      {

                      },
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