import 'package:flutter/material.dart';
import 'package:pilot_books_sync_mobiel/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.logout), onPressed: ()=> Provider.of<AuthProvider>(context, listen: false).logout())
        ],
        title: const Text('Home Screen'),
      ),
      body: Center(child: Text('Home Screen'),),
    );
  }
}
