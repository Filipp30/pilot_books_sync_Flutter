import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pilot_books_sync_mobiel/dto/user_registration_dto.dart';
import 'package:pilot_books_sync_mobiel/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../functions/input_field_validation.dart';
import '../functions/notifications.dart';

class AuthRegistrationWidget extends StatefulWidget {
  final callBack;
  AuthRegistrationWidget({required this.callBack});

  @override
  State<AuthRegistrationWidget> createState() => _AuthRegistrationWidgetState();
}

class _AuthRegistrationWidgetState extends State<AuthRegistrationWidget> {

  _border(Color color) => OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(20.0)), borderSide: BorderSide(color: color, width: 2.0));
  _sizedBox() => const SizedBox(height: 20);

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;
  bool _isProcessing = false;

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmationFocus = FocusNode();

  void _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmationFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold( appBar: AppBar( title: const Text('Registration')),

    body: _isProcessing
      ? const Center(child: CircularProgressIndicator())
      : Form( key: _formKey, child: SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: Column(children: <Widget>[

          TextFormField(
            controller: _nameController,
            validator: (value) => validateName(value),
            focusNode: _nameFocus,
            onFieldSubmitted: (_) => _fieldFocusChange(context, _nameFocus, _emailFocus),
            decoration: InputDecoration(
              labelText: 'Full name *',
              prefixIcon: const Icon(Icons.person),
              enabledBorder: _border(Colors.black), focusedBorder: _border(Colors.blue), errorBorder: _border(Colors.red), focusedErrorBorder: _border(Colors.red),
            )), _sizedBox(),

          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            focusNode: _emailFocus,
            onFieldSubmitted: (_) => _fieldFocusChange(context, _emailFocus, _phoneFocus),
            decoration: InputDecoration(
              labelText: 'Email *',
              prefixIcon: const Icon(Icons.email),
              enabledBorder: _border(Colors.black), focusedBorder: _border(Colors.blue), errorBorder: _border(Colors.red), focusedErrorBorder: _border(Colors.red),
            )), _sizedBox(),

          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            focusNode: _phoneFocus,
            onFieldSubmitted: (_) => _fieldFocusChange(context, _phoneFocus, _passwordFocus),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
              labelText: 'Phone',
              prefixIcon: const Icon(Icons.phone),
              enabledBorder: _border(Colors.black), focusedBorder: _border(Colors.blue), errorBorder: _border(Colors.red), focusedErrorBorder: _border(Colors.red),
            )), _sizedBox(),

          TextFormField(
            controller: _passwordController,
            validator: validatePassword,
            focusNode: _passwordFocus,
            onFieldSubmitted: (_) => _fieldFocusChange(context, _passwordFocus, _confirmationFocus),
            decoration: InputDecoration(
              labelText: 'Password *',
              prefixIcon: const Icon(Icons.security),
              suffixIcon: IconButton(icon: Icon(_hidePassword ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => _hidePassword = !_hidePassword)),
              enabledBorder: _border(Colors.black), focusedBorder: _border(Colors.blue), errorBorder: _border(Colors.red), focusedErrorBorder: _border(Colors.red),
            ),
            obscureText: _hidePassword,
            maxLength: 8,
          ), _sizedBox(),

          TextFormField(
            controller: _confirmationController,
            validator: _validateConfirmation,
            focusNode: _confirmationFocus,
            onFieldSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: 'Confirm password *',
              prefixIcon: const Icon(Icons.security),
              suffixIcon: IconButton(icon: Icon(_hideConfirmPassword ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => _hideConfirmPassword = !_hideConfirmPassword)),
              enabledBorder: _border(Colors.black), focusedBorder: _border(Colors.blue), errorBorder: _border(Colors.red), focusedErrorBorder: _border(Colors.red),
            ),
            obscureText: _hideConfirmPassword,
            maxLength: 8,
          ), _sizedBox(),

          TextButton.icon(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            ),
            icon: const Icon(Icons.app_registration),
            label: const Text('Register'),
            onPressed: () => _submit()
          ), _sizedBox(),

          TextButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Login'),
              onPressed: () => widget.callBack()
          ),

        ]),
      ),
    ),
  );

  void _submit() async {
    if (_formKey.currentState!.validate()) {

      _formKey.currentState!.save();
      setState(() => _isProcessing = true);

      UserRegistrationDto user = UserRegistrationDto(
          name: _nameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
          confirmation: _confirmationController.text
      );

      await Provider.of<AuthProvider>(context, listen: false)
          .registration(user)
          .then((response) => response.success
            ? {showSnackBar(context: context, message: response.message, color: Colors.green), widget.callBack()}
            : showSnackBar(context: context, message: response.message, color: Colors.red)
          )
          .onError((error, stackTrace) => showExceptionDialog(context: context, title: 'Exception', content: error.toString(), actionText: 'close'))
          .whenComplete(() => setState(() => _isProcessing = false));
    }
  }

  String? _validateConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (value != _passwordController.text) {
      return 'Not matching password';
    }
    return null;
  }
}
