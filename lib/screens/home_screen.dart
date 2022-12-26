import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(child: Text('Home Screen'),),
    );
  }
}
