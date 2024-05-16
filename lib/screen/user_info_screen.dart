import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/utils/authentication.dart';
import 'sign_in_screen.dart';
import '../res/custom_colors.dart';
import '../widgets/app_bar_title.dart';

class UserInfoScreen extends StatefulWidget {
  final User _user;
  const UserInfoScreen({Key? key, required User user}):
  _user = user,
  super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late User _user;
  bool _isSignInOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.firebaseNavy,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsConstants.firebaseNavy,
        title: AppBarTitle(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 20.0
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(),
              _user.photoURL != null
              ? ClipOval(
                child: Material(
                  color: ColorsConstants.firebaseGrey.withOpacity(0.3),
                  child: Image.network(
                    _user.photoURL!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ) : ClipOval(
                child: Material(
                  color: ColorsConstants.firebaseGrey.withOpacity(0.3),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: ColorsConstants.firebaseGrey,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Hola',
                style: TextStyle(
                  color: ColorsConstants.firebaseGrey,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                _user.displayName!,
                style: const TextStyle(
                  color: ColorsConstants.firebaseYellow,
                  fontSize: 26,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                '(${_user.email!})',
                style: const TextStyle(
                  color: ColorsConstants.firebaseOrange,
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                'Ahora ha iniciado sesión con su cuenta de Google. '
                'Para cerrar sesión, haga clic en el botón "Cerrar sesión" '
                'que aparece a continuación.',
                style: TextStyle(
                  color: ColorsConstants.firebaseGrey.withOpacity(0.8),
                  fontSize: 14,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 16.0),
              _isSignInOut
              ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white
                ),
              ) : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.redAccent
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _isSignInOut = true;
                  });
                  await Authentication.signOut(context: context);
                  setState(() {
                    _isSignInOut = false;
                  });
                  Navigator.of(context).pushReplacement(_routeToSignInScreen());
                },
                child: const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}