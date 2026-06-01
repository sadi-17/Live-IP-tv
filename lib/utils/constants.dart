import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'Football World Cup';
  static const String appVersion = '1.0.0';
  static const String developer = 'Developed by Sadi';

  // Default Servers
  static const List<Map<String, String>> defaultServers = [
    {
      'name': 'Stadium 1',
      'url': 'http://10.2.2.10',
      'icon': '⚽',
    },
    {
      'name': 'Stadium 2',
      'url': 'http://172.17.50.112',
      'icon': '🏆',
    },
    {
      'name': 'Stadium 3',
      'url': 'http://192.168.91.8',
      'icon': '🌍',
    },
  ];

  // Timeouts
  static const int connectionTimeout = 10000;
  static const int splashDuration = 3;

  // Colors (World Cup Theme - Green & Gold)
  static const Color primaryColor = Color(0xFF1B5E20);  // Dark Green
  static const Color accentColor = Color(0xFFFFD700);    // Gold
  static const Color backgroundColor = Color(0xFF0D2818); // Dark Green BG
  static const Color cardColor = Color(0xFF1B5E20);      // Green Cards
  static const Color accentText = Color(0xFFFFD700);     // Gold Text
}
