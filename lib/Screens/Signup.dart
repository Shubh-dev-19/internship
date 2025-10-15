import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ob_park/Service/Signup.dart';

class ObparkSignUpScreen extends StatefulWidget {
  const ObparkSignUpScreen({super.key});

  @override
  State<ObparkSignUpScreen> createState() => _ObparkSignUpScreen();
}

class _ObparkSignUpScreen extends State<ObparkSignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final AuthSignupService _authSignupService = AuthSignupService();

  bool isPasswordVisible = false;
  String? errorMessage;
  bool isLoading = false;

  Future<void> _handleSignup() async {
    if (isLoading) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        errorMessage = 'All fields are required.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        errorMessage = 'Passwords do not match.';
      });
      return;
    }

    if (password.length < 6) {
      setState(() {
        errorMessage = 'Password must be at least 6 characters.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await _authSignupService.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );



    } on AuthFailure catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.message;
          isLoading = false;
        });
      }
    } catch (e) {
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

              // Email TextField Container
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

              // Password TextField Container
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

              const SizedBox(height: 16),

              // Confirm Password TextField Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: TextField(
                  controller: confirmPasswordController,
                  enabled: !isLoading,
                  obscureText: !isPasswordVisible,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
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

              // Sign Up Button
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
                    onTap: isLoading ? null : _handleSignup,
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
                          'Sign Up',
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

              // Or better yet text
              SizedBox(
                width: 335,
                height: 21,
                child: SvgPicture.asset(
                  'assets/images/divider.svg',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),

              // Social login buttons container
              Column(
                children: [
                  // Continue with Google
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isLoading ? null : () {
                        // Handle Google signup
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

                  // Continue with Facebook
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isLoading ? null : () {
                        // Handle Facebook signup
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

                  // Continue with Phone Number
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isLoading ? null : () {
                        // Handle Phone signup
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

              // Already have an account
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: isLoading
                          ? null
                          : () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Login',
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

              // Terms and Privacy Policy
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
    confirmPasswordController.dispose();
    super.dispose();
  }
}