import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        User user = state.user;
        return state.status == AuthenticationStatus.authenticated
            ? Row(
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SpacerBox.size8(),
                  CircleAvatar(),
                ],
              )
            : Container();
      },
    );
  }
}
