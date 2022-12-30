import 'package:flutter/material.dart';
import 'package:pilot_books_sync_mobiel/providers/auth_provider.dart';
import 'package:pilot_books_sync_mobiel/providers/pilot_book_provider.dart';
import 'package:pilot_books_sync_mobiel/screens/auth_screen.dart';
import 'package:pilot_books_sync_mobiel/screens/home_screen.dart';
import 'package:pilot_books_sync_mobiel/screens/pilot_book_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
    [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProxyProvider<AuthProvider, PilotBookProvider>(
        create: (_) => PilotBookProvider(null),
        update: (context, auth, book) => PilotBookProvider(auth),
      ),
    ],
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => MaterialApp(
          theme: ThemeData(),
          home: AuthProvider.isAuthenticated ? HomeScreen() : AuthScreen(),

          routes: {
            AuthScreen.routeName: (context) => AuthScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            PilotBookScreen.routeName: (context) => PilotBookScreen()
          },
        ),
      ),
    );
  }
}
