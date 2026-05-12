import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app_clean_architecture/l10n/generated/app_localizations.dart';
import 'package:news_app_clean_architecture/config/routes/routes.dart';
import 'package:news_app_clean_architecture/firebase_options.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'config/theme/app_themes.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  // ...

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WakelockPlus.enable();
  await initializeDependencies();
  await GoogleFonts.pendingFonts([
    GoogleFonts.newsreader(),
    GoogleFonts.newsreader(fontWeight: FontWeight.w500),
    GoogleFonts.newsreader(fontWeight: FontWeight.w600),
    GoogleFonts.newsreader(fontWeight: FontWeight.w700),
    GoogleFonts.workSans(),
    GoogleFonts.workSans(fontWeight: FontWeight.w500),
    GoogleFonts.workSans(fontWeight: FontWeight.w600),
    GoogleFonts.workSans(fontWeight: FontWeight.w700),
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      initialRoute: '/welcome',
    );
  }
}
