import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/cubits/edit_user_cubit/edit_user_cubit.dart';
import 'package:habit_tracker/forms/widgets/edit_user_form.dart';
import 'package:habit_tracker/repositories/authentication_repository.dart';
import 'package:habit_tracker/widgets/custom_scaffold.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class EditUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Column(
      children: [
        Text(
          'Edit user',
          style: Theme.of(context).textTheme.headline6,
        ),
        SpacerBox.size24(),
        BlocProvider(
          create: (context) => EditUserCubit(
            RepositoryProvider.of<AuthenticationRepository>(context),
          ),
          child: EditUserForm(),
        ),
      ],
    ));
  }
}
