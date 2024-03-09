

import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatelessWidget
{

   RegisterView({Key? key}) : super(key: key);

   final emailController = TextEditingController();
   final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              child: const Text("Register",textAlign: TextAlign.left,style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: applicationColor,
              ),),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child:  TextField(
                    style: const TextStyle(
                      color: applicationColor,
                    ),
                    controller: emailController,
                    decoration: applicationInputDecoration(hintText: "Enter your email here...",
                    icon: Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: Brightness.dark,
                  ),
                  ),
                   SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child:   TextField(
                    style: const TextStyle(
                      color: applicationColor,
                    ),
                    controller: passwordController,
                    decoration: applicationInputDecoration(hintText: "Enter your password here...",
                    icon: Icons.lock),
                    obscureText: true,
                    obscuringCharacter: '*',
                    keyboardAppearance: Brightness.dark,
                  ),
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                   SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: OutlinedButton(
                        style: applicationButtonStyle(),
                        onPressed: ()
                        {
                          context.read<AppBloc>().add(
                            AppEventRegister(email: emailController.text, password: passwordController.text)
                          );
                        },
                        child: Text("Register"),
                      ),
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                 
                   
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}