import 'package:auth_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final signOut = Material(
      child: MaterialButton(
        onPressed: () async {
          await _auth.signOut();
        },
        child: const Text('Sign Out'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: signOut,
      ),
    );
   
  }
}