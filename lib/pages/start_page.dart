import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/blocs/habit_bloc/habit_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/pages/modify_habit_page.dart';
import 'package:habit_tracker/repositories/habit_repository.dart';
import 'package:habit_tracker/widgets/custom_navigation.dart';
import 'package:habit_tracker/widgets/custom_scaffold.dart';
import 'package:habit_tracker/widgets/habits_list.dart';
import 'package:habit_tracker/widgets/login_signup.dart';
import 'package:habit_tracker/widgets/rounded_button.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

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
      return CustomNavigation();
    });
  }
}
