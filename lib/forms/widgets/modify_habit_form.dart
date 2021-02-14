import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/cubits/modify_habit_cubit/modify_habit_cubit.dart';
import 'package:habit_tracker/models/habit.dart';

enum ModifyMode { change, create }

class ModifyHabitForm extends StatelessWidget {
  final Habit habit;
  final ModifyMode mode;

  const ModifyHabitForm({Key key, this.habit})
      : mode = habit == null ? ModifyMode.create : ModifyMode.change,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ModifyHabitCubit(habit: this.habit),
      child: Column(
        children: [
          _HabitNameInput(),
          AcceptButton(
            mode: mode,
            onPressed: (ModifyHabitState state) => method(context, state),
          ),
        ],
      ),
    );
  }

  Habit getHabit(
    ModifyHabitState state,
  ) {
    String name = state.name.value;
    return mode == ModifyMode.create
        ? Habit.fromDate(name: name, date: DateTime.now())
        : habit.copyWith(name: name);
  }

  HabitEvent getEvent(
    ModifyHabitState state,
  ) {
    Habit habit = getHabit(state);
    return mode == ModifyMode.create ? HabitAdded(habit) : HabitChanged(habit);
  }

  void method(
    BuildContext context,
    ModifyHabitState state,
  ) {
    BlocProvider.of<HabitBloc>(context).add(getEvent(state));
  }
}

class AcceptButton extends StatelessWidget {
  final ModifyMode mode;
  final Function(ModifyHabitState state) onPressed;

  const AcceptButton(
      {Key key, this.mode = ModifyMode.create, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModifyHabitCubit, ModifyHabitState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed:
              state.status == FormzStatus.valid ? () => onPressed(state) : null,
          child: Text(getCallToActionText()),
        );
      },
    );
  }

  String getCallToActionText() {
    return mode == ModifyMode.create ? 'Create habit' : 'Change habit';
  }
}

class _HabitNameInput extends StatefulWidget {
  const _HabitNameInput({Key key}) : super(key: key);

  @override
  __HabitNameInputState createState() => __HabitNameInputState();
}

class __HabitNameInputState extends State<_HabitNameInput> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(
        text: BlocProvider.of<ModifyHabitCubit>(context).state.name.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModifyHabitCubit, ModifyHabitState>(
      builder: (context, state) {
        return TextField(
          controller: controller,
          onChanged: (name) =>
              context.read<ModifyHabitCubit>().nameChanged(name),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: 'name',
            helperText: '',
            errorText: state.name.invalid ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}
