# Meri Amdani (मेरी आमदनी)

A mobile application for gig workers to track income, manage jobs, and verify payments.

## 🚀 Quick Start

### Prerequisites

Before running this app, you need to install:

1. **Flutter SDK** (3.2.0 or higher)
2. **Android Studio** (with Android SDK)
3. **Android Emulator** (any recent Android phone)

### Installation Steps

#### 1. Install Flutter

**macOS:**
```bash
# Download Flutter SDK
cd ~/development
curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_3.19.0-stable.zip
unzip flutter_macos_3.19.0-stable.zip

# Add to PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc

# Verify installation
flutter --version
```

For other platforms, visit: https://docs.flutter.dev/get-started/install

#### 2. Install Android Studio

1. Download from: https://developer.android.com/studio
2. Install and run Android Studio
3. Complete the setup wizard
4. Install Android SDK and command-line tools

#### 3. Accept Android Licenses

```bash
flutter doctor --android-licenses
```

Accept all licenses by typing 'y' when prompted.

#### 4. Set Up Android Emulator

1. Open Android Studio
2. Go to **Tools > Device Manager**
3. Click **Create Device**
4. Select any phone (e.g., Pixel 6)
5. Select a system image (e.g., Android 13 - API 33)
6. Click **Finish**

### Running the App

1. **Navigate to project directory:**
   ```bash
   cd /Users/atulchavan/Repository/meri-amdani/meri_amdani
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate localizations:**
   ```bash
   flutter gen-l10n
   ```

4. **Start the emulator:**
   - Open Android Studio
   - Go to Device Manager
   - Click the play button on your emulator

5. **Run the app:**
   ```bash
   flutter run
   ```

The app should launch on the emulator in about 30-60 seconds!

## 📱 Features

- **Dashboard**: View total earnings with pending/collected breakdown
- **Jobs**: Add, edit, and track all your work
- **Payments**: Request payments and mark as paid
- **Profile**: Manage settings and language preferences

## 🌐 Supported Languages

- English
- हिंदी (Hindi)

## 🎨 Design Principles

- **Minimalistic**: Clean, distraction-free interface
- **Elegant**: Modern Material 3 design
- **Accessible**: WCAG 2.2 AA compliant
- **Lightweight**: Small app size, fast performance
- **Usability-focused**: Large touch targets, clear labels

## 📦 Package Dependencies

- `flutter_riverpod` - State management
- `google_fonts` - Typography
- `intl` - Internationalization
- `uuid` - Unique IDs

All packages are kept minimal to ensure the app stays light.

## 🛠️ Development

### Code Structure

```
lib/
├── common/         # Shared widgets
├── core/           # Constants, theme, routes
├── data/           # Models, providers
├── features/       # Feature modules
│   ├── dashboard/
│   ├── jobs/
│   ├── payments/
│   └── profile/
├── l10n/           # Localization files
└── main.dart       # Entry point
```

### Running Tests

```bash
flutter test
```

### Building for Release

```bash
flutter build apk --release
```

## 📝 Troubleshooting

**Flutter command not found:**
- Make sure Flutter is in your PATH
- Restart your terminal after installation

**Android licenses not accepted:**
```bash
flutter doctor --android-licenses
```

**Emulator not showing up:**
```bash
flutter devices
```

**Build errors:**
```bash
flutter clean
flutter pub get
flutter run
```

## 📄 License

This project is for educational and personal use.

## 🙏 Acknowledgments

Built following best practices from the comprehensive design document in `flutter.md`.
