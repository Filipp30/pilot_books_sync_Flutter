import 'package:flutter/material.dart';
import 'package:pilot_books_sync_mobiel/providers/auth_provider.dart';
import 'package:pilot_books_sync_mobiel/widgets/auth/auth_login_widget.dart';
import 'package:pilot_books_sync_mobiel/widgets/auth/auth_registration_widget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = 'auth-screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  bool _showLoginScreen = true;

  @override
  void initState() {
    super.initState();
    setState(()=> _isLoading = true);
    _autoLogin();
  }

  Future<void> _autoLogin() async {
    final _auth = Provider.of<AuthProvider>(context, listen: false);
    await _auth.tryAutoLogin();
    setState(()=> _isLoading = false);
  }

  void switchAuthScreen() => setState(() => _showLoginScreen = !_showLoginScreen);

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _showLoginScreen ? AuthLoginWidget(callBack: switchAuthScreen) : AuthRegistrationWidget(callBack: switchAuthScreen);
  }
}
