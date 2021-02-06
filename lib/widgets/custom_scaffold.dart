import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/blocs/authentication_bloc/authentication_bloc.dart';

class CustomScaffold extends StatefulWidget {
  final Widget child;
  final List<Widget> actions;

  const CustomScaffold({
    Key key,
    @required this.child,
    this.actions,
  }) : super(key: key);

  @override
  _CustomScaffoldState createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          drawer: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(state.user.firstName),
                  accountEmail: Text(state.user.email),
                  currentAccountPicture: CircleAvatar(
                    foregroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/ogw/ADGmqu_WurUpc1t-dcRokmOGn0RikyA40ZehLmGK0O8hnA=s192-c-mo'),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
