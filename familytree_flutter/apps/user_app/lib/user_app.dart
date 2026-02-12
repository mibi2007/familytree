import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_package/shared_package.dart' hide ThemeMode;
import 'package:user_app/l10n/app_localizations.dart';

import 'features/auth/view/login_page.dart';
import 'features/home/view/home_page.dart';

class UserApp extends StatelessWidget {
  final String title;
  final Color seedColor;

  const UserApp({super.key, this.title = 'Family Chat', this.seedColor = Colors.deepPurple});

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      // Use computed theme signal (which derives from settingsSignal)
      final themeMode = toFlutterThemeMode(themeModeSignal.value);

      // Compute locale from language signal
      final language = languageSignal.value; // Access computed language signal
      final locale = _toLocale(language);

      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: seedColor)),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark),
        ),
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('vi'), // Vietnamese (Primary - if chosen by user)
          Locale('en'), // English (Secondary)
        ],
        // Logic for system language detection and fallback
        localeResolutionCallback: (locale, supportedLocales) {
          // If the user has specifically chosen a language (passed in `locale`), that is used.
          // This callback is called when `locale` is null (UNSPECIFIED) or when the specific locale is not supported.

          if (locale != null) {
            // Check if the device locale is supported
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale.languageCode) {
                return supportedLocale;
              }
            }
          }

          // If device locale is not supported, or if we just want to default to English:
          // Requirement: "If no language detected, fallback to English"
          return const Locale('en');
        },
        home: const _UserAuthWrapper(),
      );
    });
  }

  Locale? _toLocale(Language lang) {
    switch (lang) {
      case Language.LANGUAGE_EN:
        return const Locale('en');
      case Language.LANGUAGE_VI:
        return const Locale('vi');
      case Language.LANGUAGE_UNSPECIFIED:
      default:
        return null; // Let MaterialApp handle resolution via localeResolutionCallback
    }
  }
}

class _UserAuthWrapper extends StatelessWidget {
  const _UserAuthWrapper();

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      return authUserSignal.value.map(
        data: (user) => user != null ? const HomePage() : const LoginPage(),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (err, __) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Auth Error: $err', textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
    });
  }
}
