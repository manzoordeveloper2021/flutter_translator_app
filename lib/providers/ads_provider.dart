import 'package:flutter/cupertino.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:office_flutter_translate_app/constants/ads_ids.dart';

class AdsProvider extends ChangeNotifier {
  AdmobInterstitial interstitialAd;

  initAds() {
    interstitialAd = AdmobInterstitial(
      adUnitId: AdsIds.interstitialAdsId,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        // if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );

    interstitialAd.load();
  }

  bool isAdsClosed = false;

  BuildContext screenContext;

  setScreenContext(BuildContext context) {
    this.screenContext = context;
  }

  backScreen() {
    interstitialAd.isLoaded.then((value) {
      if (value) {
        interstitialAd.show();
      } else {
        Navigator.pop(screenContext);
      }
    });
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        // showSnackBar('New Admob $adType Ad loaded!');
        print('Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        // showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        interstitialAd.load();
        backScreen();
        // notifyListeners();
        // showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        print('failed to load. ');
        // backScreen();

        // showSnackBar('Admob $adType failed to load. :(');
        break;
      default:
    }
  }
}
