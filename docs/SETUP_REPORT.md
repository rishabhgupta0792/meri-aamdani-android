# Meri Amdani Flutter Application Setup

A comprehensive plan to set up the Meri Amdani mobile application for gig workers in India, implementing a minimalistic and elegant design with focus on usability and accessibility.

## Automated Environment Setup

I will use Homebrew to install the required tools. This process includes:

1. **Install Flutter SDK**: Using `brew install --cask flutter`
2. **Install Android Studio**: Using `brew install --cask android-studio`
3. **Configure Environment**: Adding Flutter to PATH and accepting licenses
4. **Emulator Setup**: Creating a default Android Virtual Device (AVD)

> [!CAUTION]
> **Performance & Time**
> Downloading and installing these tools involves several gigabytes of data and may take 15-30 minutes depending on your internet speed. I will run these in the background.

> [!IMPORTANT]
> **Manual Intervention**
> You may be asked to provide your macOS password for Homebrew to install casks. Keep an eye on the terminal for password prompts.

## Proposed Changes

### Environment Setup

#### Install Flutter SDK
- Download Flutter SDK for macOS
- Extract to appropriate location (e.g., ~/development/)
- Add Flutter to PATH in ~/.zshrc
- Run `flutter doctor` to verify installation

#### Install Android Studio
- Download Android Studio from official website
- Install Android SDK and command-line tools
- Accept Android licenses
- Configure Android emulator

---

### Flutter Project Structure

#### [NEW] [meri_amdani/](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/)
Create a new Flutter project following the feature-based architecture:

```
meri_amdani/
├── lib/
│   ├── common/         # Shared widgets
│   │   ├── widgets/    # Buttons, Cards, Dialogs
│   │   └── utils/      # Helper functions
│   ├── core/           # App configuration
│   │   ├── constants/  # Colors, Strings
│   │   ├── theme/      # App theme
│   │   └── routes/     # Navigation routes
│   ├── data/           # Data layer
│   │   ├── models/     # Data models
│   │   └── providers/  # Riverpod providers
│   ├── features/       # Feature modules
│   │   ├── dashboard/  # Main dashboard
│   │   ├── jobs/       # Job management
│   │   ├── payments/   # Payment tracking
│   │   └── profile/    # User profile
│   ├── l10n/           # Localization files
│   │   ├── app_en.arb  # English strings
│   │   └── app_hi.arb  # Hindi strings (हिंदी)
│   └── main.dart       # App entry point
├── android/            # Android-specific config
├── assets/             # Images, fonts, icons
└── pubspec.yaml        # Dependencies
```

#### [NEW] [pubspec.yaml](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/pubspec.yaml)
Configure with essential packages (keeping app light):
- **flutter_riverpod** (^2.5.0): State management
- **flutter_localizations**: Internationalization
- **intl** (^0.19.0): Date/number formatting
- **go_router** (^14.0.0): Navigation  
- **google_fonts** (^6.1.0): Typography

---

### Core Configuration

