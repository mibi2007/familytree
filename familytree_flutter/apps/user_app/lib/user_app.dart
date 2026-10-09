import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_package/shared_package.dart' hide ThemeMode;
import 'package:user_app/l10n/app_localizations.dart';
import 'package:user_app/core/routing/app_router.dart';

class UserApp extends StatelessWidget {
  final String title;
  const UserApp({super.key, this.title = 'Family Chat'});

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      // Use computed theme signal (which derives from settingsSignal)
      final themeMode = toFlutterThemeMode(themeModeSignal.value);

      // Compute locale from language signal
      final language = languageSignal.value; // Access computed language signal
      final locale = _toLocale(language);

      return MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: title,
        theme: MaterialTheme(const TextTheme()).light(),
        darkTheme: MaterialTheme(const TextTheme()).dark(),
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
