import 'package:flutter/material.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';
import 'package:office_flutter_translate_app/constants/strings.dart';
import 'package:office_flutter_translate_app/pages/lets_start_page/lets_start_page.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:office_flutter_translate_app/providers/ads_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  navigateToLetsStartScreen() {
    Navigator.pushReplacementNamed(context, LetsStartPage.routeName);
  }
  AdmobInterstitial interstitialAd;

  test() {
    Future.delayed(Duration(seconds: 2), () {
      navigateToLetsStartScreen();
    });
  }


  @override
  void initState() {
    Provider.of<AdsProvider>(context,listen: false).initAds();
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsIds.interstitialAdsId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) {
          navigateToLetsStartScreen();
        }
        interstitialAd.load();
        //handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd.load();
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      interstitialAd.isLoaded.then((value) {
        if (value) {
          interstitialAd.show();
        } else {
          navigateToLetsStartScreen();
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Strings.splash_screen_bg),
          )
        ),
      ),
    );
  }
}
