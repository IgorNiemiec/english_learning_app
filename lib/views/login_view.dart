

import 'package:english_learning_app/constants/constants.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget
{
  const LoginView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Container(
              alignment: Alignment(-0.5,0.0),
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: const BoxDecoration(
                color: applicationColor,
                borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(300,100))
              ),
              child: Text("Welcome",textAlign: TextAlign.left,style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child:  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter your email here...",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    keyboardAppearance: Brightness.dark,
                  ),
                  ),
                   SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                   SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child:   TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Enter your password here...",
                    ),
                    obscureText: true,
                    obscuringCharacter: '*',
                    keyboardAppearance: Brightness.dark,
                  ),
                   ),
                ],
              ),
            ),
             Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: const BoxDecoration(
                color: applicationColor,
                borderRadius: BorderRadius.only(topLeft: Radius.elliptical(300, 100))
              ),
            ),


          ],
        ),
      ),
    );
  }
}