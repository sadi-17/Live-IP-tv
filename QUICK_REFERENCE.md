# Live TV App - Quick Reference Guide

A fast lookup guide for developers working with the Live TV application.

---

## 🚀 Essential Commands

```bash
# Setup & Installation
flutter pub get                    # Install dependencies
flutter doctor                     # Check setup status
flutter clean && flutter pub get   # Clean rebuild

# Development
flutter run                        # Run on device/emulator
flutter run -v                     # Verbose output for debugging

# Building
flutter build apk --release        # Build APK for Android
flutter build appbundle --release  # Build for Play Store
flutter build apk --debug          # Debug build

# Testing
flutter test                       # Run unit tests
flutter test --coverage            # Coverage report
```

---

## 📁 File Locations & Contents

| File | Purpose | Key Config |
|------|---------|------------|
| `lib/main.dart` | App entry, theme | Colors, fonts, routes |
| `lib/screens/splash_screen.dart` | Welcome screen | 3s timer, animations |
| `lib/screens/server_list_screen.dart` | Server list UI | Add dialog, server list |
| `lib/screens/webview_screen.dart` | Streaming screen | WebView, loading state |
| `lib/models/server_model.dart` | Data model | Default servers |
| `lib/utils/constants.dart` | App constants | IPs, timeouts, colors |
| `pubspec.yaml` | Dependencies | Package versions |
| `android/app/src/main/AndroidManifest.xml` | Permissions | App config |
| `android/app/src/main/res/xml/network_security_config.xml` | Security | Cleartext IPs |

---

## 🎨 Color Scheme

```dart
// Primary Colors
Colors.deepOrange         // Primary (Material Design 3)
Colors.orange            // Accent
Colors.grey.shade900     // Dark background
Colors.grey.shade800     // Cards
Colors.white             // Text

// Usage
backgroundColor: Colors.deepOrange.shade900
cardColor: Colors.grey.shade800
textColor: Colors.white
```

---

## 📱 Screen Sizes & Responsive Design

```dart
// Common breakpoints
Mobile:     < 600px
Tablet:     600px - 900px
Desktop:    > 900px

// Responsive example
MediaQuery.of(context).size.width > 600
  ? largeLayout
  : smallLayout
```

---

## 🔧 Common Customizations

### Change Default Servers

Edit `lib/models/server_model.dart`:
```dart
static List<ServerModel> defaultServers = [
  ServerModel(
    id: '1',
    name: 'Your Server Name',
    url: 'http://192.168.1.100',
    icon: '📺',
    description: 'Your description',
  ),
  // ...
];
```

### Change Theme Color

Edit `lib/main.dart`:
```dart
ColorScheme.fromSeed(
  seedColor: Colors.blue,  // Change here
  brightness: Brightness.dark,
)
```

### Adjust Splash Screen Timing

Edit `lib/screens/splash_screen.dart`:
```dart
Future.delayed(const Duration(seconds: 5), () {  // Change 5 to desired seconds
  if (mounted) {
    Navigator.pushReplacement(context, ...);
  }
});
```

### Add Network Security Domain

Edit `android/app/src/main/res/xml/network_security_config.xml`:
```xml
<domain-config cleartextTrafficPermitted="true">
    <domain includeSubdomains="true">YOUR.IP.HERE</domain>
</domain-config>
```

---

## 🔐 Permissions & Security

### Required Permissions (AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

### Network Configuration
```xml
<network-security-config>
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <certificates src="system" />
        </trust-anchors>
    </base-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">SERVER_IP</domain>
    </domain-config>
</network-security-config>
```

---

## 📦 Dependencies Quick Ref

| Package | Use | Import |
|---------|-----|--------|
| webview_flutter | WebView | `import 'package:webview_flutter/webview_flutter.dart';` |
| google_fonts | Premium fonts | `import 'package:google_fonts/google_fonts.dart';` |
| flutter_animate | Animations | `import 'package:flutter_animate/flutter_animate.dart';` |
| connectivity_plus | Network check | `import 'package:connectivity_plus/connectivity_plus.dart';` |
| shared_preferences | Local storage | `import 'package:shared_preferences/shared_preferences.dart';` |

---

## 🎬 Animation Cheat Sheet

```dart
// Basic animations
.animate()
  .scale(duration: 800.ms)
  .fadeIn()
  .slideX(begin: 0.3)

// With delay
.animate().fadeIn(delay: 400.ms)

// Sequential
.animate()
  .scale(duration: 800.ms, curve: Curves.elasticOut)
  .fadeIn(delay: 200.ms)

// Staggered list
.animate(delay: Duration(milliseconds: index * 100))
  .fadeIn()
  .slideX()
```

