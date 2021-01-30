import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/widgets/habit_templates.dart';
import 'package:habit_tracker/widgets/login_signup.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Habits'),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.status == AuthenticationStatus.authenticated
                      ? HabitTemplates(
                          user: state.user,
                        )
                      : LoginSignup(),
                ],
              );
            },
          ),
        ));
  }
}
