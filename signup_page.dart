import 'dart:math';
import 'package:flutter/material.dart';
import 'package:crest/authLogic/auth_signup.dart'; // Import authentication logic

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  final AuthService _authService = AuthService(); // Use the AuthService
  late bool _isEmailValid;
  late bool _isPasswordValid;
  late bool _isConfirmPasswordValid;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _isEmailValid = true;
    _isPasswordValid = true;
    _isConfirmPasswordValid = true;

    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validateConfirmPassword);
  }

  void _validateEmail() {
    final email = _emailController.text;
    setState(() {
      _isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
    });
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _isPasswordValid = password.length >= 8;
    });
  }

  void _validateConfirmPassword() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    setState(() {
      _isConfirmPasswordValid = password == confirmPassword;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUpWithEmail() async {
    if (_isEmailValid && _isPasswordValid && _isConfirmPasswordValid) {
      final userCredential = await _authService.signUpWithEmail(
        _emailController.text,
        _passwordController.text,
      );
      if (userCredential != null) {
        // Handle successful sign up, e.g., navigate to another screen
      } else {
        print('Failed to sign up with email');
      }
    } else {
      print('Invalid input');
    }
  }

  Future<void> _signUpWithGoogle() async {
    final userCredential = await _authService.signUpWithGoogle();
    if (userCredential != null) {
      // Handle successful sign up, e.g., navigate to another screen
    } else {
      print('Failed to sign up with Google');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 30,
              left: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: SoundWavePainter(
                        waveOffset: _controller.value * 2 * pi,
                      ),
                      size: const Size(double.infinity, 200),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              top: 240,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'CREST',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Ride the Peak of Sound',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon:
                            const Icon(Icons.email, color: Color(0xff0f0f0f)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: const Color(0xfffdfbfb),
                        errorText: _isEmailValid ? null : 'Invalid email',
                      ),
                      style: const TextStyle(color: Color(0xff0f0f0f)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xff000000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: const Color(0xffffffff),
                        errorText: _isPasswordValid
                            ? null
                            : 'Password must be at least 8 characters',
                      ),
                      style: const TextStyle(color: Color(0xff0f0f0f)),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xff000000)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: const Color(0xffffffff),
                        errorText: _isConfirmPasswordValid
                            ? null
                            : 'Passwords do not match',
                      ),
                      style: const TextStyle(color: Color(0xff0c0c0c)),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _signUpWithEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                        ),
                        child: const Text('Sign Up with Email'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: _signUpWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.red, // Google Sign-In button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                        ),
                        child: const Text('Sign Up with Google'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back to login screen
                        },
                        child: RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SoundWavePainter extends CustomPainter {
  final double waveOffset;

  SoundWavePainter({required this.waveOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final double amplitude = 20.0; // Increased amplitude
    final double frequency = 0.02;
    final double phaseShift = waveOffset;

    final Path path = Path();
    path.moveTo(0, size.height / 2);

    for (double x = 0; x < size.width; x++) {
      final double y =
          amplitude * sin(frequency * x + phaseShift) + size.height / 2;
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
