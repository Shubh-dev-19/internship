import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ob_park/Screens/HomeScreen.dart';
import 'package:ob_park/Service/Login.dart';
import 'Signup.dart';

class ObparkLoginScreen extends StatefulWidget {
  const ObparkLoginScreen({super.key});

  @override
  State<ObparkLoginScreen> createState() => _ObparkLoginScreenState();
}

class _ObparkLoginScreenState extends State<ObparkLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthLoginService _authLoginService = AuthLoginService();

  bool isPasswordVisible = false;
  String? errorMessage;
  bool isLoading = false;

  Future<void> _handleLogin() async {
    if (isLoading) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please enter both email and password.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      print('Starting login for: $email');
      final userCredential = await _authLoginService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('Login successful! User: ${userCredential.user?.uid}');

      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      final currentUser = FirebaseAuth.instance.currentUser;
      print('Current user after delay: ${currentUser?.uid}');

      if (currentUser != null) {
        print('Forcing navigation as fallback');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const ObparkHomeScreen()),
              (route) => false,
        );
      }

    } on AuthFailure catch (e) {
      print('Login failed: ${e.message}');
      if (mounted) {
        setState(() {
          errorMessage = e.message;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Unexpected error during login: $e');
      if (mounted) {
        setState(() {
          errorMessage = 'Unexpected error. Please try again later.';
          isLoading = false;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),

              // OBPARK Logo
              Center(
                child: SvgPicture.asset(
                  'assets/images/Obparklogo.svg',
                  width: 327,
                  height: 49.9,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 42),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: emailController,
                  enabled: !isLoading,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: passwordController,
                  enabled: !isLoading,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    suffixIcon: IconButton(
                      onPressed: isLoading
                          ? null
                          : () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ),
              ),

              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: Colors.red.shade700, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            errorMessage!,
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 24),

              Container(
                width: 335,
                height: 49,
                decoration: BoxDecoration(
                  color: isLoading
                      ? const Color(0xFFC3EAD3).withOpacity(0.6)
                      : const Color(0xFFC3EAD3),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: isLoading ? null : _handleLogin,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                          ),
                        )
                            : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                width: 335,
                height: 21,
                child: SvgPicture.asset(
                  'assets/images/divider.svg',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),

              Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isLoading ? null : () {
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/Gbutton.svg',
                          height: 56,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isLoading ? null : () {
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/Fbutton.svg',
                          height: 56,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isLoading ? null : () {
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/Mbutton.svg',
                          height: 56,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).viewInsets.bottom > 0 ? 20 : 60),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: isLoading
                          ? null
                          : () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const ObparkSignUpScreen()),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 14,
                          color: isLoading
                              ? const Color(0xFF2E5266).withOpacity(0.5)
                              : const Color(0xFF2E5266),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'By creating an account, you accept our\nTerms and Conditions and read our Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}