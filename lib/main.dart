import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meri_amdani/l10n/app_localizations.dart';
import 'package:meri_amdani/data/providers/auth_provider.dart';
import 'package:meri_amdani/features/auth/language_selection_screen.dart';
import 'package:meri_amdani/features/auth/login_screen.dart';
import 'package:meri_amdani/features/auth/aadhaar_verification_screen.dart';
import 'package:meri_amdani/features/auth/bank_selection_screen.dart';
import 'core/theme/app_theme.dart';
import 'main_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    const ProviderScope(
      child: MeriAmdaniApp(),
    ),
  );
}

class MeriAmdaniApp extends ConsumerWidget {
  const MeriAmdaniApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      title: 'Meri Amdani',
      debugShowCheckedModeBanner: false,
      
      // Theme
      theme: AppTheme.lightTheme,
      
      // Localization
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),  // English
        Locale('hi'),  // Hindi
        Locale('mr'),  // Marathi
      ],
      locale: authState.language != null ? Locale(authState.language!) : null,
      
      // Home
      home: _getHome(authState),
    );
  }

  Widget _getHome(AuthState state) {
    if (state.language == null) {
      return const LanguageSelectionScreen();
    }
    if (state.phoneNumber == null) {
      return const LoginScreen();
    }
    if (!state.isVerified) {
      return const AadhaarVerificationScreen();
    }
    if (state.selectedBank == null) {
      return const BankSelectionScreen();
    }
    return const MainNavigation();
  }
}
