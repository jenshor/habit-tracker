import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/pages/edit_user_page.dart';
import 'package:habit_tracker/repositories/authentication_repository.dart';
import 'package:habit_tracker/widgets/custom_card.dart';
import 'package:habit_tracker/widgets/rounded_button.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        User user = state.user;
        return user != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Account',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      RoundedButton(
                        text: 'edit',
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => RepositoryProvider.value(
                                  value: RepositoryProvider.of<
                                      AuthenticationRepository>(context),
                                  child: EditUserPage(),
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                  SpacerBox.size16(),
                  UserCard(user: user),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(AuthenticationLogoutRequested());
                          },
                          child: Text('Log out')),
                      TextButton(
                          onPressed: () {}, child: Text('Delete account')),
                    ],
                  )
                ],
              )
            : Container();
      },
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              foregroundImage: NetworkImage(
                  'https://lh3.googleusercontent.com/ogw/ADGmqu_WurUpc1t-dcRokmOGn0RikyA40ZehLmGK0O8hnA=s64-c-mo'),
            ),
            SpacerBox.size16(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name ?? '',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(user.email),
              ],
            )
          ],
        )
      ],
    ));
  }
}
