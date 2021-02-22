import 'package:flutter/material.dart';

import 'presentation/pages/home_page.dart';

class EntryWidget extends StatelessWidget {
  const EntryWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
