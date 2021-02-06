import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:habit_tracker/models/user.dart';
import 'package:habit_tracker/widgets/custom_card.dart';
import 'package:habit_tracker/widgets/spacer_box.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        User user = state.user;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: Theme.of(context).textTheme.headline4,
            ),
            SpacerBox.size16(),
            UserCard(user: user),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                TextButton(onPressed: () {}, child: Text('Log out')),
                TextButton(onPressed: () {}, child: Text('Delete account')),
              ],
            )
          ],
        );
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
                  user.fullName,
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
