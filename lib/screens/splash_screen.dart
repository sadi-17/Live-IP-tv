import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/constants.dart';
import 'server_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ServerListScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppConstants.primaryColor,
              const Color(0xFF0D2818),
              const Color(0xFF1B5E20),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Football Icon with animation
              const Icon(
                Icons.sports_soccer,
                size: 100,
                color: Color(0xFFFFD700),
              )
                  .animate()
                  .scale(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                  )
                  .fadeIn(),

              const SizedBox(height: 24),

              // Main Title
              Text(
                'Football World Cup',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.accentText,
                  letterSpacing: 3,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(delay: const Duration(milliseconds: 400))
                  .slideY(
                    begin: 0.5,
                    end: 0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                '⚽ Live Stadium Streams ⚽',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ).animate().fadeIn(delay: const Duration(milliseconds: 800)),

              const SizedBox(height: 48),

              // Loading Indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppConstants.accentText.withOpacity(0.8),
                  ),
                ),
              ).animate().fadeIn(delay: const Duration(milliseconds: 1200)),

              const Spacer(),

              // Developer Credit at bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  children: [
                    Text(
                      AppConstants.developer,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppConstants.accentText,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 1600)),
                    const SizedBox(height: 8),
                    Container(
                      width: 50,
                      height: 2,
                      color: AppConstants.accentText,
                    )
                        .animate()
                        .scaleX(
                          delay: const Duration(milliseconds: 1800),
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeOut,
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
