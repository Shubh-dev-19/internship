import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ob_park/Screens/MapService.dart';
import 'package:ob_park/Screens/ScanQrScreen.dart';
import 'package:ob_park/Screens/ArNavigationScreen.dart';
import 'package:ob_park/Screens/ComingSoon.dart';

import 'ProfileScreen.dart';

class ObparkHomeScreen extends StatefulWidget {
  const ObparkHomeScreen({Key? key}) : super(key: key);

  @override
  State<ObparkHomeScreen> createState() => _ObparkHomeScreenState();
}

class _AdImage extends StatelessWidget {
  final String assetPath;
  const _AdImage({required this.assetPath});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      fit: BoxFit.cover,
    );
  }
}

/*class _AdSvg extends StatelessWidget {
  final String assetPath;
  const _AdSvg({required this.assetPath});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      fit: BoxFit.cover,
    );
  }
}*/

class _ObparkHomeScreenState extends State<ObparkHomeScreen> {
  int _selectedIndex = 0;

  final PageController _adController = PageController(viewportFraction: 1.0);
  int _adIndex = 0;
  Timer? _adTimer;

  @override
  void initState() {
    super.initState();
    _adTimer = Timer.periodic(const Duration(seconds: 2), (t) {
      if (!mounted) return;
      final next = (_adIndex + 1) % 2;
      _adController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _adTimer?.cancel();
    _adController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SizedBox(
                      width: 27,
                      height: 28,
                      child: SvgPicture.asset(
                        'assets/images/newobparklogo.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 16,
                      child: SvgPicture.asset(
                        'assets/images/OBPARK.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16), // Circular ripple
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFFE0E0E0),
                        child: Icon(Icons.person, size: 18, color: Color(0xFF9E9E9E)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 334,
                        height: 44,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 16, right: 12),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                              const Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search parking spots, mall...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 16),
                                child: Icon(
                                  Icons.mic,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: 343,
                      height: 129,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: PageView(
                              controller: _adController,
                              onPageChanged: (i) => setState(() => _adIndex = i),
                              children: const [
                                _AdImage(assetPath: 'assets/cashon.png'),
                                _AdImage(assetPath: 'assets/cashon.png'),
                              ],
                            ),
                          ),
                          // Indicators bottom-left
                          Positioned(
                            left: 12,
                            bottom: 10,
                            child: Row(
                              children: List.generate(2, (i) {
                                final active = i == _adIndex;
                                return Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  width: active ? 20 : 8,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: active ? const Color(0xFF074139) : Colors.white.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /*  const Text(
                      'Listed Services',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),*/
                    const SizedBox(height: 20),

                    SizedBox(
                      width: 343,
                      height: 185,
                      child: Material(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ComingSoonScreen(),
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/images/ListedService.svg',
                            width: 343,
                            height: 185,
                            fit: BoxFit.cover,
                            placeholderBuilder: (ctx) => Container(color: Colors.black12),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E5266),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {},
                          child: const Center(
                            child: Text(
                              'Pre - Book Parking Spot',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Nearby Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),

                    ),

                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: NetworkImage('https://via.placeholder.com/400x120/4CAF50/FFFFFF?text=Parking+Area'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Available badge
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'Available',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                            // Location info
                            Positioned(
                              bottom: 12,
                              left: 12,
                              right: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      const Expanded(
                                        child: Text(
                                          'The Vehicle Park',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '• 1.0 km far',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '₹ 200 /hr',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Book Now button
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Text(
                                  'Book Now',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20), // Space before bottom navigation
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBottomNavItem(Icons.home, 'Home', 0),
            _buildBottomNavItem(Icons.navigation, 'Navigation', 1),
            _buildBottomNavItem(Icons.qr_code_scanner, '', 2, isCenter: true),
            _buildBottomNavItem(Icons.calendar_today, 'Bookings', 3),
            _buildBottomNavItem(Icons.store, 'Store', 4),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index, {bool isCenter = false}) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        if (index == 2) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ScanQrScreen()),
          );
        } else if (index == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const MapSample()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: isCenter
            ? SizedBox(
          width: 60,
          height: 48,
          child: Center(
            child: SvgPicture.asset(
              'assets/images/homescan.svg',
              width: 49,
              height: 48,
              fit: BoxFit.contain,
            ),
          ),
        )
            : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF2E5266) : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? const Color(0xFF2E5266) : Colors.grey,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}