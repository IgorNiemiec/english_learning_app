

import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/utils/utils.dart';
import 'package:flutter/material.dart';

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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15,),
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
                          
                        },
                        child: Text("Login"),
                      ),
                   ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                ],
              ),
            ),
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),


          ],
        ),
      ),
    );
  }
}