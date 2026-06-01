# Troubleshooting Guide

Complete troubleshooting guide for common issues with your Flutter Football World Cup app.

---

## 🔴 Issue 1: Flutter Command Not Found

### Error Message:
```
flutter : The term 'flutter' is not recognized as the name of a cmdlet...
```

### Cause:
Flutter SDK is not installed or not added to Windows PATH environment variable.

### Solution:

#### Step 1: Check if Flutter is Installed
```powershell
# Try to find flutter
Get-Command flutter -ErrorAction SilentlyContinue
# If nothing appears, Flutter is not installed
```

#### Step 2: Install Flutter
1. Go to: https://flutter.dev/docs/get-started/install/windows
2. Download Flutter SDK (ZIP file)
3. Extract to: `C:\flutter` (NOT Program Files)

#### Step 3: Add to Windows PATH
**Method 1 (GUI - Easiest):**
1. Press: `Win + X`
2. Search: "Environment Variables"
3. Click: "Edit the system environment variables"
4. Click: "Environment Variables..." button
5. Under "System variables", click "New"
6. Variable name: `PATH`
7. Variable value: `C:\flutter\bin`
8. Click OK → OK → OK

**Method 2 (PowerShell as Admin):**
```powershell
[Environment]::SetEnvironmentVariable(
  "Path",
  [Environment]::GetEnvironmentVariable("Path","User") + ";C:\flutter\bin",
  "User"
)
```

#### Step 4: Restart PowerShell
- Close ALL PowerShell windows
- Open a NEW PowerShell window

#### Step 5: Verify
```powershell
flutter --version
```

Should show: `Flutter 3.x.x • channel stable`

---

## 🔴 Issue 2: Android SDK Not Found

### Error Message:
```
❌ Android SDK not found
```

### Solution:
```powershell
# Check where Android SDK is located
flutter doctor

# Configure Flutter to use your Android SDK
flutter config --android-sdk C:\Android\sdk

# Or if it's elsewhere:
flutter config --android-sdk "path/to/your/android/sdk"
```

---

## 🔴 Issue 3: Android Licenses Not Accepted

### Error Message:
```
❌ Android licenses not accepted
```

### Solution:
```powershell
flutter doctor --android-licenses
# Type 'y' and press Enter for each license
```

---

## 🔴 Issue 4: No Devices Found

### Error Message:
```
No devices detected
```

### Solution:

**For Emulator:**
1. Open Android Studio
2. Tools → AVD Manager
3. Create Virtual Device (if none exists)
4. Launch the emulator
5. In PowerShell: `flutter devices` (should show emulator)
6. Run: `flutter run`

**For Physical Device:**
1. Enable USB Debugging on phone
2. Connect phone via USB cable
3. Run: `flutter devices` (should show device)
4. Run: `flutter run`

---

## 🔴 Issue 5: Pod Install Fails (iOS)

### Error Message:
```
Error running pod install
```

### Note:
This guide focuses on Android. For iOS development on macOS, refer to Flutter iOS setup guide.

---

## 🔴 Issue 6: Dependency Problems

### Error Message:
```
Could not find dependency pubspec.yaml
```

### Solution:
```powershell
# In your project directory
cd "C:\Users\LENOVO\OneDrive\Desktop\New folder (8)\Live TV"

# Clean and get fresh dependencies
flutter clean
flutter pub get

# If still issues:
flutter pub cache clean
flutter pub get
```

---

## 🔴 Issue 7: Build Fails with Gradle Error

### Error Message:
```
FAILURE: Build failed with an exception
```

### Solution:
```powershell
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Try again
flutter build apk --debug

# Or for release
flutter build apk --release
```

---

## 🔴 Issue 8: WebView Not Working

### Error:
WebView screen shows blank or errors

### Solution:
1. Verify `webview_flutter` is added to `pubspec.yaml`
2. Run: `flutter pub get`
3. Rebuild: `flutter clean && flutter build apk`
4. Check AndroidManifest.xml has internet permission

---

## 🔴 Issue 9: Splash Screen Not Showing

### Error:
App crashes on startup or doesn't show splash

### Solution:
```powershell
# Check for errors
flutter run -v  # Verbose mode

# Look for crash logs
adb logcat | grep flutter

# Rebuild app
flutter clean
flutter pub get
flutter run
```

---

## 🔴 Issue 10: GitHub Push Failed

### Error Message:
```
fatal: could not read Password for 'https://github.com/'
```

### Solution:

**Using Personal Access Token:**
1. Go to GitHub Settings → Developer settings → Personal access tokens
2. Generate new token (select `repo` scope)
3. Copy the token
4. When git asks for password, paste the token
5. It will be cached for future pushes

**Using SSH (Recommended):**
```powershell
# Generate SSH key
ssh-keygen -t rsa -b 4096

# Copy public key to GitHub
# Then use SSH URL:
git remote add origin git@github.com:sadi-17/Live-IP-tv.git
git push -u origin main
```

---

## 📊 Diagnostic Commands

Run these to diagnose issues:

```powershell
# Complete system check
flutter doctor

# Check Flutter installation
flutter --version

# Check Dart
dart --version

# Check Java (needed for Android)
java -version

# Check Android SDK
flutter config --android-sdk

# Check available devices
flutter devices

# Run with verbose output
flutter run -v

# Check git status
git status

# View git log
git log --oneline -5
```

