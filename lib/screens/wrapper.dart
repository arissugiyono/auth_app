import 'package:auth_app/models/firebaseUser.dart';
import 'package:auth_app/screens/authentication/handler.dart';
import 'package:auth_app/screens/home/home.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser?>(context);
    // Do something with the user object
    if (user == null) {
      return Handler();
    } else {
      return Home();
    }
  }
}