import 'package:fire_flutter_auth/pages/Authentication/authentication.dart';
import 'package:fire_flutter_auth/pages/Authentication/login.dart';
import 'package:fire_flutter_auth/pages/homeScreens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user != null) {
      return HomeScreen();
    } else {
      return Authentication();
    }
  }
}
