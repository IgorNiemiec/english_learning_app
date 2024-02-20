

import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget
{
   LoginView({Key? key}) : super(key: key);

  
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
              child: Text("Login",textAlign: TextAlign.left,style: TextStyle(
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
                    style: TextStyle(
                      color: applicationColor,
                    ),
                    controller: emailController,
                    decoration: applicationInputDecoration(hintText: "Enter your email here..."),
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
                    decoration: applicationInputDecoration(hintText: "Enter your password here..."),
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
                            AppEventLogIn(email: emailController.text, password: passwordController.text)
                          );
                        },
                        child: Text("Login"),
                      ),
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                   Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: OutlinedButton(
                      onPressed: ()
                      {

                      },
                      child: Text("Sign in with Google",style: TextStyle(
                        color: Colors.yellow
                      ),),
                    ),
                   ),
                   )
                   
                ],
              ),
            ),
             Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  context.read<AppBloc>().add(
                    AppEventGoToRegistration()
                  );
                },
                child: Text("Haven't account yet? Register",style: TextStyle(
                  color: applicationColor
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}