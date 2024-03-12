

import 'dart:math';

import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

ButtonStyle applicationButtonStyle()
{
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: applicationColor,
    side: const BorderSide(color: applicationColor,width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
    
  );
}

ButtonStyle roundedButtonStyle()
{
  return ElevatedButton.styleFrom(
    backgroundColor: applicationColor,
    foregroundColor: Colors.black,
    side: const BorderSide(color: Colors.black),
    shape: const CircleBorder(),
  );
}

ButtonStyle roundedButtonBlackStyle()
{
   return ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: applicationColor,
    side: const BorderSide(color: Colors.black),
    shape: const CircleBorder(),
  );
}

ButtonStyle applicationGreenButtonStyle()
{
  return ElevatedButton.styleFrom(
    backgroundColor: applicationColor,
    foregroundColor: Colors.black,

    side: const BorderSide(color: Colors.black),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
  );

}

ButtonStyle applicationRedButtonStyle()
{
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    foregroundColor: Colors.black,
    side: const BorderSide(color: Colors.red,width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
  );

}

TextStyle applicationTextStyle(double fontSize)
{
  return TextStyle(
    color: applicationColor,
    fontSize: fontSize,
    fontFamily: 'ProtestRiot',
  );
}



TextStyle applicationBlackTextStyle(double fontSize)
{
  return TextStyle(
    color: Colors.black,
    fontSize: fontSize,
    fontFamily: 'ProtestRiot',
  );
}

InputDecoration applicationInputDecoration({required String hintText, required IconData icon})
{
  return InputDecoration(
    icon: Icon(icon,color: Colors.black,size: 30, ),
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Colors.black,
    ),
    hintFadeDuration: const Duration(milliseconds: 500),
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
  );
}

Container levelChoiceBarContainer({
  required BuildContext context,
  required AppEvent appEventA,
  required AppEvent appEventB,
  required AppEvent appEventC,
  required AppEvent appEventAll,
})
{

  return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          appEventA,
                        );

                      },
                      style: roundedButtonStyle(),
                      child:  Text("A",style: applicationBlackTextStyle(50),),
                    ),
                  ),
                     SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          appEventB
                        );

                      },
                      style: roundedButtonStyle(),
                      child: Text("B",style: applicationBlackTextStyle(50),),
                    ),
                  ),
                     SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          appEventC
                        );

                      },
                      style: roundedButtonStyle(),
                      child: Text("C",style: applicationBlackTextStyle(50),),
                    ),
                  ),
                   SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          appEventAll
                        );

                      },
                      style: roundedButtonStyle(),
                      child: Text("All",style: applicationBlackTextStyle(26),),
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            );


}

SizedBox userPanelViewButton({
  required BuildContext context,
  required AppEvent appEvent,
  required Icon icon,
  required String title,
})
{
  return   SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.2,
      child: OutlinedButton(
        onPressed: ()
        {
            context.read<AppBloc>().add(appEvent);
        },
        style: applicationGreenButtonStyle(),
        child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const SizedBox(),
                    icon,
                    Text(title,style: applicationBlackTextStyle(20),),
                    const SizedBox(),
                 ],
                )

      ),
   );

}

