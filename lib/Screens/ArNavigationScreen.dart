import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArNavigationScreen extends StatelessWidget {
  const ArNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image (same as Scan screen)
          Positioned.fill(
            child: Image.asset(
              'assets/images/qrbgg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top app bar with white circular back and centered title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () => Navigator.of(context).maybePop(),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Color(0xFF1D1F24),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 116,
                        height: 24,
                        child: Center(
                          child: Text(
                            'AR Navigation',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: 0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                // Info card (content-driven height to avoid overflow)
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 343),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Distance',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF6B6F76),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.0,
                                ),
                              ),
                              Text(
                                'Parking Lot',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF6B6F76),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '200m',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF1D1F24),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                ),
                              ),
                              Text(
                                'A-02',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF1D1F24),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Use Wrap so chips can flow and increase height when needed
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F3F5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Park your car',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF6B6F76),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF2F3F5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '2nd Floor',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF6B6F76),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Placeholder for AR preview/camera area or future content
                Expanded(
                  child: Center(
                    child: Text(
                      'AR preview goes here',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}