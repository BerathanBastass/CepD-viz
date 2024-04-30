import 'package:asuka/asuka.dart';
import 'package:cepdovizapp/core%20/bloc/bloc_provider.dart';
import 'package:cepdovizapp/core%20/enums/applocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'feature/bottombar.dart';
import 'feature/settings/gear/cubit/gear_cubit.dart';
import 'feature/settings/gear/cubit/gear_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
          return MaterialApp(
            builder: Asuka.builder,
            navigatorObservers: [Asuka.asukaHeroController],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.indigo,
              ).copyWith(
                secondary: Colors.pinkAccent,
              ),
            ),
            locale: state is ChangeAppLanguage ? Locale(state.languageCode!) : null,
            supportedLocales: const [
              Locale('tr'),
              Locale('en'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null) {
                  if (deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }
              }
              return supportedLocales.first;
            },
            home: Scaffold(
              body: AnimatedSplashScreen(
                nextScreen: const BottomBar(),
                splash: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/apps_logos.png",
                    ),
                    const SizedBox(height: 20),
                    const CircularProgressIndicator(
                      color: Colors.grey,
                      strokeWidth: 10,
                    ),
                  ],
                ),
                splashTransition: SplashTransition.fadeTransition,
                animationDuration: Durations.extralong4,
                duration: 5000,
                splashIconSize: 1000,
                backgroundColor: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}