import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen4 extends StatelessWidget {
  const MainScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ListTile(
        title: const Text('sign out'),
        onTap: () {
          FirebaseAuth.instance.signOut();
        },
      )),
    );
  }
}
