import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/repositories/habit_repository.dart';

class HabitProvider extends StatelessWidget {
  final Widget child;
  final User user;
  const HabitProvider({
    Key key,
    this.child,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => HabitRepository(user.id.value),
        child: BlocProvider(
          create: (context) => HabitBloc(
            repository: RepositoryProvider.of<HabitRepository>(context),
          )..add(
              HabitsLoading(),
            ),
          child: Builder(
            builder: (context) {
              return BlocBuilder<HabitBloc, HabitState>(
                  builder: (context, state) {
                return child;
              });
            },
          ),
        ));
  }
}
