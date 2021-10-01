import 'package:flutter/material.dart';
import 'package:habit_tracker/pages/login_page.dart';
import 'package:habit_tracker/pages/sign_up_page.dart';

class LoginSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            navigateToLoginPage(context);
          },
          child: Text('Log in'),
        ),
        TextButton(
          onPressed: () {
            navigateToSignUpPage(context);
          },
          child: Text('Sign up'),
        )
      ],
    );
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
