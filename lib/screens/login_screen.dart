
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            loading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() => loading = true);
                    final success = await AuthService().signIn(emailController.text, passwordController.text);
                    setState(() => loading = false);
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login successful")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed")));
                    }
                  },
                  child: Text("Login"),
                ),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SignupScreen())),
              child: Text("Don't have an account? Sign up"),
            )
          ],
        ),
      ),
    );
  }
}
