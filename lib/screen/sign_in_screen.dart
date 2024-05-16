import 'package:flutter/material.dart';
import '../utils/authentication.dart';
import '../res/custom_colors.dart';
import '../widgets/google_sign_in_button.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.firebaseNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 20.0
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/firebase_logo.png',
                        height: 160,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'FlutterFire',
                      style: TextStyle(
                        color: ColorsConstants.firebaseYellow,
                        fontSize: 40
                      )
                    ),
                    const Text(
                      'Autenticación',
                      style: TextStyle(
                        color: ColorsConstants.firebaseOrange,
                        fontSize: 40
                      )
                    )
                  ],
                ),
              ),
              FutureBuilder(
                future: Authentication.initializefirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error inicializando Firebase',);
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton(); // implementar
                  }
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorsConstants.firebaseOrange
                    )
                  );
                },
              )
            ],
          ),
        ),
      )
    );
  }
}