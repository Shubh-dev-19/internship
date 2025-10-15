import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 24),
              
              // Profile Picture with Edit Button
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profile_pic.png'),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.grey[300]!, width: 2),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color(0xFF074139),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // User Name
              const Text(
                'Esther Howard',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Vehicle Info & Refer and Earn Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopButton('Vehicle Info'),
                  _buildTopButton('Refer & Earn'),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Menu Items
              _buildMenuItem(
                icon: Icons.circle,
                iconColor: const Color(0xFF074139),
                title: 'Obpark Premium',
                onTap: () {},
              ),
              
              const SizedBox(height: 8),
              
              _buildMenuItem(
                icon: Icons.calendar_today_outlined,
                iconColor: Colors.grey[600]!,
                title: 'My Bookings',
                onTap: () {},
              ),
              
              const SizedBox(height: 8),
              
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                iconColor: Colors.grey[600]!,
                title: 'Alert & Notification',
                onTap: () {},
              ),
              
              const SizedBox(height: 8),
              
              _buildMenuItem(
                icon: Icons.receipt_outlined,
                iconColor: Colors.grey[600]!,
                title: 'My order',
                onTap: () {},
              ),
              
              const SizedBox(height: 8),
              
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                iconColor: Colors.grey[600]!,
                title: 'Saved Addneess',
                onTap: () {},
              ),
              
              const SizedBox(height: 8),
              
              _buildMenuItem(
                icon: Icons.credit_card_outlined,
                iconColor: Colors.grey[600]!,
                title: 'Payment Methodes',
                onTap: () {},
              ),
              
              const SizedBox(height: 8),
              
              _buildMenuItem(
                icon: Icons.settings_outlined,
                iconColor: Colors.grey[600]!,
                title: 'Setting',
                onTap: () {},
              ),
              
              const SizedBox(height: 8),
              
              _buildMenuItem(
                icon: Icons.circle,
                iconColor: const Color(0xFF074139),
                title: 'About Us',
                onTap: () {},
              ),
              
              const SizedBox(height: 8),
              
              _buildMenuItem(
                icon: Icons.help_outline,
                iconColor: Colors.grey[600]!,
                title: 'Help & Support',
                onTap: () {},
              ),
              
              const SizedBox(height: 32),
              
              // Logout Button
              Container(
                width: 343,
                height: 44,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!, width: 1.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: const Center(
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTopButton(String title) {
    return Container(
      width: 164,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 343,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: icon == Icons.circle ? 12 : 22,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[600],
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// In ProfileScreen.dart

// In ProfileScreen.dart

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      // Prevent closing the dialog by tapping outside while logging out
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Log Out',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Just close the dialog
                Navigator.pop(dialogContext);
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  // 1. Sign out from Firebase. The state change is immediate.
                  await FirebaseAuth.instance.signOut();
                  print('Sign out successful. Clearing navigation stack.');

                  // 2. IMPORTANT: Use the main ProfileScreen's context to
                  //    pop all screens until we're back at the root (AuthGate).
                  if (context.mounted) {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }

                } catch (e) {
                  print("Error during sign out: $e");
                  // If there's an error, just close the dialog.
                  if (dialogContext.mounted) {
                    Navigator.pop(dialogContext);
                  }
                }
              },
              child: const Text(
                'Log Out',
                style: TextStyle(
                  color: Color(0xFF074139),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}