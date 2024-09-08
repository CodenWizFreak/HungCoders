import 'dart:math';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late bool _isEmailValid;
  late bool _isPhoneValid;
  late bool _isPasswordValid;
  late bool _isConfirmPasswordValid;
  bool _isEmailSelected = true; // Toggle between email and phone

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _isEmailValid = true;
    _isPhoneValid = true;
    _isPasswordValid = true;
    _isConfirmPasswordValid = true;

    _emailController.addListener(_validateEmail);
    _phoneController.addListener(_validatePhone);
    _passwordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validateConfirmPassword);
  }

  void _validateEmail() {
    final email = _emailController.text;
    setState(() {
      _isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);
    });
  }

  void _validatePhone() {
    final phone = _phoneController.text;
    setState(() {
      _isPhoneValid =
          RegExp(r'^\d{10}$').hasMatch(phone); // Validates 10-digit number
    });
  }

  void _validatePassword() {
    final password = _passwordController.text;
    setState(() {
      _isPasswordValid = password.length >= 8; // Example password restriction
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
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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
                      size: Size(double.infinity, 200),
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
                    Text(
                      'CREST',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffad62fc),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Ride the Peak of Sound',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ToggleButtons(
                          isSelected: [_isEmailSelected, !_isEmailSelected],
                          onPressed: (index) {
                            setState(() {
                              _isEmailSelected = index == 0;
                            });
                          },
                          color: Colors.white,
                          selectedColor: Color(0xffad62fc),
                          fillColor: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text('Email'),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text('Phone No.'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child: _isEmailSelected
                          ? buildEmailInput()
                          : buildPhoneInput(),
                    ),
                    SizedBox(height: 20),
                    buildPasswordInput(),
                    SizedBox(height: 20),
                    buildConfirmPasswordInput(),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if ((_isEmailSelected && _isEmailValid) ||
                              (!_isEmailSelected && _isPhoneValid) &&
                                  _isPasswordValid &&
                                  _isConfirmPasswordValid) {
                            // Handle sign-up action
                          }
                        },
                        child: Text('Sign Up'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back to login screen
                        },
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                  color: Color(0xffad62fc),
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

  Widget buildEmailInput() {
    return TextField(
      key: ValueKey('email'),
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email, color: Color(0xff000000)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Color(0xffffffff),
        errorText: _isEmailValid ? null : 'Invalid email',
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget buildPhoneInput() {
    return TextField(
      key: ValueKey('phone'),
      controller: _phoneController,
      decoration: InputDecoration(
        labelText: 'Phone No.',
        prefixIcon: Icon(Icons.phone, color: Color(0xff000000)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Color(0xffffffff),
        errorText: _isPhoneValid ? null : 'Invalid phone number',
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.phone,
    );
  }

  Widget buildPasswordInput() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock, color: Color(0xff000000)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Color(0xffffffff),
        errorText:
            _isPasswordValid ? null : 'Password must be at least 8 characters',
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget buildConfirmPasswordInput() {
    return TextField(
      controller: _confirmPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        prefixIcon: Icon(Icons.lock, color: Color(0xff000000)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Color(0xffffffff),
        errorText: _isConfirmPasswordValid ? null : 'Passwords do not match',
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}

class SoundWavePainter extends CustomPainter {
  final double waveOffset;

  SoundWavePainter({required this.waveOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color(0xffad62fc)
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
