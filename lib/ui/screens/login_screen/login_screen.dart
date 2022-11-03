import 'package:flutter/material.dart';
import 'package:scannerappflutter/services/encryption_service.dart';
import 'package:scannerappflutter/services/login_service.dart';
import 'package:scannerappflutter/ui/app_route.dart';
import 'package:scannerappflutter/ui/screens/base_page/base_page.dart';
import 'package:scannerappflutter/ui/widgets/buttons/column_button/column_button.dart';
import 'package:scannerappflutter/ui/widgets/buttons/column_button/column_navigation_back_button.dart';
import 'package:scannerappflutter/ui/widgets/spinner/loading_spinner.dart';
import 'package:scannerappflutter/ui/widgets/title/title.dart';

class LoginScreen extends BasePage {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends BasePageState<LoginScreen> {
  final LoginService _loginService = LoginService();
  final EncryptionService _encryptionService = EncryptionService();
  final _loginTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();

  String _login = '';
  String _password = '';

  @override
  void initState() {
    super.initState();

    _loginTextEditingController.addListener(() {
      _login = _loginTextEditingController.text;
    });

    _passwordTextEditingController.addListener(() {
      _password = _passwordTextEditingController.text;
    });
  }

  @override
  void dispose() {
    _loginTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isBusy) {
      return const LoadingSpinner();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: const PageTitle(text: 'Sign in'),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: _loginTextEditingController,
                        style: const TextStyle(letterSpacing: 2.0),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'login',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextField(
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        controller: _passwordTextEditingController,
                        style: const TextStyle(letterSpacing: 2.0),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'password',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ColumnButton(
                      text: 'Login',
                      onPressed: () async => await loginCommandAsync(context)),
                  ColumnNavigationBackButton(
                    context: context,
                    text: "Back",
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future showLoginFailedDialog() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Error'),
        content: const Text(
            'Login failed. Invalid credentials or user does not exists.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future loginCommandAsync(BuildContext context) async {
    await busyActionAsync(loginAsync(context));
  }

  Future loginAsync(BuildContext context) async {
    bool loginSuccess;
    try {
      var encryptedPassword = _encryptionService.encryptUserPassword(_password);
      loginSuccess =
          await _loginService.logUserInAsync(_login, encryptedPassword);
    } catch (e) {
      loginSuccess = false;
    }

    if (!loginSuccess) {
      await showLoginFailedDialog();
      return;
    }

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushNamed(AppRoute.scannerScreen.name);
  }
}
