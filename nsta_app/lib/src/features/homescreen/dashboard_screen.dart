import 'package:flutter/material.dart';
import 'package:nsta_app/l10n/app_localizations.dart';
import 'package:nsta_app/src/features/homescreen/home_Screen.dart';
import 'package:nsta_app/src/features/homescreen/leaderboard_screen.dart';
import 'package:nsta_app/src/features/homescreen/settings_screen.dart';
import 'package:nsta_app/src/features/profile/profile_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    LeaderboardScreen(),
    ProfileScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6F4),
      body: SafeArea(child: _pages[_currentIndex]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            gap: 8,
            activeColor: Colors.white,
            color: Colors.grey,
            backgroundColor: Colors.white,
            tabBackgroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            selectedIndex: _currentIndex,
            onTabChange: (index) => setState(() => _currentIndex = index),
            tabs: [
              GButton(
                  icon: Icons.home, text: AppLocalizations.of(context)!.home),
              GButton(
                  icon: Icons.emoji_events_outlined,
                  text: AppLocalizations.of(context)!.leaderboard),
              GButton(
                  icon: Icons.person_outline,
                  text: AppLocalizations.of(context)!.myProfile),
              GButton(
                  icon: Icons.settings_outlined,
                  text: AppLocalizations.of(context)!.settings),
            ],
          ),
        ),
      ),
    );
  }
}
