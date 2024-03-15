

import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/TheBlum.png"),
                  fit: BoxFit.scaleDown)
                ),
              )
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
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
                      height: MediaQuery.of(context).size.height * 0.08,
                      child:  TextField(
                    style: applicationBlackTextStyle(25),
                    controller: emailController,
                    decoration: applicationInputDecoration(hintText: "Email",icon: Icons.email),
                    keyboardType: TextInputType.emailAddress,
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
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: TextField(
                    style: applicationBlackTextStyle(25),
                    controller: passwordController,
                    decoration: applicationInputDecoration(hintText: "Password",
                    icon: Icons.lock),
                    obscureText: true,
                    obscuringCharacter: '*',
                    keyboardAppearance: Brightness.dark,
                  ),
                    ),
                    
                    
                     
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                   Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: OutlinedButton(
                      onPressed: ()
                      {
                        context.read<AppBloc>().add(
                          const AppEventLogInWithGoogleAuth()
                        );

                      },
                      style: applicationButtonStyle(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const SizedBox(),
                          SvgPicture.asset(
                            'assets/google.svg',
                            width: MediaQuery.of(context).size.width * 0.06,
                          ),
                          Text("Sign in with Google",style: applicationTextStyle(20),),
                          const SizedBox(),
                      ],)
                    ),
                   ),
                   ),
                   
                   SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
                   SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: OutlinedButton(
                        style: roundedButtonStyle(),
                        onPressed: ()
                        {
                          context.read<AppBloc>().add(
                            AppEventLogIn(email: emailController.text, password: passwordController.text)
                          );
                        },
                        child: Icon(Icons.navigate_next,size: 60,),
                      ),
                   ),
                   
                   
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
                    AppEventGoToRegistration()
                  );
                },
                child: Text("Haven't account yet? Register",style: applicationTextStyle(19),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}