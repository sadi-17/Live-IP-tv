# Flutter Setup Guide for Windows

## ⚠️ Issue: Flutter Not in PATH

You're getting the error: **"flutter is not recognized as the name of a cmdlet"**

This means Flutter SDK is not installed or not added to your Windows PATH environment variable.

---

## 📋 Solution: Install & Configure Flutter

### Step 1: Download Flutter SDK

1. Visit: **https://flutter.dev/docs/get-started/install/windows**
2. Click **"Download Flutter SDK for Windows"**
3. Choose the latest stable version
4. A ZIP file will download (about 500MB-1GB)

### Step 2: Extract Flutter

1. Extract the downloaded ZIP file
2. **Recommended location**: `C:\flutter`
3. **Do NOT** extract to:
   - Program Files (requires admin privileges)
   - OneDrive (can cause sync issues)
   - Desktop (not ideal for tools)

**Example path after extraction:**
```
C:\flutter\
├── bin\
├── packages\
├── dev\
└── ... (other Flutter files)
```

### Step 3: Add Flutter to Windows PATH

This is the **most important step** to fix your error.

#### Method 1: Using GUI (Easiest)

1. **Open Environment Variables:**
   - Press: `Win + X`
   - Search: "Environment Variables"
   - Click: "Edit the system environment variables"

2. **Click "Environment Variables..." button** (bottom right of dialog)

3. **Under "User variables" or "System variables", click "New"**

4. **Create new variable:**
   - Variable name: `PATH`
   - Variable value: `C:\flutter\bin`
   - Click **OK**

5. **Edit existing PATH variable (if it exists):**
   - Select `PATH` in the list
   - Click **Edit**
   - Click **New**
   - Add: `C:\flutter\bin`
   - Click **OK**

6. **Click OK** to close all dialogs

7. **Restart PowerShell completely** (close and reopen)

#### Method 2: Using PowerShell (Advanced)

If you want to do it via PowerShell as Administrator:

```powershell
# Run PowerShell as Administrator, then:
[Environment]::SetEnvironmentVariable(
  "Path",
  [Environment]::GetEnvironmentVariable("Path","User") + ";C:\flutter\bin",
  "User"
)
```

Then restart PowerShell.

### Step 4: Verify Installation

Open a **NEW PowerShell window** and run:

```powershell
flutter --version
```

If successful, you should see:
```
Flutter 3.x.x • channel stable • ...
```

### Step 5: Run Flutter Doctor

```powershell
flutter doctor
```

This will check your system and show what's missing. Fix any issues it reports.

---

## 🔧 Common Issues & Solutions

### Issue 1: "flutter is not recognized"

**Solution:**
- Make sure you restarted PowerShell (completely close and reopen)
- Verify PATH was added correctly
- Check Flutter extraction path is correct

### Issue 2: Flutter doctor shows Android SDK missing

**Solution:**
```powershell
flutter config --android-sdk C:\Android\sdk
# Or wherever your Android SDK is installed
```

### Issue 3: Flutter doctor shows Android licenses not accepted

**Solution:**
```powershell
flutter doctor --android-licenses
# Type "y" and press Enter to accept all licenses
```

### Issue 4: PATH keeps resetting after restart

**Solution:**
- Make sure to add to **System variables**, not just User variables
- Restart your computer (not just PowerShell)

---

## ✅ Verification Checklist

After setup, verify everything works:

```powershell
# Check Flutter version
flutter --version

# Check Flutter doctor
flutter doctor

# Check if Flutter can find devices
flutter devices

# Test pub get
cd "C:\Users\LENOVO\OneDrive\Desktop\New folder (8)\Live TV"
flutter pub get
```

All should work without errors.

---

## 🚀 After Flutter is Set Up

Once Flutter is working, you can use it from anywhere:

```powershell
# Install dependencies
flutter pub get

# Add individual packages
flutter pub add package_name

# Run app
flutter run

# Build APK
flutter build apk --release

# Build for Play Store
flutter build appbundle --release
```

---

## 📍 Your Project Setup

Once Flutter is working, in your project directory:

```powershell
cd "C:\Users\LENOVO\OneDrive\Desktop\New folder (8)\Live TV"

# Get dependencies
flutter pub get

# Check if everything is configured
flutter doctor

# Run the app on emulator/device
flutter run
```

---

## 🎯 Step-by-Step Quick Guide

### For Your Current Project:

1. **Download Flutter**: https://flutter.dev/docs/get-started/install/windows
2. **Extract to**: `C:\flutter`
3. **Add to PATH**: `C:\flutter\bin`
4. **Restart PowerShell**
5. **Test**: `flutter --version`
6. **In your project**: `flutter pub get`
7. **Run**: `flutter run`

---

## 💡 Pro Tips

### Use Git Bash Instead (Alternative)

If PowerShell gives you trouble, use **Git Bash**:

1. Install Git from: https://git-scm.com/download/win
2. Open **Git Bash** instead of PowerShell
3. Flutter should work there

### Use Command Prompt (Alternative)

Flutter also works in regular Command Prompt (cmd.exe):

```cmd
flutter --version
flutter pub get
flutter run
```

### Keep Flutter Updated

Periodically update Flutter:

```powershell
flutter upgrade
```

---

## 🔗 Useful Links

- **Flutter Installation**: https://flutter.dev/docs/get-started/install/windows
- **Flutter Doctor**: https://flutter.dev/docs/get-started/install/windows#run-flutter-doctor
- **Android Setup**: https://flutter.dev/docs/get-started/install/windows#android-setup
- **Getting Started**: https://flutter.dev/docs/get-started/codelab

---

## ❓ Still Having Issues?

### Option 1: Fresh Install
- Uninstall Flutter completely
- Restart computer
- Follow these steps exactly
- Make sure PATH is added to **System** variables

### Option 2: Use Absolute Path
While fixing PATH, run Flutter with full path:

```powershell
C:\flutter\bin\flutter --version
C:\flutter\bin\flutter pub get
```

### Option 3: Update Flutter
If already installed, update it:

```powershell
# If flutter is working:
flutter upgrade

# Or download latest from:
# https://flutter.dev/docs/get-started/install/windows
```

---

## 📝 Verification Commands

Run these to verify everything:

```powershell
# Flutter version
flutter --version

# Flutter location
flutter --info | findstr "Flutter"

# Dart version
dart --version

# Java version (needed for Android)
java -version

# Android SDK
flutter config --android-sdk

# List devices
flutter devices
```

---

## 🎉 Once Setup is Complete

Your project will work:

```powershell
cd "C:\Users\LENOVO\OneDrive\Desktop\New folder (8)\Live TV"

# Install dependencies
flutter pub get

# Run on emulator
flutter run

# Build APK
flutter build apk --release

# Build for Play Store
flutter build appbundle --release
```

---

**Follow these steps and your Flutter setup will be complete!**

Need help with a specific step? Let me know which one you're stuck on!

---

*Flutter Setup Guide for Windows*  
*Created: 2024*  
*For: Your Football World Cup App*
