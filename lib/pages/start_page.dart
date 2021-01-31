import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/pages/add_habit_page.dart';
import 'package:habit_tracker/repositories/habit_repository.dart';
import 'package:habit_tracker/widgets/custom_scaffold.dart';
import 'package:habit_tracker/widgets/habit_info.dart';
import 'package:habit_tracker/widgets/login_signup.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return CustomScaffold(
        child: state.status == AuthenticationStatus.authenticated
            ? _app(state.user)
            : LoginSignup(),
      );
    });
  }

  IconButton _addHabitButton(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => BlocProvider.value(
                    value: BlocProvider.of<HabitBloc>(context),
                    child: AddHabitPage()),
              ));
        });
  }

  Widget _app(User user) {
    return RepositoryProvider(
      create: (context) => HabitRepository(user.id.value),
      child: BlocProvider(
        create: (context) => HabitBloc(
          repository: RepositoryProvider.of<HabitRepository>(context),
        )..add(
            HabitsLoading(),
          ),
        child: Builder(
          builder: (buildContext) => Column(
            children: [
              Row(
                children: [
                  Text(
                    'Habits',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  _addHabitButton(buildContext),
                ],
              ),
              HabitTemplates(
                user: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
