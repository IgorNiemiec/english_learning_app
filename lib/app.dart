
import 'package:english_learning_app/bloc/app_bloc.dart';
import 'package:english_learning_app/bloc/app_event.dart';
import 'package:english_learning_app/bloc/app_state.dart';
import 'package:english_learning_app/constants/constants.dart';
import 'package:english_learning_app/dialogs/show_auth_error.dart';
import 'package:english_learning_app/loading/loading_screen.dart';
import 'package:english_learning_app/views/login_view.dart';
import 'package:english_learning_app/views/main_panel_view.dart';
import 'package:english_learning_app/views/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (_) => AppBloc()..add(const AppEventInitialize()),
      child: MaterialApp(
        title: "English Learning App",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocConsumer<AppBloc,AppState>(
          listener: (context, appState) {

              if (appState.isLoading)
              {
                LoadingScreen.instance().show(
                  context: context,
                  text: "Loading");
              }
              else
              {
                LoadingScreen.instance().hide();
              }

              final authError = appState.authError;

              if (authError!=null)
              {
                showAuthError(context: context, authError: authError);
              }
          },
          builder: (context, appState) {

            if(appState is AppStateLoggedOut)
            {
              return LoginView();
            }
            else if (appState is AppStateLoggedIn)
            {
              return const MainPanelView();
            }
            else if (appState is AppStateIsInRegistrationView)
            {
              return RegisterView();
            }
            else
            {
              return Container();
            }
            
          },
        ),
      ),
      
   
   
   );
  }
}