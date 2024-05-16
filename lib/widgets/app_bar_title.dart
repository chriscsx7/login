import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../res/custom_colors.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/firebase_logo.png',
          height: 20,
        ),
        const SizedBox(width: 8.0),
        const Text(
          'FlutterFire',
          style: TextStyle(
            color: ColorsConstants.firebaseYellow,
            fontSize: 18,
          ),
        ),
        const Text(
          'Authenticación',
          style: TextStyle(
            color: ColorsConstants.firebaseOrange,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}