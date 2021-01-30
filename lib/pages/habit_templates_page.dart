import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';

class HabitTemplatesPage extends StatefulWidget {
  @override
  _HabitTemplatesPageState createState() => _HabitTemplatesPageState();
}

class _HabitTemplatesPageState extends State<HabitTemplatesPage> {
  AuthenticationBloc authenticationBloc;

  @override
  void initState() {
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Container(),
    );
  }
}
