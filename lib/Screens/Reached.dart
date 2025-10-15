import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ob_park/Screens/ArNavigationScreen.dart';

class ReachedScreen extends StatelessWidget {
  const ReachedScreen({super.key});

  static const Color _green = Color(0xFF074139);
  static const Color _textDark = Color(0xFF2E3231);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 56,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => Navigator.of(context).maybePop(),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/arrow_back.svg',
                width: 36,
                height: 36,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 257),

              // Center block containing the badge + texts
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Main illustration (fixed to requested 280 x 211)
                    SizedBox(
                      width: 280,
                      height: 211,
                      child: SvgPicture.asset(
                        'assets/images/reached.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title with requested typography
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 128.0),
                      child: Text(
                        'You Have Arrived!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          // NOTE: To match exactly, add the Microgramma D Extended font in pubspec and assets.
                          fontFamily: 'MicrogrammaDExtended', // expects a custom font family mapping
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: 18,
                          height: 1.0, // line-height: 100%
                          letterSpacing: 0,
                          color: _textDark,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Supporting description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        'Please click button to find your car from parking location',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.3,
                          color: _textDark.withOpacity(0.75),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Bottom primary action button
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ArNavigationScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              elevation: 0,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            child: const Text('Find My Car'),
          ),
        ),
      ),
    );
  }
}
