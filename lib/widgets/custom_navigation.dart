import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/widgets/bloc_provider_widgets/habit_provider.dart';
import 'package:habit_tracker/widgets/login_signup.dart';
import 'package:habit_tracker/widgets/overview.dart';
import 'package:habit_tracker/widgets/habit_dashboard.dart';
import 'package:habit_tracker/widgets/user_dashboard.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({
    Key key,
  }) : super(key: key);

  @override
  _CustomNavigationState createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  int selectedIndex = 0;
  HashMap<int, Widget> widgets;

  @override
  void initState() {
    widgets = HashMap.from({
      0: Overview(
        onHabitClick: () => onNavigationItemChange(1),
      ),
      1: HabitDashboard(),
      2: UserDashboard(),
    });
    super.initState();
  }

  void onNavigationItemChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        User user = state.user;
        return Scaffold(
          extendBodyBehindAppBar: true,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (int index) {
              onNavigationItemChange(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.redoAlt),
                label: 'Habits',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.userAlt),
                label: 'User',
              ),
            ],
          ),
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: user != null
                  ? HabitProvider(
                      user: state.user,
                      child: widgets[selectedIndex],
                    )
                  : LoginSignup(),
            ),
          ),
        );
      },
    );
  }
}
