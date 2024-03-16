

import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class RegisterView extends StatelessWidget
{

   RegisterView({Key? key}) : super(key: key);

   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final passwordConfirmationController = TextEditingController();

   final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context)
  {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Text("Register",textAlign: TextAlign.left,style: applicationTextStyle(50)),
            ),
             Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: applicationColor,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child:  TextField(
                    style: applicationBlackTextStyle(25),
                    controller: emailController,
                    decoration: applicationInputDecoration(hintText: "Email",
                    icon: Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: Brightness.dark,
                  ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: applicationColor,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                    style: applicationBlackTextStyle(25),
                    controller: passwordController,
                    decoration: applicationInputDecoration(hintText: "Password",
                    icon: Icons.lock),
                    obscureText: true,
                    obscuringCharacter: '*',
                    keyboardAppearance: Brightness.dark,
                    cursorColor: Colors.black,
                  ),
                    ),
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                   Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: applicationColor,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                    style: applicationBlackTextStyle(22),
                    controller: passwordConfirmationController,
                    decoration: applicationInputDecoration(hintText: "Confirm password",
                    icon: Icons.lock),
                    obscureText: true,
                    obscuringCharacter: '*',
                    keyboardAppearance: Brightness.dark,
                    cursorColor: Colors.black,
                  ),
                    ),
                   ),
                   SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                   ),
                   SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.08,
                      child: OutlinedButton(
                        style: applicationButtonStyle(),
                        onPressed: ()
                        {

                            context.read<AppBloc>().add(
                              AppEventRegister(
                                email: emailController.text, 
                                password: passwordController.text,
                                confirmPassword: passwordConfirmationController.text)
                            );

                        },
                        child: Text("Register",style: applicationTextStyle(30),),
                      ),
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                   applicationGoogleButton(context, "Sign up with Google"),
                ],
              ),
             ),
            
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: ()
                {
                  context.read<AppBloc>().add(
                    const AppEventGoToLogIn()
                  );
                },
                child: Text("Already have an account? Login",style: applicationTextStyle(19),),
              ),
            ),
          
            
          ],
        ),
      ),
    );
  }
}