#### [NEW] [core/constants/app_colors.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/core/constants/app_colors.dart)
Define minimalist color palette:
- Primary: Clinical Cyan (#00BCD4)
- Secondary: Trust Blue (#1976D2)
- Success, Warning, Error states
- Light/Dark mode support

#### [NEW] [core/theme/app_theme.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/core/theme/app_theme.dart)
Create clean, accessible theme:
- Typography using Google Fonts (Poppins for English, Noto Sans Devanagari for Hindi)
- 48dp minimum touch targets
- WCAG 2.2 AA color contrast (4.5:1)
- Consistent spacing system

#### [NEW] [l10n/app_en.arb](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/l10n/app_en.arb)
#### [NEW] [l10n/app_hi.arb](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/l10n/app_hi.arb)
Implement bilingual support (English + Hindi) with:
- All UI strings externalized
- Cultural adaptations (₹ currency, date formats)
- Hindi translations for maximum reach

---

### Feature Implementation

#### Dashboard Feature

##### [NEW] [features/dashboard/dashboard_screen.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/features/dashboard/dashboard_screen.dart)
Main screen showing:
- Large, prominent total earnings display
- Visual separation: "Pending" vs "Collected" income
- Maximum 3 quick action buttons
- Bottom navigation bar (Dashboard, Jobs, Payments, Profile)

##### [NEW] [features/dashboard/widgets/earnings_card.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/features/dashboard/widgets/earnings_card.dart)
Earnings visualization with:
- Icon + text labels (never icon alone)
- Large readable fonts
- Semantic labels for screen readers

#### Jobs Feature

##### [NEW] [features/jobs/jobs_screen.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/features/jobs/jobs_screen.dart)
Simple job list with:
- Add, view, edit job functionality
- Clear status indicators (pending/completed)
- Swipe actions for quick edits

#### Payments Feature

##### [NEW] [features/payments/payments_screen.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/features/payments/payments_screen.dart)
Payment tracking with:
- Request payment functionality
- Payment history
- Status updates (pending/received)

---

### Common Widgets

#### [NEW] [common/widgets/app_button.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/common/widgets/app_button.dart)
Reusable button component:
- Large touch targets (48dp minimum)
- Loading state
- Disabled state
- Icon + text support

#### [NEW] [common/widgets/app_card.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/common/widgets/app_card.dart)
Consistent card design:
- Subtle shadows
- Rounded corners
- Proper padding
- Semantic structure

---

### Data Layer

#### [NEW] [data/models/job.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/data/models/job.dart)
Job data model with fields:
- Job title, employer name
- Amount, date
- Payment status
- Notes

#### [NEW] [data/providers/jobs_provider.dart](file:///Users/atulchavan/Repository/meri-amdani/meri_amdani/lib/data/providers/jobs_provider.dart)
Riverpod provider for job state management

## Verification Plan

### Automated Tests

Due to the setup nature of this task, automated tests will be minimal at this stage:

1. **Flutter Doctor Check**
   ```bash
   cd /Users/atulchavan/Repository/meri-amdani/meri_amdani
   flutter doctor -v
   ```
   Should show all checkmarks for Flutter, Android toolchain, and Android Studio.

2. **Project Build Verification**
   ```bash
   cd /Users/atulchavan/Repository/meri-amdani/meri_amdani
   flutter pub get
   flutter analyze
   ```
   Should complete without errors.

3. **Localization Generation**
   ```bash
   cd /Users/atulchavan/Repository/meri-amdani/meri_amdani
   flutter gen-l10n
   ```
   Should generate localization files without errors.

### Manual Verification

1. **Android Emulator Launch**
   - Open Android Studio
   - Launch AVD Manager (Tools > Device Manager)
   - Create/start an Android Virtual Device (any recent Android phone)
   - Verify emulator boots successfully

2. **App Launch on Emulator**
   ```bash
   cd /Users/atulchavan/Repository/meri-amdani/meri_amdani
   flutter devices
   flutter run
   ```
   - App should launch on emulator
   - Should see dashboard screen
   - Bottom navigation should be visible

3. **UI/UX Verification**
   - [ ] Dashboard shows earnings cards clearly
   - [ ] All text is large and readable
   - [ ] Touch targets are at least 48dp (easy to tap)
   - [ ] Icons have accompanying text labels
   - [ ] Bottom navigation works smoothly

4. **Localization Testing**
   - In app settings (or modify main.dart locale temporarily)
   - Switch between English and Hindi
   - Verify all strings translate properly
   - Check for UI overflow with longer Hindi text

5. **Accessibility Testing**
   - Enable TalkBack on Android emulator (Settings > Accessibility > TalkBack)
   - Navigate through app using screen reader
   - Verify all elements have proper semantic labels
   - Test with large font sizes (Settings > Display > Font size)

6. **Performance Check**
   - Navigate between screens
   - Verify smooth 60 FPS animations
   - Check app memory usage (should be <100MB for this simple app)
   - Verify app launch time (<2 seconds on emulator)

### User Testing
After basic functionality is verified, recommend testing with actual users matching target personas:
- Test with users who primarily speak Hindi
- Observe ease of navigation
- Note any confusion points
- Gather feedback on visual clarity
