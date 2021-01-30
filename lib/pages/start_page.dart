import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/login_page.dart';
import 'package:habit_tracker/pages/sign_up_page.dart';

class StartPage extends StatefulWidget {
  StartPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ButtonBar(
                children: [
                  ButtonBar(
                    children: [
                      RaisedButton(
                        onPressed: () {
                          navigateToLoginPage(context);
                        },
                        child: Text('Log in'),
                      ),
                      FlatButton(
                        onPressed: () {
                          navigateToSignUpPage(context);
                        },
                        child: Text('Sign up'),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

  void navigateToSignUpPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SignUpPage(),
    ));
  }

  void navigateToLoginPage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => LoginPage(),
    ));
  }
}