---

## 🔧 Common Fixes

### Fix 1: Clear Cache
```powershell
flutter clean
flutter pub cache clean
flutter pub get
flutter run
```

### Fix 2: Restart Emulator
```powershell
# List emulators
flutter emulators

# Launch specific emulator
flutter emulators launch emulator_name

# Or in Android Studio: Tools → AVD Manager
```

### Fix 3: Hard Reset
```powershell
# Delete build artifacts
Remove-Item -Recurse -Force build\
Remove-Item -Recurse -Force .dart_tool\

# Reinstall
flutter pub get
flutter run
```

### Fix 4: Update Flutter
```powershell
flutter upgrade
flutter doctor
```

### Fix 5: Check Logs
```powershell
# Android logs
adb logcat

# Filter for Flutter errors
adb logcat | findstr flutter

# Check device logs
adb logcat -c  # Clear
adb logcat     # View new logs
```

---

## 📝 Checking Project Status

Before running, verify your project:

```powershell
# Navigate to project
cd "C:\Users\LENOVO\OneDrive\Desktop\New folder (8)\Live TV"

# Check structure
dir lib
dir android
dir pubspec.yaml

# Check git status
git status

# Check git remote
git remote -v

# View dependencies
type pubspec.yaml
```

---

## 🎯 Step-by-Step Troubleshooting Process

### When something fails:

1. **Read the error message carefully**
   - It usually tells you what's wrong
   - Look for specific file paths or package names

2. **Run with verbose output**
   ```powershell
   flutter run -v
   ```
   - Shows detailed logs
   - Easier to spot the actual error

3. **Clean and rebuild**
   ```powershell
   flutter clean
   flutter pub get
   flutter run
   ```

4. **Check Flutter doctor**
   ```powershell
   flutter doctor
   ```
   - Shows system configuration issues

5. **Search the error online**
   - Copy exact error message to Google
   - Check Flutter GitHub issues
   - Check Stack Overflow

6. **Check project files**
   - Verify pubspec.yaml is correct
   - Check AndroidManifest.xml
   - Verify file paths

7. **Rebuild from scratch**
   ```powershell
   flutter clean
   flutter pub cache clean
   flutter pub get
   flutter build apk --debug
   ```

---

## 💡 Prevention Tips

### To avoid issues:

1. **Keep Flutter Updated**
   ```powershell
   flutter upgrade
   ```

2. **Commit Often**
   ```powershell
   git add .
   git commit -m "Your message"
   git push origin main
   ```

3. **Test on Device Regularly**
   ```powershell
   flutter run
   ```

4. **Check Dependencies**
   ```powershell
   flutter pub outdated
   flutter pub upgrade
   ```

5. **Use Version Control**
   - Never delete .git folder
   - Keep committed versions

---

## 📞 When to Ask for Help

Ask for help if you have:
- Error messages you can't understand
- Issues that persist after trying solutions
- Build failures on multiple devices
- GitHub/Git issues
- Android SDK configuration problems

Provide:
- Full error message (copy-paste)
- Your system info (flutter doctor output)
- What you tried so far
- Project location and structure

---

## 🔗 Useful Resources

- **Flutter Docs**: https://flutter.dev/docs
- **Flutter Troubleshooting**: https://flutter.dev/docs/testing/troubleshooting
- **Android Studio Help**: https://developer.android.com/studio
- **Stack Overflow**: https://stackoverflow.com/questions/tagged/flutter
- **GitHub Issues**: https://github.com/flutter/flutter/issues

---

## ✅ Verification Checklist

After fixing issues, verify:

- [ ] `flutter --version` works
- [ ] `flutter doctor` shows no errors
- [ ] `flutter devices` shows at least one device
- [ ] `flutter pub get` completes successfully
- [ ] `flutter run` launches app successfully
- [ ] App shows splash screen with "Developed by Sadi"
- [ ] Navigation works (tap stadium to open WebView)
- [ ] WebView loads (shows server content)
- [ ] GitHub is accessible (`git remote -v` works)

---

## 📋 Your Project-Specific Paths

```
Project Directory: C:\Users\LENOVO\OneDrive\Desktop\New folder (8)\Live TV
Source Code: lib\
Android Config: android\app\src\main\
Documentation: *.md files
Pubspec: pubspec.yaml
```

---

## 🎉 If All Else Fails

**Full Reset Solution:**

```powershell
# 1. Stop everything
# - Close PowerShell, Android Studio, emulator
# - Close all other applications

# 2. Clean project
cd "C:\Users\LENOVO\OneDrive\Desktop\New folder (8)\Live TV"
flutter clean

# 3. Remove build artifacts
Remove-Item -Recurse -Force build -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force .dart_tool -ErrorAction SilentlyContinue

# 4. Restart Flutter
flutter pub get

# 5. Check everything
flutter doctor

# 6. Try again
flutter run -v
```

---

**Need more help? Check FLUTTER_SETUP_WINDOWS.md or contact support!**

---

*Troubleshooting Guide*  
*Created: 2024*  
*For: Football World Cup IPTV App*
