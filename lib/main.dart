import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/repositories/authentication_repository.dart';
import 'package:habit_tracker/repositories/habit_template_repository.dart';
import 'package:habit_tracker/repositories/user_repository.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AuthenticationRepository authRepo = AuthenticationRepository();

  var providers = MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (context) => authRepo),
      RepositoryProvider(create: (context) => UserRepository())
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AuthenticationBloc(
                  authenticationRepository: authRepo,
                )),
      ],
      child: App(),
    ),
  );
  runApp(providers);
}
