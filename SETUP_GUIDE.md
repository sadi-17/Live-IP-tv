# Live TV App - Setup & Deployment Guide

Complete guide for setting up, building, and deploying the Live TV multi-server IPTV streaming application.

## Table of Contents
1. [System Requirements](#system-requirements)
2. [Initial Setup](#initial-setup)
3. [Development Setup](#development-setup)
4. [Building the App](#building-the-app)
5. [Deployment](#deployment)
6. [Testing](#testing)
7. [Troubleshooting](#troubleshooting)

---

## System Requirements

### Minimum Requirements
- **Flutter SDK**: 3.0.0 or higher
- **Dart SDK**: Included with Flutter
- **Java Development Kit (JDK)**: 11 or higher
- **Android SDK**: API 21+ (API 31+ recommended)
- **RAM**: 4GB minimum, 8GB+ recommended

### Supported Platforms
- **Android**: 5.0 (API 21) and above
- **Target**: Android 12+ (API 31+) for Play Store

### Windows Setup Tools
- Visual Studio Build Tools or Android Studio
- Android SDK tools and emulator
- Git (for version control)

---

## Initial Setup

### 1. Flutter Installation

**Windows:**
```bash
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
# Extract to a stable location (e.g., C:\flutter)

# Add Flutter to PATH:
# 1. Open Environment Variables (Win+X, search "Environment")
# 2. Add C:\flutter\bin to System PATH
# 3. Restart terminal/IDE

# Verify installation:
flutter --version
dart --version
```

**Verify Android SDK:**
```bash
flutter doctor
# Should show green checkmarks for all tools
```

### 2. Clone or Create Project

```bash
# If cloning:
git clone <repository-url>
cd live_tv_app

# Or create new:
flutter create live_tv_app
cd live_tv_app
```

### 3. Install Dependencies

```bash
# Get all packages
flutter pub get

# Update dependencies
flutter pub upgrade

# Check for any issues
flutter doctor
```

---

## Development Setup

### 1. Configure Development Environment

#### Visual Studio Code Setup
```bash
# Install Flutter and Dart extensions
# In VS Code:
# - Extensions → Search "Flutter"
# - Install Flutter (by Dart Code)
# - Install Dart (by Dart Code)
```

#### Android Studio Setup
```bash
# Open Android Studio
# Configure SDK Manager:
# 1. Tools → SDK Manager
# 2. SDK Platforms tab:
#    - Android 12.0 (API 31) ✓
#    - Android 13.0 (API 33) ✓
#    - Android 14.0 (API 34) ✓
# 3. SDK Tools tab:
#    - Android SDK Build-Tools ✓
#    - Android Emulator ✓
#    - Android SDK Platform-Tools ✓
```

### 2. Create Android Emulator

**Using Android Studio:**
```
1. AVD Manager → Create Virtual Device
2. Select Pixel 4a or newer
3. Select Android 12 (API 31) or higher
4. Allocate 2GB RAM, 2GB storage
5. Complete setup
```

**Or via Command Line:**
```bash
flutter emulators
flutter emulators create --name pixel4a
flutter emulators launch pixel4a
```

### 3. Configure Project

**Update Package Name (if needed):**
```bash
# Edit android/app/build.gradle
# Change: applicationId "com.livetv.app"

# Rebuild native files:
cd android
./gradlew clean
cd ..
```

**Verify AndroidManifest.xml:**
```bash
# Location: android/app/src/main/AndroidManifest.xml
# Ensure:
# - Package name matches
# - Permissions are set
# - Network security config is referenced
```

### 4. Run on Emulator

```bash
# Start emulator
flutter emulators launch pixel4a

# In another terminal, run app
flutter run

# Select the emulator when prompted
```

---

## Building the App

### 1. Debug Build

```bash
# Build debug APK (for testing)
flutter build apk --debug

# Output: build/app/outputs/flutter-apk/app-debug.apk
```

### 2. Release Build

**Full Release APK:**
```bash
# Build optimized APK for release
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk

# Test on device
flutter install build/app/outputs/flutter-apk/app-release.apk
```

**App Bundle (Google Play Store):**
```bash
# Build AAB for Play Store
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### 3. Build Options

```bash
# Verbose output for debugging
flutter build apk --release -v

# Split APKs for different architectures
flutter build apk --split-per-abi --release

# Build for specific ABI
flutter build apk --target-platform android-arm64 --release
```

### 4. Optimizations

**Code Obfuscation:**
```bash
flutter build apk --release --obfuscate --split-debug-info=./debug_symbols/
```

**Size Optimization:**
```bash
# Enable R8/ProGuard
# In android/app/build.gradle:
# buildTypes {
#   release {
#     shrinkResources true
#     minifyEnabled true
#   }
# }
```

---

## Deployment

### 1. Pre-deployment Checklist

- [ ] All tests passing
- [ ] No console errors or warnings
- [ ] Version number updated in pubspec.yaml
- [ ] AndroidManifest.xml permissions verified
- [ ] Network security config updated
- [ ] Screenshots and description prepared
- [ ] Privacy policy documented
- [ ] Terms of service created

### 2. Google Play Store Submission

**Create Play Console Account:**
1. Go to [Google Play Console](https://play.google.com/console)
2. Create a developer account ($25 one-time fee)
3. Complete profile information

**Create App:**
```
1. Create new app
   - Name: "Live TV"
   - Default language: English
   - Category: Entertainment

2. Set up app
   - Content rating form
   - Target audience
   - Permissions policy

3. Upload app bundle
   - Upload build/app/outputs/bundle/release/app-release.aab

4. Fill store listing
   - Title and description
   - Screenshots (at least 4)
   - Feature graphic
   - Release notes

5. Set pricing and distribution
   - Countries to release in
   - Pricing (free in this case)

6. Submit for review
   - Initial review: 2-3 hours
   - Full review: 1-7 days
```

### 3. Direct APK Installation

```bash
# Build release APK
flutter build apk --release

# Install on connected device
adb install -r build/app/outputs/flutter-apk/app-release.apk

# Or manually transfer and install on device
```

### 4. Firebase Integration (Optional)

**Add Firebase (future enhancement):**
```bash
# Install Firebase CLI
npm install -g firebase-tools

# In project:
flutterfire configure

# Enable:
# - Analytics
# - Crash Reporting
# - Performance Monitoring
```

---

## Testing

### 1. Unit Tests

**Create test file:** `test/models/server_model_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:live_tv_app/models/server_model.dart';

void main() {
  group('ServerModel', () {
    test('creates model with required fields', () {
      final server = ServerModel(
        id: '1',
        name: 'Test Server',
        url: 'http://test.local',
      );
      
      expect(server.id, equals('1'));
      expect(server.name, equals('Test Server'));
      expect(server.url, equals('http://test.local'));
    });

    test('JSON serialization works', () {
      final server = ServerModel(
        id: '1',
        name: 'Test',
        url: 'http://test',
      );
      
      final json = server.toJson();
      final restored = ServerModel.fromJson(json);
      
      expect(restored.id, equals(server.id));
      expect(restored.name, equals(server.name));
    });
  });
}
```

**Run tests:**
```bash
flutter test
flutter test --coverage  # Generate coverage report
```

### 2. Widget Tests

**Create test file:** `test/screens/splash_screen_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_tv_app/screens/splash_screen.dart';

void main() {
  testWidgets('Splash screen displays correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SplashScreen()),
    );

    expect(find.byIcon(Icons.live_tv_rounded), findsOneWidget);
    expect(find.text('Live TV'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
```

### 3. Integration Tests

**Create test file:** `integration_test/app_test.dart`

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:live_tv_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigate through app', (tester) async {
    await tester.pumpWidget(const LiveTVApp());

    // Wait for splash screen to navigate
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Should be on server list screen
    expect(find.text('Available TV Servers'), findsOneWidget);
  });
}
```

### 4. Manual Testing Checklist

**Splash Screen:**
- [ ] Animations play smoothly
- [ ] Auto-navigates after 3 seconds
- [ ] Logo scales correctly

**Server List Screen:**
- [ ] 3 default servers display
- [ ] Server cards show all information
- [ ] Add server dialog opens
- [ ] New servers can be added
- [ ] Tapping server navigates to WebView

**WebView Screen:**
- [ ] Server loads and displays content
- [ ] Progress bar shows loading
- [ ] Refresh button works
- [ ] Home button works
- [ ] Error states display correctly
- [ ] Cache clear works
- [ ] Server info dialog displays

**Error Handling:**
- [ ] Invalid URLs show error
- [ ] Network errors display correctly
- [ ] Retry functionality works

---

## Troubleshooting

### Build Issues

**Problem: "Flutter not found"**
```bash
# Solution: Add Flutter to PATH
export PATH="$PATH:/path/to/flutter/bin"
# Or on Windows, add C:\flutter\bin to System PATH
```

**Problem: "Android SDK not found"**
```bash
flutter config --android-sdk /path/to/android-sdk
flutter doctor --android-licenses  # Accept licenses
```

**Problem: "Build fails with gradlew"**
```bash
cd android
./gradlew clean
./gradlew build
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

### Runtime Issues

**Problem: "Cannot connect to server"**
- Verify server IP addresses
- Ensure device is on same network
- Check network_security_config.xml
- Use "Clear Cache" option

**Problem: "WebView crashes"**
- Update WebView_Flutter package
- Clear app cache
- Rebuild app

**Problem: "Slow loading"**
- Check network connection
- Reduce image/media quality
- Use WiFi instead of cellular

### Device Issues

**Problem: "adb not found"**
```bash
export PATH="$PATH:/path/to/android-sdk/platform-tools"
# Windows: Add to PATH
```

**Problem: "Device not recognized"**
```bash
adb kill-server
adb start-server
adb devices  # Should list devices
```

### Emulator Issues

**Problem: "Emulator won't start"**
```bash
flutter emulators
flutter clean
flutter emulators launch <emulator-id> --no-snapshot
```

**Problem: "Slow emulator"**
- Use physical device for testing
- Allocate more RAM/CPU to emulator
- Disable animations in emulator settings

---

## Performance Optimization

### App Performance

```dart
// Enable multi-threading for WebView
await _controller.setJavaScriptMode(JavaScriptMode.unrestricted);

// Optimize animations
// Use SingleChildScrollView instead of ListView when appropriate
// Implement lazy loading for server lists
```

### Build Size Optimization

```gradle
// android/app/build.gradle
android {
  bundle {
    language.enableSplit = true
    density.enableSplit = true
    abi.enableSplit = true
  }
}
```

### Memory Management

```dart
// Dispose resources properly
@override
void dispose() {
  _controller.clearCache();
  super.dispose();
}
```

---

## Versioning

### Update Version

**In pubspec.yaml:**
```yaml
version: 1.0.0+1
# Format: major.minor.patch+buildNumber
```

**In Android:**
```gradle
// android/app/build.gradle
android {
  defaultConfig {
    versionCode 1
    versionName "1.0.0"
  }
}
```

### Release Notes Template

```
Version 1.0.0
- Initial release
- Multi-server IPTV support
- WebView streaming
- Material Design 3 UI
- Android 5.0+ support
```

---

## Continuous Integration (Optional)

### GitHub Actions Workflow

Create `.github/workflows/build.yml`:

```yaml
name: Flutter Build

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v1
        with:
          flutter-version: '3.0.0'
      - run: flutter pub get
      - run: flutter test
      - run: flutter build apk --release
```

---

## Support & Resources

- **Flutter Docs**: https://flutter.dev/docs
- **Material Design 3**: https://m3.material.io
- **WebView Plugin**: https://pub.dev/packages/webview_flutter
- **Android Dev**: https://developer.android.com

---

**Last Updated**: 2024
**Flutter Version**: 3.0.0+
**Android Target**: API 31+
