import 'package:google_mobile_ads/google_mobile_ads.dart';

class GoogleAds {
  InterstitialAd? interstitialAd;
  void loadInterstitialAd({bool showAfterLoad = false}) {
    InterstitialAd.load(
        adUnitId: "ca-app-pub-7553465461791404~9440617923",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
            if (showAfterLoad) {
              showInterstitialAd();
            }
          },
          onAdFailedToLoad: (LoadAdError error) {},
        ));
  }

  void showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd!.show();
    }
  }
}
