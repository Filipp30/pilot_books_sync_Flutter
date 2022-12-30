import 'package:flutter/material.dart';
import 'package:pilot_books_sync_mobiel/providers/auth_provider.dart';
import 'package:pilot_books_sync_mobiel/screens/pilot_book_screen.dart';
import 'package:pilot_books_sync_mobiel/widgets/components/book_button.dart';
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
        title: const Text('Menu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
        [
          BookButton(title: 'ULM', callBack: () => Navigator.of(context).pushNamed(PilotBookScreen.routeName)),
          BookButton(title: 'PPL', callBack: (){}),
        ],
        ),
      )
    );
  }
}
