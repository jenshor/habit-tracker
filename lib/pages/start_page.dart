import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/blocs/habit_template_bloc/habit_template_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/pages/add_habit_template_page.dart';
import 'package:habit_tracker/repositories/habit_template_repository.dart';
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
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => BlocProvider.value(
                            value: BlocProvider.of<HabitTemplateBloc>(context),
                            child: AddHabitTemplatePage()),
                      ));
                })
          ],
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  state.status == AuthenticationStatus.authenticated
                      ? _app(state.user)
                      : LoginSignup(),
                ],
              );
            },
          ),
        ));
  }

  Widget _app(User user) {
    return RepositoryProvider(
      create: (context) => HabitTemplateRepository(userId: user.id.value),
      child: BlocProvider(
        create: (context) => HabitTemplateBloc(
          repository: RepositoryProvider.of<HabitTemplateRepository>(context),
        )..add(
            HabitTemplateLoading(),
          ),
        child: HabitTemplates(
          user: user,
        ),
      ),
    );
  }
}
