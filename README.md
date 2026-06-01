# Live TV - Multi-Server IPTV Streaming App

A professional Flutter application for streaming live TV content from multiple IPTV servers. Built with Material Design 3 and webview_flutter, this app provides a seamless experience for connecting to and managing multiple TV servers.

## Features

### Core Features
- **Splash Screen**: Beautiful animated branding screen with smooth transitions
- **Server Management**: 
  - Pre-configured access to 3 default IPTV servers
  - Add custom server URLs dynamically
  - Server status indicators
  - Delete servers functionality (extendable)
  
### Streaming & Playback
- **WebView Integration**: Native WebView for streaming content
- **Loading States**: Visual progress indicators during page load
- **Error Handling**: Comprehensive error messages and retry mechanisms
- **Cache Management**: Clear cache option for troubleshooting

### User Interface
- **Dark Theme**: Material Design 3 dark theme with orange/red accents
- **Smooth Animations**: Flutter Animate for polished transitions
- **Responsive Design**: Adapts to all screen sizes
- **Material Components**: Modern Material Design 3 components

### Network Configuration
- **HTTP/HTTPS Support**: Cleartext traffic enabled for local networks
- **Network Security**: Android security configuration for specified servers
- **Permissions**: Internet, Network State, and WiFi State permissions

## Pre-configured Servers

The app comes with three pre-configured IPTV servers:

| Server | IP Address | Icon | Description |
|--------|-----------|------|-------------|
| Primary TV Server | 10.2.2.10 | 🖥️ | Main streaming server |
| Secondary TV Server | 172.17.50.112 | 📡 | Backup streaming server |
| Tertiary TV Server | 192.168.91.8 | 📺 | Alternative streaming server |

## Project Structure

```
lib/
├── main.dart                 # App entry point & theme configuration
├── models/
│   └── server_model.dart    # Server data model with JSON serialization
├── screens/
│   ├── splash_screen.dart   # Animated splash screen
│   ├── server_list_screen.dart # Server selection UI
│   └── webview_screen.dart  # WebView streaming screen
└── utils/
    └── constants.dart       # App constants and default servers

android/
├── app/src/main/
│   ├── AndroidManifest.xml  # Permissions and app configuration
│   └── res/xml/
│       └── network_security_config.xml # Security policy for cleartext traffic
```

## Dependencies

```yaml
flutter:
  sdk: flutter
webview_flutter: ^4.4.1      # WebView implementation
google_fonts: ^6.1.0         # Premium Google Fonts integration
flutter_animate: ^4.2.0      # Smooth animations
connectivity_plus: ^5.0.2    # Network connectivity checking
shared_preferences: ^2.2.2   # Local data persistence
```

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Android SDK (for Android development)
- Basic knowledge of Flutter and Dart

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd live_tv_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Release

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle (for Play Store):**
```bash
flutter build appbundle --release
```

## Architecture Overview

### State Management
The app uses Flutter's built-in StatefulWidget for state management. Each screen maintains its own state:
- **SplashScreen**: Manages timing and navigation
- **ServerListScreen**: Manages server list and add/delete operations
- **WebViewScreen**: Manages WebView loading state and errors

### Data Models
`ServerModel` provides:
- JSON serialization (`toJson()` / `fromJson()`)
- Default servers list
- Customizable properties (name, URL, icon, description)

### Theming
Uses Material Design 3 with:
- Deep Orange color scheme
- Dark theme (OLED-friendly)
- Google Fonts (Poppins typography)
- Custom card styling with rounded corners

## Features Explanation

### Splash Screen
- 3-second animation duration
- Elastic scaling effect on icon
- Slide and fade animations for text
- Auto-navigation to server list

### Server List Screen
- Displays all servers in a scrollable list
- Each card shows:
  - Server icon with gradient background
  - Server name and URL
  - Optional description
  - "Connect" button with play icon
- Floating action button to add custom servers
- Staggered animation when loading

### WebView Screen
- Full-featured browser-like interface
- Toolbar with:
  - Refresh button
  - Home button
  - Server info menu
- Loading progress bar with percentage
- Error state with retry mechanism
- Floating action button for quick refresh
- Server information dialog

## Android Configuration

### AndroidManifest.xml
- Package: `com.livetv.app`
- Permissions:
  - INTERNET (required for streaming)
  - ACCESS_NETWORK_STATE
  - ACCESS_WIFI_STATE
- Hardware acceleration enabled
- Cleartext traffic enabled globally
- Network security config applied

### Network Security Config
Defines security policy for:
- System CA certificates
- Cleartext traffic for local IPs:
  - 10.2.2.10
  - 172.17.50.112
  - 192.168.91.8

## Customization

### Adding New Default Servers
Edit `lib/models/server_model.dart`:
```dart
static List<ServerModel> defaultServers = [
  ServerModel(
    id: '4',
    name: 'Your Server',
    url: 'http://your-ip:port',
    icon: '📺',
    description: 'Your description',
  ),
  // ... more servers
];
```

### Changing Theme Colors
Edit `lib/main.dart`:
```dart
ColorScheme.fromSeed(
  seedColor: Colors.yourColor,  // Change primary color
  brightness: Brightness.dark,
)
```

### Modifying Animation Duration
Edit individual screen files:
```dart
.animate()
.scale(duration: const Duration(milliseconds: 800))  // Adjust here
```

## Production Readiness

✅ **Error Handling**: Comprehensive error states and user feedback
✅ **Loading States**: Visual indicators for network operations
✅ **Material Design 3**: Modern, accessible UI components
✅ **Performance**: Optimized WebView with efficient state management
✅ **Security**: Network security configuration for cleartext traffic
✅ **Accessibility**: Proper semantics and contrast ratios
✅ **Responsive**: Works on all Android devices and screen sizes

## Known Limitations & Future Enhancements

### Current Limitations
- Server list not persisted (resets on app restart) - can be added via SharedPreferences
- No video player controls beyond WebView defaults
- Basic error handling (could be enhanced with detailed logging)

### Potential Enhancements
- Persist custom servers using SharedPreferences
- Add server connection status indicators (ping check)
- Implement advanced video player with player controls
- Add authentication support
- Server favorites/bookmarks
- Playback history
- Search and filter functionality
- Dark/Light theme toggle
- Landscape optimization for video playback
- Picture-in-Picture mode

## Troubleshooting

### Connection Issues
1. Verify server IP addresses are correct
2. Ensure device is on the same network
3. Check Android's network security config
4. Use "Clear Cache" option in WebView menu

### Loading Problems
1. Tap retry button in error dialog
2. Use refresh button in toolbar
3. Check server status independently

### UI Issues
1. Ensure Flutter version is 3.0.0+
2. Run `flutter clean && flutter pub get`
3. Rebuild the app

## API Reference

### ServerModel
```dart
ServerModel({
  required String id,
  required String name,
  required String url,
  String icon = '📺',
  String description = '',
  bool isActive = true,
})
```

**Methods:**
- `toJson()` - Serialize to JSON
- `fromJson(Map)` - Deserialize from JSON

### App Constants
- `appName`: Application name
- `appVersion`: Version string
- `connectionTimeout`: Network timeout in ms
- `splashDuration`: Splash screen duration in seconds
- Color constants for theming

## License

This project is provided as-is for educational and commercial use.

## Support

For issues, feature requests, or improvements, please refer to the documentation or contact support.

---

**Version**: 1.0.0  
**Last Updated**: 2024  
**Built with**: Flutter 3.0.0+, Material Design 3
