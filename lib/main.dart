




import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/app_Colors.dart';
import 'package:office_flutter_translate_app/pages/ads_list_Screen.dart';
import 'package:office_flutter_translate_app/pages/lets_start_page/lets_start_page.dart';
import 'package:office_flutter_translate_app/providers/chat_provider.dart';
import 'package:office_flutter_translate_app/providers/country_currency_provider.dart';
import 'package:office_flutter_translate_app/providers/currency_converter_provider.dart';
import 'package:office_flutter_translate_app/providers/language_provider.dart';
import 'package:office_flutter_translate_app/providers/translate_provider.dart';
import 'package:office_flutter_translate_app/providers/voice_provider.dart';
import 'package:provider/provider.dart';

import 'pages/back_screen/back_screen.dart';
import 'pages/home_page/home_page.dart';
import 'pages/countries_detail_page/countries_detail_home_page.dart';
import 'pages/countries_detail_page/country_home_page.dart';
import 'pages/dictionary_page/dictionary_home_page.dart';
import 'pages/splash_screen/splash_screen.dart';
import 'pages/translate_page/ocr_page/live_translate_page.dart';
import 'pages/translate_page/translate_home_page.dart';
import 'providers/ads_provider.dart';
import 'providers/country_details_provider.dart';
import 'providers/ocr_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AdsProvider()),
    ChangeNotifierProvider(create: (context) => LanguageProvider()),
    ChangeNotifierProvider(create: (context) => CountryCurrencyProvider()),
    ChangeNotifierProvider(create: (context) => TranslateProvider()),
    ChangeNotifierProvider(create: (context) => CurrencyConverterProvider()),
    // ChangeNotifierProvider(create: (context) => VoiceProvider()),
    ChangeNotifierProxyProvider<TranslateProvider, VoiceProvider>(
      create: (context) => VoiceProvider(),
      update: (_, translate, data) => data
        ..updateLanguage(translate.firstLanguage, translate.secondLanguage),
    ),
    ChangeNotifierProxyProvider<TranslateProvider, ChatProvider>(
      create: (context) => ChatProvider(),
      update: (_, language, data) =>
          data..updateLanguage(language.firstLanguage, language.secondLanguage),
    ),
    ChangeNotifierProxyProvider<TranslateProvider, OcrProvider>(
      create: (context) => OcrProvider(),
      update: (_, language, data) =>
          data..updateLanguage(language.firstLanguage, language.secondLanguage),
    ),
    // ChangeNotifierProvider(create: (context) => OcrProvider()),
    ChangeNotifierProvider(create: (context) => CountryDetailsProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
        color: AppColors.appBarColor,
      )),
      initialRoute: '/',
      // home: HomePage(),
      routes: {
        '/': (context) => SplashScreen(),
        '/lets_start_page': (context) => LetsStartPage(),
        '/home_page': (context) => HomePage(),
        '/translate_home_page': (context) => TranslateHomePage(),
        '/live_translate_page': (context) => LiveTranslatePage(),
        '/countries_detail_home_page': (context) => CountriesDetailPage(),
        '/country_home_page': (context) => CountryHomePage(),
        '/dictionary_home_page': (context) => DictionaryHomePage(),
        '/ads_list_screen': (context) => AdsListScreen(),
        '/back_screen': (context) => BackScreen(),
      },
    );
  }
}
