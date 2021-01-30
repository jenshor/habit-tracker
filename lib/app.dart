import 'package:flutter/material.dart';

import 'pages/start_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App',
      home: StartPage(),
    );
  }
}
