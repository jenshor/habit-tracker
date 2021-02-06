import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/pages/modify_habit_page.dart';
import 'package:habit_tracker/repositories/habit_repository.dart';
import 'package:habit_tracker/widgets/habits_list.dart';
import 'package:habit_tracker/widgets/login_signup.dart';
import 'package:habit_tracker/widgets/rounded_button.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class HabitDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return state.status == AuthenticationStatus.authenticated
          ? _app(state.user, context)
          : LoginSignup();
    });
  }

  Widget _addHabitButton(BuildContext context) {
    return RoundedButton(
        text: 'add',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => BlocProvider.value(
                    value: BlocProvider.of<HabitBloc>(context),
                    child: ModifyHabitPage()),
              ));
        });
  }

  Widget _app(User user, context) {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Habits',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  _addHabitButton(buildContext),
                ],
              ),
              SpacerBox.size16(),
              HabitsList(
                user: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
