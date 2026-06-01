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
  
flutter create live_tv_app

# 2. Navigate to project
cd live_tv_app

# 3. Add dependencies
flutter pub add webview_flutter google_fonts flutter_animate connectivity_plus shared_preferences

# 4. Copy all the source files above to their respective locations

# 5. Get packages
flutter pub get

# 6. Build APK
flutter build apk --debug

# 7. For release APK
flutter build apk --release

# 8. Install on device
flutter install

# 9. Run directly
flutter run
