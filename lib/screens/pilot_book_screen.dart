import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pilot_books_sync_mobiel/providers/pilot_book_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/functions/notifications.dart';

enum BookType {
  ULM,
  PPL,
}

class PilotBookScreen extends StatelessWidget {
  static const routeName = 'pilot-book-screen';
  // const PilotBookScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
        body: FutureBuilder<dynamic>(
          future: Provider.of<PilotBookProvider>(context, listen: false).getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center( child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == 401) {
                showExceptionDialog(context: context, title: 'Unauthenticated', content: 'Your authentication session is expired. Please login again.', actionText: 'exit');
                // sleep(const Duration(seconds: 3));
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                //
                // });
              }
            }

            print(snapshot.data);
            return Center(child: Text('done'));
          },
        )
    );
  }
}
