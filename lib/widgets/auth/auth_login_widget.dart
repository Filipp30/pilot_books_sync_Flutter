import 'package:flutter/material.dart';
import 'package:pilot_books_sync_mobiel/dto/user_login_dto.dart';
import 'package:pilot_books_sync_mobiel/widgets/functions/input_field_validation.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../functions/notifications.dart';

class AuthLoginWidget extends StatefulWidget {

  @override
  State<AuthLoginWidget> createState() => _AuthLoginWidgetState();
}

class _AuthLoginWidgetState extends State<AuthLoginWidget> {
  bool _isProcessing = false;
  bool _hidePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  _sizedBox() => const SizedBox(height: 20);
  _border(Color color) => OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)), borderSide: BorderSide(color: color, width: 2.0));

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) => Scaffold( appBar: AppBar( title: const Text('Login')),

    body: _isProcessing
        ? const Center(child: CircularProgressIndicator())
        : Form( key: _formKey, child: SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: Column(children: <Widget>[

      TextFormField(
          controller: _emailController,
          validator: validateEmail,
          keyboardType: TextInputType.emailAddress,
          focusNode: _emailFocus,
          onFieldSubmitted: (_) => _fieldFocusChange(context, _emailFocus, _passwordFocus),
          decoration: InputDecoration(
            labelText: 'Email *',
            prefixIcon: const Icon(Icons.email),
            enabledBorder: _border(Colors.black), focusedBorder: _border(Colors.blue), errorBorder: _border(Colors.red), focusedErrorBorder: _border(Colors.red),
          )), _sizedBox(),

      TextFormField(
        controller: _passwordController,
        focusNode: _passwordFocus,
        validator: (value) => value!.isEmpty ? 'Enter password' : null,
        onFieldSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          labelText: 'Password *',
          prefixIcon: const Icon(Icons.security),
          suffixIcon: IconButton(icon: Icon(_hidePassword ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => _hidePassword = !_hidePassword)),
          enabledBorder: _border(Colors.black), focusedBorder: _border(Colors.blue), errorBorder: _border(Colors.red), focusedErrorBorder: _border(Colors.red),
        ),
        obscureText: _hidePassword,
      ), _sizedBox(),

      TextButton.icon(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          icon: const Icon(Icons.login),
          label: const Text('Login'),
          onPressed: () => _submit()
      )

    ]),
    ),
    ),
  );

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isProcessing = true);

      UserLoginDto user = UserLoginDto(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await Provider.of<AuthProvider>(context, listen: false)
        .login(user)
        .then((response) => response.success
        ? showSnackBar(context: context, message: response.message, color: Colors.green)
        : showSnackBar(context: context, message: response.message, color: Colors.red)
      )
        .onError((error, stackTrace) => showExceptionDialog(context: context, title: 'Exception', content: error.toString(), actionText: 'close'))
        .whenComplete(() => setState(() => _isProcessing = false));
    }
  }
}

