import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_application/AppConfigProvider.dart';
import 'package:quran_application/QuranScreen.dart';
import 'package:quran_application/RadioSceen.dart';
import 'package:quran_application/TasbeehScreen.dart';
import 'package:quran_application/HadethScreen.dart';
import 'SplashCustom.dart';
import 'Home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(create: (buildContext) => AppConfigProvider(),
      builder: (buildContext,widget){

        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale.fromSubtags(languageCode: 'en'),
          title: "Quran",
          debugShowCheckedModeBanner: false,
          home: SplashCustom(),
          routes: {
            Home.routeName:(context)=>Home(),
            QuranScreen.routeName:(context)=>QuranScreen(),
            SplashCustom.routeName: (context)=>SplashCustom(),
            TasbeehScreen.routeName: (context)=>TasbeehScreen(),
            HadethScreen.routeName:(context)=>HadethScreen(),
            RadioScreen.routeName:(context)=>RadioScreen(),
          },

        );

      },
    );

  }
}
