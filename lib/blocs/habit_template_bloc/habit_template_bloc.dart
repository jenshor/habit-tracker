import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'habit_template_event.dart';
part 'habit_template_state.dart';

class HabitTemplateBloc extends Bloc<HabitTemplateEvent, HabitTemplateState> {
  HabitTemplateBloc() : super(HabitTemplateInitial());

  @override
  Stream<HabitTemplateState> mapEventToState(
    HabitTemplateEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
