import 'package:auth_app/models/loginUser.dart';
import 'package:auth_app/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.contains('@') && value.contains('.com')) {
          return null;
        } else {
          return "Please enter a valid email address";
        }
      },
      decoration: const InputDecoration(
        labelText: "Email",
        prefixIcon: Icon(Icons.email),
      ),
    );
    final passwordField = TextFormField(
      controller: _password,
      obscureText: _showPassword,
      validator: (value) {
        if (value!.isEmpty || value == null) {
          return "Please enter your password";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
    );
    final txtButton = TextButton(
      onPressed: () {
        widget.toggleView();
      },
      child: const Text("Don't have an account? Register"),
    );

    final RegisterEmailPasswordButton = Material(
      child: MaterialButton(
        onPressed: () async {
          if (_globalKey.currentState!.validate()) {
            dynamic result = await _authService.registerWithEmailAndPassword(
              LoginUser(email: _email.text, password: _password.text),
            );
            if (result.uid == null) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: const Text(
                      "Failed to register with email and password",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
        child: const Text("Register with Email and Password"),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Form(
        key: _globalKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              emailField,
              const SizedBox(height: 16.0),
              passwordField,
              const SizedBox(height: 16.0),
              RegisterEmailPasswordButton,
              const SizedBox(height: 16.0),
              txtButton,
            ],
          ),
        ),
      ),
    );
  }
}
