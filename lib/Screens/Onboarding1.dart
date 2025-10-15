import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



import 'package:ob_park/Screens/Onboarding2.dart' hide PageIndicatorDot;
import 'package:ob_park/Screens/Onboarding3.dart';


const Color kPrimaryGreen = Color(0xFF074139);
const Color kAccentPurple = Color(0xFFB7A8F9);

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Illustration and texts
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  SvgPicture.asset(
                    'assets/images/car.svg',
                    height: screenHeight * 0.35,
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to OBPARK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryGreen,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Find parking faster, Smarter, and stress - free.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom controls: SKIP ••• NEXT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OnboardingScreen3()),
                      );
                    },
                    child: const Text(
                      'SKIP',
                      style: TextStyle(
                        color: kAccentPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      PageIndicatorDot(isActive: true),
                      SizedBox(width: 8),
                      PageIndicatorDot(isActive: false),
                      SizedBox(width: 8),
                      PageIndicatorDot(isActive: false),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OnboardingScreen2()),
                      );
                    },
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        color: kPrimaryGreen,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageIndicatorDot extends StatelessWidget {
  final bool isActive;
  const PageIndicatorDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? kAccentPurple : const Color(0xFFE4E4E4),
      ),
    );
  }
}
