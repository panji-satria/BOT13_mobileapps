import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Set a specific height or use double.infinity for full height
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextWidget(),
              SizedBox(height: 32),
              buildInputField(_emailController, 'Email'),
              SizedBox(height: 16),
              buildInputField(_passwordController, 'Password', isPassword: true),
              SizedBox(height: 16),
              buildInputField(_confirmPasswordController, 'Confirm Password', isPassword: true),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => performSignUp(context),
                child: Text('Sign Up'),
              ),
              SizedBox(height: 16),
              BuildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(TextEditingController controller, String labelText, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
        obscureText: isPassword,
      ),
    );
  }

  void performSignUp(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && password == confirmPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChatScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Pastikan isi dengan benar'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
  }
}

class AnimatedTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: -1, end: 0),
      duration: Duration(seconds: 1),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value * 50),
          child: Opacity(
            opacity: 1 + value,
            child: Text(
              'Selamat Datang Di BOT13',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildSignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Text("Sudah punya akun? Login"),
    );
  }
}
