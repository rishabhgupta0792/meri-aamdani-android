# Quick Start - Meri Amdani App

## Prerequisites Installation

### 1. Install Flutter (5 minutes)
```bash
cd ~/development
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.19.0-stable.zip
unzip flutter_macos_arm64_3.19.0-stable.zip
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
flutter --version
```

### 2. Install Android Studio (10 minutes)
1. Download: https://developer.android.com/studio
2. Install to Applications
3. Run setup wizard
4. Install Android SDK

### 3. Accept Licenses (1 minute)
```bash
flutter doctor --android-licenses
```
Type `y` for each prompt.

### 4. Create Emulator (3 minutes)
1. Android Studio → Device Manager
2. Create Device → Pixel 6
3. Download API 33 system image
4. Finish

## Run the App

```bash
# Navigate to project
cd /Users/atulchavan/Repository/meri-amdani/meri_amdani

# Install dependencies
flutter pub get

# Generate localization
flutter gen-l10n

# Start emulator (from Android Studio Device Manager)

# Run app
flutter run
```

## What You Get

✅ Dashboard with earnings display  
✅ Job tracking (add/edit/delete)  
✅ Payment management  
✅ English + Hindi support  
✅ Clean, minimalist UI  
✅ Full accessibility  

## Need Help?

See `SETUP_GUIDE.md` for detailed instructions.

---

**Total Setup Time**: ~20-30 minutes  
**App Launch Time**: <2 seconds once Flutter is installed