---

## 🐛 Debugging Tips

### Enable Verbose Logging
```bash
flutter run -v
```

### Check Widget Issues
```dart
print('Debug: $variable');
debugPrint('Widget: $widget');
```

### Device Logging
```bash
adb logcat | grep flutter
```

### WebView Debugging
```dart
debugPrint('WebView: ${error.description}');
```

---

## 📊 State Management Pattern

```dart
class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize here
  }

  @override
  void dispose() {
    // Cleanup resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
```

---

## 🎯 Navigation Pattern

```dart
// Push to new screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => NewScreen(),
  ),
);

// Pop current screen
Navigator.pop(context);

// Replace screen (replace history)
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => NewScreen(),
  ),
);
```

---

## 💾 Shared Preferences Example

```dart
// Save
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.setString('key', 'value');

// Load
String? value = prefs.getString('key');

// Remove
prefs.remove('key');

// Clear all
prefs.clear();
```

---

## 🌐 WebView Essentials

```dart
// Initialize
_controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0xFF1A1A1A))
  ..setNavigationDelegate(NavigationDelegate(...))
  ..loadRequest(Uri.parse(url));

// Actions
_controller.reload()
_controller.loadRequest(Uri.parse(newUrl))
_controller.clearCache()

// Listen to events
onProgress: (int progress) { }
onPageStarted: (String url) { }
onPageFinished: (String url) { }
onWebResourceError: (WebResourceError error) { }
```

---

## 📐 Common UI Patterns

### Card with Tap
```dart
Card(
  child: InkWell(
    onTap: () { },
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Text('Content'),
    ),
  ),
)
```

### Gradient Background
```dart
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  ),
)
```

### Loading Indicator
```dart
if (isLoading)
  CircularProgressIndicator()
else
  YourWidget()
```

### Error Dialog
```dart
AlertDialog(
  title: Text('Error'),
  content: Text('Error message'),
  actions: [
    TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
  ],
)
```

---

## 🚨 Error Handling Pattern

```dart
try {
  // Your code
} catch (e) {
  // Handle error
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: $e')),
  );
} finally {
  // Cleanup
}
```

---

## 📱 Device Testing

```bash
# List devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run on emulator
flutter emulators
flutter emulators launch <emulator-id>
flutter run

# Connect physical device
adb devices
flutter run
```

---

## 🔄 Version Management

```yaml
# In pubspec.yaml
version: 1.0.0+1
# Format: major.minor.patch+buildNumber
```

```gradle
// In android/app/build.gradle
android {
  defaultConfig {
    versionCode 1          // buildNumber
    versionName "1.0.0"    // version
  }
}
```

---

## 🎨 Material Design 3 Colors

```dart
// Available colors
Colors.red
Colors.pink
Colors.purple
Colors.deepPurple
Colors.indigo
Colors.blue
Colors.lightBlue
Colors.cyan
Colors.teal
Colors.green
Colors.lightGreen
Colors.lime
Colors.yellow
Colors.amber
Colors.orange
Colors.deepOrange
Colors.brown
Colors.grey
Colors.blueGrey

// Shades: .shade50, .shade100, .shade200, ..., .shade900
Colors.orange.shade300
Colors.orange.shade700
```

---

## 📚 Resource Links

- Flutter Docs: https://flutter.dev/docs
- Material Design 3: https://m3.material.io
- Dart Docs: https://dart.dev/guides
- pub.dev: https://pub.dev

---

## ✅ Deployment Checklist

- [ ] Update version number
- [ ] Test all screens
- [ ] Check error handling
- [ ] Verify permissions
- [ ] Test on device
- [ ] `flutter clean`
- [ ] `flutter pub get`
- [ ] `flutter build apk --release`

---

## 🆘 Quick Fixes

| Problem | Solution |
|---------|----------|
| "flutter not found" | Add Flutter to PATH |
| Build fails | `flutter clean && flutter pub get` |
| App crashes | Check logcat: `adb logcat` |
| WebView blank | Check network security config |
| Slow animations | Reduce effect duration |
| Missing imports | Run `flutter pub get` |
| Hot reload fails | Use full restart: `r` key |

---

**Last Updated**: 2024  
**For**: Live TV v1.0.0  
**Tested On**: Flutter 3.0.0+, Android API 31+

Print this for quick reference while developing! 📋
